//
//  WHCallback.h
//  LakeFrontHTML
//
//  Created by William Harford on 25/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WHCallback : NSObject {
	id object;
	SEL selector;
	NSArray* arguments;

	
}

-(id)runWithArguments:(NSArray*)args;
/*
 ** Inserts an argument at the beginning of the list 
 ** and runs this callback
 */
-(id)runWithArgument:(id)anObject ;
-(id)run;
+(WHCallback*)newWithObject:(id)anObject andSelector:(SEL)aSelector;
+(WHCallback*)newWithObject:(id)anObject selector:(SEL)aSelector andArguments:(NSArray*)args;


@property(retain) id object;
@property SEL selector;
@property(retain) NSArray* arguments;


@end
