//
//  WHFormInput.h
//  LakeFrontHTML
//
//  Created by William Harford on 09/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WHTag.h"


@interface WHFormInputTag : WHTag {
	NSString* type;
}
-(id)callbackOnObject:(id)anObject withSelector:(SEL)aSelector andArguments:(NSArray*)args;
-(id)block:(void (^)(id anObject)) aBlock;


@property (retain) NSString* type;

@end
