//
//  WHSession.h
//  LakeFrontHTML
//
//  Created by William Harford on 29/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


#import "WHMethodCallback.h"
#import "WHStateRegistry.h"
#import "WHRequest.h"
#import "WHArrayCallback.h"


@class WHHtmlCanvas;

@interface WHSession : NSLock {
	NSMutableArray * callbacks;
	
	NSMutableArray * registries;
	WHStateRegistry * currentRegistry;

	id mainComponent;
	WHRequest* lastRequest;
	NSString *key;
	
	NSDate* lastAccess;
	
}

@property (retain) id mainComponent;
@property (retain) WHRequest* lastRequest;
@property (retain) NSString* key;
@property (retain) NSDate* lastAccess;

-(NSString*)url;
-(NSUInteger)maxCallbacks;
-(NSUInteger)newCallbackKey;
-(NSUInteger)maxRegistries;
-(WHMethodCallback*)callbackByKey:(NSUInteger)aKey;
-(NSUInteger)registerCallbackOnObject:(id)anObject withSelector:(SEL)aSelector andArguments:(NSArray*)args;
-(NSUInteger)registerArrayCallbackOnObject:(id)anObject withSelector:(SEL)aSelector arguments:(NSArray*)args andItems:(NSArray*)items;
-(void)registerObject: (id)anObject onKeyPath:(NSString*)aKeyPath;
-(NSUInteger)nextRegistryKey;
-(NSUInteger)currentRegistryKey;
-(WHStateRegistry*)currentRegistry;
-(void)restoreRegistryAtKey:(NSUInteger)key;
-(void)saveCurrentRegistry;

-(NSString*)urlWithCallbackKey:(NSInteger) anInt;
//REquest handeling
-(void)handleRequest;
-(void)processCallback;
-(void)processFormCallbacks ;
-(void)save;

-(NSString*)renderMainOn:(WHHtmlCanvas*) html;

-(NSUInteger)registerBlock: (void (^)()) aBlock ;

-(NSUInteger)registerBlockWithArgument: (void (^)(id argument))aBlock;

@end
