//
//  WHHTML.m
//  LakeFrontHTML
//
//  Created by William Harford on 23/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHHtmlCanvas.h"
#import "WHAnchorTag.h"
#import "WHFormTag.h"
#import "WHFormSelectTag.h"
#import "WHComponent.h"
#import <Foundation/NSObject.h>


@implementation WHHtmlCanvas

@synthesize session;

-(WHGenericTag*)tag:(NSString*) aString {
	WHGenericTag* tag = [WHGenericTag new];
	tag.canvas = self;
	[tag setTag:aString];
	return tag;
}

-(WHAnchorTag*)anchorTag {
	WHAnchorTag* tag = [WHAnchorTag new];
	tag.canvas = self;
	return tag;
}

-(WHFormTag*)formTag {
	WHFormTag* tag = [WHFormTag new];
	tag.canvas = self;
	return tag;
}

-(WHFormInputTag*)formInputTagWithType:(NSString*)aType {
	WHFormInputTag* tag = [WHFormInputTag new];
	tag.type = aType;
	tag.canvas = self;
	return tag;
}

-(WHFormSelectTag*)select {
	WHFormSelectTag* tag = [WHFormSelectTag new];
	tag.canvas = self;
	return tag;
}

-(WHTagCollection*)collection {
	return [WHTagCollection new];
}

-(WHTag*)br {
	return [self tag:@"br"];
}

-(id)render:(id)aComponent {
	if([aComponent session] == nil){
		[aComponent setSession:session];
	}
	
	
	
	return [aComponent renderOn:self];
}

@end
