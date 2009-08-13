//
//  WHRequest.h
//  LakeFrontHTML
//
//  Created by William Harford on 01/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "fcgi_config.h"
#import "fcgiapp.h"

@interface WHRequest : NSObject {
	NSMutableDictionary *vars;
	NSString * queryString;
	NSString * postString;
	
	FCGX_Request *fastCgiRequest;

}

@property (retain) NSMutableDictionary *vars;
@property (retain) NSString	*postString;
@property (retain) NSString *queryString;

@property FCGX_Request *fastCgiRequest;

-(void)parseVars;
-(NSString*)requestVarForKey:(NSString*)key;
-(NSString*)sessionKey;
-(BOOL)hasSessionKey;
-(void)setupFromFcgi;
-(void)parseString: (NSString*) aString;
-(NSMutableDictionary*)formCallbackKeysAndValues;
-(BOOL)hasRegistryKey;
-(NSString*)registryKey;

@end
