//
//  WHCounter.m
//  LakeFrontHTML
//
//  Created by William Harford on 05/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHCounter.h"
#import "WHTagCollection.h"
#import "WHChoiceDialog.h"

@implementation WHCounter




-(void)setCounter:(NSNumber*) aNumber{
	counter = [aNumber copy];
}

-(NSNumber*)counter {
	NSNumber* newCounter = [NSNumber numberWithInt:[counter intValue]];
	return newCounter;
}

-(id)init{
	self = [super init];
	if(self != nil){
		counter = [NSNumber numberWithInt:0];
	}
	return self;
}

-(void)answerObject:(id)iDoNotCare setCounter:(NSNumber*)aNumber{
	counter = aNumber;

}

-(id)add {
	counter = [NSNumber numberWithInt:([counter intValue] +1)];
	
	return self;
}

-(id)subtract{
	if([counter intValue] == 0){
		WHChoiceDialog* theDialog = [WHChoiceDialog new];
		theDialog.message = @"You are about to go below 0";
		NSNumber* aNumber = [NSNumber numberWithInt:([counter intValue]-1)];
		NSArray* args = [NSArray arrayWithObjects:aNumber, nil];
		
		[theDialog answerCallbackOnObject:self withSelector:@selector(answerObject:setCounter:) andArguments:args];
		
		[self callDialog:theDialog];
	}else{
		counter = [NSNumber numberWithInt:[counter intValue]-1];;
	}
	return self;
}

-(NSString*)style {
	return @""
		".counter-box {"
			"border: 1px dotted black;"
			"float: left;"
			"width: 130px;"
			"padding:10px;"
			"margin:5px;"
			"text-align:center;"
		"}";
}

-(id)renderContentOn:(WHHtmlCanvas*)html {

	WHGenericTag* div = [html tag:@"div"];
	[div attributeAt:@"class" put:@"counter-box"];
	
	[div addContent:[[html tag:@"h1"] with:[NSString stringWithFormat:@"%d",[counter intValue]]]];
	
	[div addContent:[[[html anchorTag] callbackOnObject:self 
									   withSelector:@selector(add) 
									   andArguments:nil]
				  with:@"++"]];
	
	
	[div addContent:[[[html anchorTag] callbackOnObject:self 
									   withSelector:@selector(subtract) 
									   andArguments:nil]
				  with:@"--"]];
	
	return div;
}


@end
