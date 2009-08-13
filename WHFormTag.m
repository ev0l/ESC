//
//  WHFormTag.m
//  LakeFrontHTML
//
//  Created by William Harford on 09/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHFormTag.h"
#import "WHHtmlCanvas.h"
#import "WHSession.h"

@implementation WHFormTag

-(NSString*)tag {
	return @"form";
}

//Oh no we didn't
//I am not sure I care for this approach
-(void)setCanvas:(WHHtmlCanvas*) aCanvas {
	[super setCanvas: aCanvas];
	[self attributeAt:@"method" put:@"POST"];
	[self attributeAt:@"action" put:[[aCanvas session] url]];
	
}

@end
