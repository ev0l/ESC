//
//  WHFormExample.m
//  LakeFrontHTML
//
//  Created by William Harford on 21/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHFormExample.h"
#import "WHFormSelectTag.h"
#import "WHHtmlCanvas.h"

@implementation WHFormExample

@synthesize firstName, lastName, sex;

-(id)init{
	self = [super init];
	if(self != nil){
		lastName = @"";
		firstName = @"%";
		sex = @"";
	}
	return self;
}

-(NSArray*)sexes {
	return [NSArray arrayWithObjects: @"Male", @"Female", @"Yea Baby!", nil];
}

-(WHFormSelectTag*)renderSelectButtonOn:(WHHtmlCanvas*)html {
	WHFormSelectTag* select = [html select];
	select.items = [self sexes];
	[select callbackOnObject:self withSelector:@selector(setSex:) andArguments:nil];
	[select setSelectedItem:sex];

	return select;
	
}

//THis is just to show that even submit buttons give you valued
-(void)submitButton:(id)value {
	
}


-(void)setFirstName:(NSString*)value {
	firstName = value;
}

-(WHTag*)renderContentOn:(WHHtmlCanvas*)html {
	WHTag* h1 = [html tag:@"h1"];
	
	[h1 text:[NSString stringWithFormat:@"%@ %@ - %@",firstName, lastName, sex]];
	
	WHFormTag* form = [html formTag];
	WHFormInputTag* firstNameTag = [html formInputTagWithType:@"text"];
	[firstNameTag callbackOnObject:self withSelector:@selector(setFirstName:) andArguments:nil];
	[firstNameTag with:firstName];
	
	WHFormInputTag* lastNameTag = [html formInputTagWithType:@"text"];
	[lastNameTag callbackOnObject:self withSelector:@selector(setLastName:) andArguments:nil];
	[lastNameTag with:lastName];
	
	WHFormInputTag* submit = [html formInputTagWithType:@"submit"];
	[submit callbackOnObject:self withSelector:@selector(submitButton:)	andArguments:nil];
	
	[form addContent:h1];
	
	[form addContent:@"First Name: "];
	[form addContent:firstNameTag];
	[form addContent:[html br]];
	
	
	[form addContent:@"Last Name: "];
	[form addContent:lastNameTag];
	[form addContent:[html br]];
	
	[form addContent:@"Sex: "];
	[form addContent:[self renderSelectButtonOn:html]];
	[form addContent:[html br]];
	
	[form addContent:submit];
	
	return form;
	
	
}

@end
