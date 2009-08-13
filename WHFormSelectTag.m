//
//  WHFormSelectTag.m
//  LakeFrontHTML
//
//  Created by William Harford on 19/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHFormSelectTag.h"
#import "WHHtmlCanvas.h"

@implementation WHFormSelectTag

@synthesize labels, nilLabel, selectorForLabels, items, selectedItem;

-(NSString*)tag {
	return @"select";
}

//We Always do 
-(BOOL)needsClose {
	return YES;
}

-(NSString*)labelForObject:(NSObject*)anObject {
	if([labels count] > 0){
		return [labels objectAtIndex:[items indexOfObject:anObject]];
	}
	if(selectorForLabels != nil){
		return [anObject performSelector:selectorForLabels];
	}
	NSString* description = [anObject description];
	return description;
	
}

-(NSString*)tagContent {
	NSString* content = [NSString new];
	NSString* selected;
	for(id item in items){
		if(selectedItem != nil && [item isEqual:selectedItem]){
			selected = @"selected=\"yes\"";
		}else{
			selected = @"";
		}
		NSUInteger index = [items indexOfObject:item];
		if(index == NSNotFound){
			continue;
		}
		content = [NSString stringWithFormat:@"%@<option value=\"%d\"%@>%@</option>",
					content,
				  index,
				   selected,
				   [self labelForObject:item]];
	}
	return content;
}


//A little copy and past from WHFormInputTag (don't kill me)
-(id)callbackOnObject:(id)anObject withSelector:(SEL)aSelector andArguments:(NSArray*)args {
	callbackKey = [self.canvas.session registerArrayCallbackOnObject:anObject
														withSelector:aSelector
														   arguments:args 
															andItems:items];
				   
	[self attributeAt:@"name" put:[NSString stringWithFormat:@"_i-%d", callbackKey]];
	
	return self;
}



@end
