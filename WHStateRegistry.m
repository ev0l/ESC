//
//  untitled.m
//  LakeFrontHTML
//
//  Created by William Harford on 28/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHStateRegistry.h"
#import "WHRegisteredObject.h"

@implementation WHStateRegistry

@synthesize registeredObjects;

-(id)init{
	self = [super init];
	if(self != nil){
		registeredObjects = [NSMutableArray new];
	}
	return self;
}

-(void)registerObject:(id)anObject onKeyPath:(NSString*)aKeyPath{
	WHRegisteredObject* registeredObject = [WHRegisteredObject new];
	registeredObject.keyPath = aKeyPath;
	registeredObject.onObject = anObject;
	[registeredObject deriveValue];
	[registeredObjects addObject:registeredObject];
	
}

-(void)restoreState {
	for(WHStateRegistry* object in registeredObjects){
		[object restoreState];
	}
}

-(void)saveState {
	NSMutableArray* iArray = [NSMutableArray arrayWithArray:registeredObjects];
	
	for(WHStateRegistry* object in iArray){
		[registeredObjects replaceObjectAtIndex:[registeredObjects indexOfObject:object] withObject:[object copy]];
		
	}
	
	
}

-(id) copyWithZone:(NSZone*)zone{
	WHStateRegistry* newish = [[[self class] allocWithZone:zone] init];
	newish.registeredObjects = [self.registeredObjects mutableCopy];
	[newish saveState];
	return newish;
}


@end
