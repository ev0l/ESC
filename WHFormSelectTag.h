//
//  WHFormSelectTag.h
//  LakeFrontHTML
//
//  Created by William Harford on 19/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WHTag.h"

@interface WHFormSelectTag : WHTag {
	
	NSArray* labels;
	NSString* nilLabel;
	SEL selectorForLabels;
	
	
	NSArray* items;
	id selectedItem;
	
}

//You can set the labels for the items explicitly
@property (retain) NSArray* labels;

//You can give the unselected nil values a label
@property (retain) NSString* nilLabel;

//You can ask the tag to call a selector on the items for the label
//This selector take no arguments and should return a string
@property SEL selectorForLabels;

//The items that can be selected
@property (retain) NSArray* items;

//The default item
@property (retain) id selectedItem;

//This select needs to be completly setup before you set it's callback
-(id)callbackOnObject:(id)anObject withSelector:(SEL)aSelector andArguments:(NSArray*)args;


@end
