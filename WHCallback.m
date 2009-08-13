//
//  WHCallback.m
//  LakeFrontHTML
//
//  Created by William Harford on 25/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHCallback.h"


@implementation WHCallback

@synthesize object, selector, arguments;


+(WHCallback*)newWithObject:(id)anObject andSelector:(SEL)aSelector{
	WHCallback* callback = [self new];
	[callback setObject:anObject];
	callback.selector = aSelector;
	return callback;
}

+(WHCallback*)newWithObject:(id)anObject selector:(SEL)aSelector andArguments:(NSArray*)args{
	WHCallback* callback = [WHCallback newWithObject:anObject andSelector:aSelector];
	callback.arguments = args;
	return callback;
}
	

-(id)init{
	self = [super init];
	if(self != nil){
		arguments = [NSArray new];
	}
	return self;
}


-(id)runWithArguments:(NSArray*)args{
	arguments = args;
	return [self run];
}

/*
 ** Inserts an argument at the beginning of the list 
 ** and runs this callback
 */
-(id)runWithArgument:(id)anObject {
	NSMutableArray *args = [NSMutableArray arrayWithArray:arguments];
	[args insertObject:anObject atIndex:0];
	return [self runWithArguments:args];
}


//REFACTOR WAY TO LONG
-(id)run{
	
	NSMethodSignature * sig = nil;
	sig = [object methodSignatureForSelector:selector];
	
	NSInvocation * myInvocation = nil;
	myInvocation = [NSInvocation invocationWithMethodSignature:sig];
	[myInvocation setTarget:object];
	[myInvocation setSelector:selector];
	
	int counter = 2;
	
	//If we take no argument just run this sucker
	if(([sig numberOfArguments] - 2) != 0){
		
		//What were you thinking
		if(([sig numberOfArguments] - 2) != [arguments count]){
			NSLog(@"Callback did not run because of argument count mismatch."
					"You likely don't want this but it is better than crashing");
			
			return nil;
		}
		
		for(id arg in arguments){
			[myInvocation setArgument:&arg atIndex:counter];
			counter++;
		}
	}
	
	NSString* result = nil;	
	[myInvocation retainArguments];	
	[myInvocation invoke];
	//Don't crash if we return void
	if([sig methodReturnLength] > 0){
		[myInvocation getReturnValue:&result];
	}
	return result;
}


@end
