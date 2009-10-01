//
//  WHFormInput.m
//  LakeFrontHTML
//
//  Created by William Harford on 09/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHFormInputTag.h"
#import "WHSession.h"
#import "WHHtmlCanvas.h"

@implementation WHFormInputTag

@synthesize type;

-(NSString*)tag {
	return @"input";
}

-(void)setType:(NSString*)aType {
	type = aType;
	[self attributeAt:@"type" put:aType];
}

-(void)postCallbackSetup{
	
	[self attributeAt:@"name" put:[NSString stringWithFormat:@"_i-%d", callbackKey]];
	
}	

-(id)callbackOnObject:(id)anObject withSelector:(SEL)aSelector andArguments:(NSArray*)args {
	[self registerCallbackOnObject:anObject withSelector:aSelector andArguments:args];
	return self;
}

-(id)with:(NSString*)aValue{
	[self attributeAt:@"value" put:aValue];
	return self;
}

-(id)block:(void (^)(id anObject)) aBlock{
	[self registerBlockWithArgument: aBlock];
	[self postCallbackSetup];
	return self;
}


@end
