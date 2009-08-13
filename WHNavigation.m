//
//  WHNavigation.m
//  LakeFrontHTML
//
//  Created by William Harford on 23/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHNavigation.h"


@implementation WHNavigation

@synthesize selection;

-(id)init {
	self = [super init];
	if(self != nil){
		components = [NSMutableArray new];
		labels = [NSMutableArray new];
	}
	return self;
}

-(NSArray*)children {
	if(selection == nil){
		return [NSArray new];
	}
	return [NSArray arrayWithObject:selection];
}

-(void)addComponent:(id)aComponent withLabel:(NSString*)aString {
	[components addObject:aComponent];
	[labels addObject:aString];
}

-(NSString*)labelForComponent:(id)aComponent {
	NSUInteger key = [components indexOfObject:aComponent];
	
	if(key == NSNotFound){
		return @"";
	}
	return [labels objectAtIndex:key];
	
}

-(WHTag*)renderContentOn:(WHHtmlCanvas*)html {

	WHTag* optionsDiv = [html tag:@"div"];
	[optionsDiv attributeAt:@"class" put:@"navigation-options"];
	[optionsDiv addContent:[self renderOptionsOn:html]];
	
	
	WHTag* contentDiv = [html tag:@"div"];
	[contentDiv attributeAt:@"class" put:@"navigation-content"];
	[contentDiv addContent:[self renderSelectionOn:html]];
	
	
	WHTag* kalsey = [html tag:@"div"];
	[kalsey attributeAt:@"class" put:@"kalsey"];
	
	[kalsey addContent:optionsDiv];
	[kalsey addContent:contentDiv];
	
	return kalsey;
}

-(WHTag*)renderOptionsOn:(WHHtmlCanvas*)html {
	WHTag* ul = [html tag:@"ul"];
	for(id component in components){
		[ul addContent:[self renderOptionOn:html forComponent:component]];
	}
	return ul;
}

-(WHTag*)renderOptionOn:(WHHtmlCanvas*)html forComponent:(id)aComponent {
	WHTag* label = [self renderComponentLabelOn:html forComponent:aComponent];
	WHTag* li = [html tag:@"li"];
	[li addContent:label];
	if(aComponent == selection){
		[li attributeAt:@"class" put:@"option option-selected"];
	}else{
		[li attributeAt:@"class" put:@"option"];
	}
	return li;
}

-(WHTag*)renderComponentLabelOn:(WHHtmlCanvas*)html forComponent:(id)aComponent {

	WHAnchorTag* link = [html anchorTag];
	[link attributeAt:@"class" put:@"whnavigation-link"];
	[link callbackOnObject:self withSelector:@selector(setSelection:) andArguments:[NSArray arrayWithObject:aComponent]];
	[link text:[self labelForComponent:aComponent]];
	return link;
}

-(WHTag*)renderSelectionOn:(WHHtmlCanvas*)html {
	return [html render:selection];
}

@end
