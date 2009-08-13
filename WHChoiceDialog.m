//
//  WHChoiceDialog.m
//  LakeFrontHTML
//
//  Created by William Harford on 13/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHChoiceDialog.h"


@implementation WHChoiceDialog

-(WHTag*)renderContentOn:(WHHtmlCanvas*)html{
	WHTag* div = [html tag:@"div"];
	WHTag* h1 = [html tag:@"h1"];
	[h1 with:message];
	
	[div addContent:h1];
	
	[div addContent:[self renderButtonFormOn:html]];
	return div;
}

-(WHTag*)renderButtonFormOn:(WHHtmlCanvas*)html {
	WHFormTag* form = [html formTag];
	WHFormInputTag* close = [html formInputTagWithType:@"submit"];
	WHFormInputTag* answer = [html formInputTagWithType:@"submit"];
	
	//Labels should be factored out but you get the point
	[close with:@"NO!"];
	[answer with:@"Yes"];
	
	[close callbackOnObject:self withSelector:@selector(close) andArguments:nil];
	[answer callbackOnObject:self withSelector:@selector(answer:) andArguments:nil];
	
	[form addContent:close];
	[form addContent:answer];
	
	return form;
	
}

@end
