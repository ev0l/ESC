//
//  WHServer.h
//  LakeFrontHTML
//
//  Created by William Harford on 30/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include "fcgi_config.h"
#include "fcgiapp.h"

#import "WHRequest.h"

@class WHSession;


@interface WHApplication : NSLock {
	NSMutableDictionary * sessions;
	
}

@property (retain) NSMutableDictionary* sessions;


-(void)startOnPort:(int)port;
-(void)continueSessionWithRequest:(WHRequest*)request;
-(void)beginSessionWithRequest:(WHRequest*)request;
-(id)newSessionObject;
-(id)newMainComponent;
-(NSUInteger)maxThreads;
-(void)processSessionWithOutLocks:(WHSession *)session withRequest:(WHRequest *)request;

-(void)handleRequest:(FCGX_Request*)fastCgiRequest;
-(NSString*)newSessionKey;
-(id)newCanvas;
-(void)processSession: (WHSession*)session withRequest:(WHRequest*)request;
-(void)startThreadOnSocket:(NSNumber*)socket;
-(void)doneWithRequest:(WHRequest*)request;
-(NSString*)postStringFromRequest:(FCGX_Request*)fastCgiRequest;
-(id)newRoot;
-(NSInteger)maxSessions;
-(void)removeOldestSession;
-(void)addSession:(WHSession*) session;

//The date time that session should be expired
//This should be in the past
//Sessions might be older than this but this serves as a 
// reference for cleanup
-(NSDate*)sessionExpireDate;
-(void)expireSessions;

@end
