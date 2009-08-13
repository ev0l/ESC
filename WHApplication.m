//
//  WHServer.m
//  LakeFrontHTML
//
//  Created by William Harford on 30/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHApplication.h"
#import "WHComponent.h"
#import "WHSession.h"
#import "WHHtmlRoot.h"


#define randommacro() (arc4random() % ((unsigned)RAND_MAX + 1))

@implementation WHApplication

@synthesize sessions;


-(id)init {
	self = [super init];
	if(self != nil){
		sessions = [NSMutableDictionary new];
	}
	return self;
}


-(NSUInteger)maxThreads {
	return 10;
}


-(void)startOnPort:(int)port {
	FCGX_Init();
	int i,listen_socket;
	
	listen_socket = FCGX_OpenSocket([[NSString stringWithFormat:@":%d",port] UTF8String], 100); 
	FCGX_Init(); 

	for (i = 2 /*This thred with be the last*/; i < [self maxThreads]; i++){
		
		[NSThread detachNewThreadSelector:@selector(startThreadOnSocket:) toTarget:self withObject:[NSNumber numberWithInt:listen_socket]];
	}
	[self startThreadOnSocket:[NSNumber	numberWithInt:listen_socket]];
	
}

-(void)startThreadOnSocket:(NSNumber*)aSocket {
	int socket = [aSocket intValue];
	
	FCGX_Request fastCgiRequest;
	int fastCgiRequestID;
	FCGX_InitRequest(&fastCgiRequest, socket, 0);
    while(YES){
		[self lock];
		fastCgiRequestID = FCGX_Accept_r(&fastCgiRequest);
		[self unlock];
		if(fastCgiRequestID < 0){
			NSLog(@"Some sort of system error happend. FCGX_Accept_r returned < 0");
			break;
		}
		[self handleRequest:&fastCgiRequest];
		
	}
}




-(NSString*)newSessionKey {
	NSTimeInterval date = [[NSDate date] timeIntervalSince1970];
	int random = randommacro();
	return [NSString stringWithFormat:@"%d%d",abs(random),abs(date)];
	
}

-(void)handleRequest:(FCGX_Request*)fastCgiRequest {
	WHRequest* request = [WHRequest new];
	request.fastCgiRequest = fastCgiRequest;
	[request setQueryString:[NSString stringWithUTF8String:FCGX_GetParam("QUERY_STRING", fastCgiRequest->envp)]];
	request.postString = [self postStringFromRequest:fastCgiRequest];
	
	[request parseVars];
	if([request hasSessionKey]){
		[self continueSessionWithRequest:request];
	}else{
		[self beginSessionWithRequest:request];
	}
}

-(NSString*)postStringFromRequest:(FCGX_Request*)fastCgiRequest {
	char *lenstr;
	long len;
	char *post;
	lenstr = FCGX_GetParam("CONTENT_LENGTH", fastCgiRequest->envp);
	if(lenstr == NULL || sscanf(lenstr,"%ld",&len)!=1){
		return [NSString new];
	}
	
	post = malloc(len);
	FCGX_GetStr(post, len, fastCgiRequest->in);
	//The above funciton does not null terminate 
	// CAN YOU BELEIVE THAT, IT SHOULD BE CALL 
	// FCGX_GetFucked
	post[len] = '\0';
	
	NSString* retVal = [NSString stringWithUTF8String:post];
	free(post);
	return retVal;
}
-(void)expireSessions {
	//Not sure I need to do this but it seams like a good idea
	// My fear is that something gets mutated in 
	// the sesions array while I am looping
	[self lock];
	NSDate* referenceDate = [self sessionExpireDate];
	NSMutableArray* deleteKeys = [NSMutableArray new];
	for (id sessionKey in sessions){
		WHSession* session = [sessions objectForKey:sessionKey]; 
		if([session.lastAccess timeIntervalSinceDate: referenceDate] < -1){
			
			//Just like that. Garbage collected like litter in china town
			[deleteKeys addObject:[[sessions allKeysForObject:session] objectAtIndex:0]];
			
		}
	}
	[sessions removeObjectsForKeys:deleteKeys];
	[self unlock];
}
			
-(void)makeRoomForSession {
	if([sessions count] >= [self maxSessions]){
		//Try expiring first
		[self expireSessions];
		//We must make room
		if([sessions count] >= [self maxSessions]){
			[self removeOldestSession];
		}
	}
	
}

-(void)removeOldestSession {
	WHSession* oldest = nil;
	
	for(id sKey in sessions){
		WHSession* compSession = [sessions objectForKey:sKey];
		if(oldest == nil){
			oldest = compSession;
		}else{
			if([oldest.lastAccess timeIntervalSinceDate: compSession.lastAccess] > 0){
				oldest = compSession;
			}
		}
		 
	}
	 
	if(oldest != nil){
		id key = [[sessions allKeysForObject:oldest] objectAtIndex:0];
		[sessions removeObjectForKey:key];
	}
	
	
}

-(void)beginSessionWithRequest:(WHRequest*)request{
	
	WHSession* session = [self newSessionObject];
	session.mainComponent = [self newMainComponent];
	session.lastRequest = request;
	session.key = [self newSessionKey];
	[session.mainComponent setSession:session];
	[self makeRoomForSession];
	[sessions setObject:session	forKey:session.key];
	//Some day
	//[NSThread detachNewThreadSelector: @selector(processSession:) toTarget:self withObject: session];
	[self processSession:session withRequest:request];
}


-(void)continueSessionWithRequest:(WHRequest*)request{
	WHSession* session = [sessions objectForKey:[request sessionKey]];
	if(session == nil){
		[self beginSessionWithRequest:request];
	}else{
		[self processSession:session withRequest:request];
	}
}

//THis method is getting a little long FIXME
-(void)processSession: (WHSession*)session withRequest:(WHRequest*)request {
	[session lock];
	session.lastRequest = request;
	[session handleRequest];
	id canvas = [self newCanvas];
	[canvas setSession:session];
	WHHtmlRoot* htmlRoot = [self newRoot];
	[session.mainComponent updateRootAndChildren:htmlRoot];
	
	id contentTag = [htmlRoot renderDocumentOn:canvas withContent:[session renderMainOn:canvas]];
	NSString* content = [contentTag description];
	
	FCGX_FPrintF(session.lastRequest.fastCgiRequest->out,"Accept-Charset: utf-8;\r\n");
	FCGX_FPrintF(session.lastRequest.fastCgiRequest->out,"Content-Length: %d\r\n",[content length]);	
	FCGX_FPrintF(session.lastRequest.fastCgiRequest->out,"Content-Type: ");
	
	FCGX_FPrintF(session.lastRequest.fastCgiRequest->out, "%s; charset=UTF-8\r\n\r\n",[[htmlRoot mimeType] UTF8String]);
	content = [content stringByReplacingOccurrencesOfString:@"%" withString:@"%%" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [content length])];
	
	FCGX_FPrintF(session.lastRequest.fastCgiRequest->out,[content UTF8String]);
	[self doneWithRequest:request];
	[session save];
	[session unlock];
}



-(void)doneWithRequest:(WHRequest*)request {
	FCGX_Finish_r(request.fastCgiRequest);
}


-(id)newCanvas {
	return [WHHtmlCanvas new];
}

-(id)newMainComponent {
	return [WHComponent new];
	
}

-(id)newRoot {
	return [WHHtmlRoot new];
}

-(id)newSessionObject {

	
	WHSession * session = [WHSession new];
	return session;
}

-(NSInteger)maxSessions {
	return 5000;
}

-(NSDate*)sessionExpireDate {
	return [NSDate dateWithTimeIntervalSinceNow:-28800/*8 hours*/];
	
}

@end
