//
//  WHInformDialog.m
//  LakeFrontHTML
//
//  Created by William Harford on 08/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHInformDialog.h"


@implementation WHInformDialog

@synthesize message;

-(WHTag*)renderContentOn:(WHHtmlCanvas*)html{
	WHTag* div = [html tag:@"div"];
	[div addContent:[[html tag:@"h1"] addContent:message]];
	[div addContent:[[[html anchorTag] callbackOnObject:self withSelector:@selector(close) andArguments:nil] with:@"OK"]];
	
	return div;
	
}

@end
