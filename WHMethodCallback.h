//
//  WHCallback.h
//  LakeFrontHTML
//
//  Created by William Harford on 25/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHCallback.h"

@interface WHMethodCallback : WHCallback {
	id object;
	SEL selector;
	NSArray* arguments;
	
}



+(WHMethodCallback*)newWithObject:(id)anObject andSelector:(SEL)aSelector;
+(WHMethodCallback*)newWithObject:(id)anObject selector:(SEL)aSelector andArguments:(NSArray*)args;


@property(retain) id object;
@property SEL selector;
@property(retain) NSArray* arguments;


@end
