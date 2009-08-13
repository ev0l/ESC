//
//  WHSession.m
//  LakeFrontHTML
//
//  Created by William Harford on 29/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHSession.h"
#import "WHHtmlCanvas.h"
#import "WHComponent.h"

//REFACTOR make callbacks and currentRegistries dictionaries ?
//Or we could compact these arrays and add a factor to the 
// keys

@implementation WHSession


@synthesize mainComponent;
@synthesize lastRequest;
@synthesize key;
@synthesize lastAccess;

-(id)init{
	self = [super init];
	if(self != nil){
		callbacks = [NSMutableArray new];
		registries = [NSMutableArray new];
		currentRegistry = [WHStateRegistry new];
		[registries addObject:currentRegistry];
		lastAccess = [NSDate date];
	}
	return self;
}

-(NSUInteger)maxCallbacks{
	return 1000;
}

-(NSUInteger)newCallbackKey{
	if([self maxCallbacks] <= [callbacks count]){
		//Put self in the place becuase we have already
		// given out the keys
		// we might want to refactor to use a dictionay for more efficent
		// storage ? (NSArray might still be a better use of space)
		[callbacks replaceObjectAtIndex:([callbacks count]-[self maxCallbacks])
							 withObject:[NSNull new]];
	}
	
	return [callbacks count];
		 
}

-(WHCallback*)callbackByKey:(NSUInteger)aKey{
	if([callbacks count] <= aKey){
		return nil;
	}
	return [callbacks objectAtIndex:aKey];
	
}


-(NSUInteger)registerArrayCallbackOnObject:(id)anObject withSelector:(SEL)aSelector arguments:(NSArray*)args andItems:(NSArray*)items {
	WHArrayCallback* callback;
	callback = [WHArrayCallback newWithObject:anObject selector:aSelector andArray:items];
	callback.arguments = args; 
	
	NSUInteger nextKey = [self newCallbackKey];
	[callbacks addObject:callback];
	return nextKey; 
	
}

-(NSUInteger)registerCallbackOnObject:(id)anObject withSelector:(SEL)aSelector andArguments:(NSArray*)args{
	WHCallback* callback;
	callback = [WHCallback newWithObject:anObject andSelector:aSelector];
	callback.arguments = args;
	
	NSUInteger nextKey = [self newCallbackKey];
	
	[callbacks addObject:callback];
	return nextKey; 
	
}


-(NSUInteger)nextRegistryKey {
	return [registries count];
}

-(NSUInteger)currentRegistryKey{
	NSUInteger rkey = [registries indexOfObject:currentRegistry];
	return rkey;
}

-(WHStateRegistry*)currentRegistry{
	return currentRegistry;
}

-(void)registerObject: (id)anObject onKeyPath:(NSString*)aKeyPath {
	[currentRegistry registerObject:anObject onKeyPath:aKeyPath];
	
}

-(void)restoreRegistry {
	if(![lastRequest hasRegistryKey]){
		return;
	}
	NSString* stringKey = [lastRequest registryKey];
	
	NSUInteger rkey = [stringKey intValue];

	[self restoreRegistryAtKey:rkey];
	
	
}

-(void)restoreRegistryAtKey:(NSUInteger)aKey{
	if([registries count] <= aKey){
		return;
	}
	WHStateRegistry* res = [registries objectAtIndex:aKey];
	if((NSObject*)res != self){
		currentRegistry = res;
		[currentRegistry restoreState];
	}
}

-(void)saveCurrentRegistry {
	if([self maxRegistries] <= [registries count]){
		[registries insertObject:[NSNull new] atIndex:([registries count] - [self maxRegistries])];
	}
	WHStateRegistry* newReg = [currentRegistry copy];
	[registries addObject:newReg];
	currentRegistry = newReg;
}


-(void)save {
	
}

-(NSUInteger)maxRegistries{
	return 50;
}

-(void)handleRequest {
	[self restoreRegistry];
	[self processCallback];
	[self processFormCallbacks];
	[self saveCurrentRegistry];
	
	lastAccess = [NSDate date];
}

-(void)processCallback {
	NSString* callbackKey;

	if(callbackKey = [[self lastRequest] requestVarForKey:@"_k"]){
		[[self callbackByKey:[callbackKey intValue]] run];
	}
	
}

-(void)processFormCallbacks {
	NSMutableDictionary* formCallbacks = [[self lastRequest] formCallbackKeysAndValues];
	
	for(NSString* callbackKey in formCallbacks){
		[[self callbackByKey:[callbackKey intValue]] runWithArgument:[formCallbacks objectForKey:callbackKey]];
	}
}



-(NSString*)url{
	return [NSString stringWithFormat:@"?_s=%@&_r=%d",key,[self currentRegistryKey]] ;
}

-(NSString*)urlWithCallbackKey:(NSInteger) anInt{
	NSString* string = [NSString stringWithFormat:@"%@%@_k=%d",[self url],@"&",anInt];
	return string; 
}

-(NSString*)renderMainOn:(WHHtmlCanvas*) html {
	return [[mainComponent renderOn:html] description];
}

@end
