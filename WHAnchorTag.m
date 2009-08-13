//
//  WHAnchorTag.m
//  LakeFrontHTML
//
//  Created by William Harford on 05/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHAnchorTag.h"
#import "WHHtmlCanvas.h"

@implementation WHAnchorTag

-(NSString*)tag{
	return @"a";
}

-(id)callbackOnObject:(id)anObject withSelector:(SEL)aSelector andArguments:(NSArray*)args {
	[self registerCallbackOnObject:anObject withSelector:aSelector andArguments:args];
	NSString* href = [self.canvas.session urlWithCallbackKey:callbackKey];
	if(href != nil){
		[self attributeAt:@"href" put:href];	
	}
	return self;
}


@end
