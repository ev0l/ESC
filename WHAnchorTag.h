//
//  WHAnchorTag.h
//  LakeFrontHTML
//
//  Created by William Harford on 05/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WHTag.h"

@interface WHAnchorTag : WHTag {

}

-(id)callbackOnObject:(id)anObject withSelector:(SEL)aSelector andArguments:(NSArray*)args;
-(id)block:(void (^)()) aBlock;

@end
