//
//  WHGCDApplication.m
//  ESC
//
//  Created by William Harford on 09-09-24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHGCDApplication.h"
#import "WHDispachQueue.h"

@implementation WHGCDApplication

-(id)init{
	self = [super init];
	if(self != nil){
		sessionLifeQueue = dispatch_queue_create("org.harford.LakeFront.sessionLife", NULL);
		queues = [NSMutableDictionary new];
	}
	return self;
	
}

-(void)startOnPort:(int)port {
	
	FCGX_Init();
	int socket;
	socket = FCGX_OpenSocket([[NSString stringWithFormat:@":%d",port] UTF8String], 100); 
	FCGX_Init(); 
	
	

	while(YES){
		FCGX_Request *fastCgiRequest;
		int fastCgiRequestID;
		fastCgiRequest = malloc(sizeof(FCGX_Request));
		
		FCGX_InitRequest(fastCgiRequest, socket, 0);
		
		fastCgiRequestID = FCGX_Accept_r(fastCgiRequest);
		if(fastCgiRequestID < 0){
			NSLog(@"Some sort of system error happend. FCGX_Accept_r returned < 0");
			break;
		}
		dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
		
		dispatch_async(aQueue, ^{
			[self handleRequest:fastCgiRequest];
		});
	}
	
}

-(void)expireSessions {

	dispatch_sync(sessionLifeQueue, ^{[super expireSessions];});
}


-(void)removeOldestSession {
	dispatch_sync(sessionLifeQueue, ^{[super removeOldestSession];});

}

-(void)addSession:session {
	dispatch_sync(sessionLifeQueue, ^{[super addSession:session];});
}

-(void)processSession: (WHSession*)session withRequest:(WHRequest*)request {

	dispatch_async(sessionLifeQueue, ^{
		dispatch_queue_t queueForSession = NULL;
		queueForSession = [self queueForSession:session];
		dispatch_async(queueForSession, ^{
			[self processSessionWithOutLocks:session withRequest:request];
			
		});
	});
	 
	
}

-(void)doneWithRequest: (WHRequest*)request{
	[super doneWithRequest:request];
	free(request.fastCgiRequest);
	
}

-(void)processSessionWithOutLocks:(WHSession *)session withRequest:(WHRequest *)request{
	[super processSessionWithOutLocks:session withRequest:request];
	dispatch_async(sessionLifeQueue, ^{
		[self releaseQueueForSession:session];
	});
}

-(dispatch_queue_t)queueForSession:(WHSession*)aSession {
	WHDispachQueue* queue = [queues objectForKey:[NSNumber numberWithInt:(int)aSession]];
	if(queue == nil){
		
		queue = [WHDispachQueue new];
		queue.queue = dispatch_queue_create(NULL, NULL);
		
		[queues setObject:queue forKey:[NSNumber numberWithInt:(int)aSession]];
	}
	dispatch_retain(queue.queue);
	return queue.queue;
}

-(void)releaseQueueForSession:(WHSession*)aSession {
	WHDispachQueue* queue = [queues objectForKey:[NSNumber numberWithInt:(int)aSession]];
	if(queue == nil){
		NSLog(@"This is very strange. We should have a queue here");
		return;
	}
	queue.retainCount--;
	if(queue.retainCount <= 0){
		[queues removeObjectForKey:[NSNumber numberWithInt:(int)aSession]];
	}
	dispatch_release(queue.queue);
	
}

@end
