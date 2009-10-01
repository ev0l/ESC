//
//  WHFormCounter.m
//  LakeFrontHTML
//
//  Created by William Harford on 09/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHFormCounter.h"
#import "WHFormTag.h"

@implementation WHFormCounter

-(id)setCount:(NSString*)aStringCount {
	counter = [NSNumber numberWithInt:[aStringCount integerValue]];
	if(counter == 0){
		NSLog(@"%@",aStringCount);
	}
	return self;
}

//Total copy and paste ICK!
-(id)renderContentOn:(WHHtmlCanvas*)html {
	
	WHGenericTag* div = [html tag:@"div"];
	
	
	[div addContent:[[html tag:@"h1"] with:[NSString stringWithFormat:@"%d",[counter intValue]]]];
	
	WHFormTag *form = [html formTag];
	
	WHFormInputTag* plusInput = (WHFormInputTag*)[[[html formInputTagWithType:@"submit"] 
																		block:
																		^(id aCount){
																				
																			[self setCount:aCount];
																		} ]
																		with:@"++"];
	
	
	[plusInput attributeAt:@"value" put:[NSString stringWithFormat:@"%d",([counter intValue] + 1 )]];
	
	[form addContent:plusInput];
	
	
	WHFormInputTag* minusInput = (WHFormInputTag*)[[[html formInputTagWithType:@"submit"] callbackOnObject:self 
																			withSelector:@selector(setCount:) 
																			andArguments:nil]
								 with:@"--"];
	
	[minusInput attributeAt:@"value" put:[NSString stringWithFormat:@"%d",([counter intValue] - 1 )]];
	
	[form addContent:minusInput];

	[self addInputToTag:div withHtml:html];
	[div addContent:form];
	
	
	return div;
}

-(void)addInputToTag:(id)aTag withHtml:(WHHtmlCanvas*) html{
	WHFormInputTag* input = [html formInputTagWithType:@"text"];
	
	WHFormTag* tag = [html formTag];
	
	
	
	[input block:^(id count){[self setCount:count];}];
	[tag addContent:input];
	
	WHFormInputTag* submit = [html formInputTagWithType:@"submit"];
	[tag addContent:submit];
	
	
	[aTag addContent:tag];
}
	


@end
