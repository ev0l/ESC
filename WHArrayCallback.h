//
//  WHCollectionCallback.h
//  LakeFrontHTML
//
//  Created by William Harford on 28/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WHMethodCallback.h"

@interface WHArrayCallback : WHMethodCallback {
	NSArray * items; /*a group of items that can be 
								** Passed as an arg to the callback */
}

@property (retain) NSArray* items;
-(id)objectForKey:(NSUInteger)key;

//THE ARGUMENT TYPE IS DIFFRENT FROM THE PARENT
-(id)runWithArgument:(NSNumber*)aNumber; 

+(id)newWithObject:(id)anObject selector:(SEL)aSelector andArray:(NSArray*) anArray;

@end
