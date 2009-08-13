//
//  untitled.m
//  LakeFrontHTML
//
//  Created by William Harford on 12/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHMultiCounter.h"
#import "WHTagCollection.h";


@implementation WHMultiCounter

-(id)init{
	self = [super init];
	if(self != nil){
		counter1 = [WHCounter new];
		counter2 = [WHCounter new];
		counter3 = [WHCounter new];
	}
	return self;
}

-(NSArray *)children{
	return [NSArray arrayWithObjects:counter1, counter2, counter3, nil];
	
}

-(id)renderContentOn:(WHHtmlCanvas*)html {
	WHTagCollection* counters = [WHTagCollection new];
	
	[counters addTag:[counter1 renderOn:html]];
	[counters addTag:[counter2 renderOn:html]];
	[counters addTag:[counter3 renderOn:html]];
	
	return counters;
}

	

@end
