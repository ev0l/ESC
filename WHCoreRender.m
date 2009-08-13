//
//  WHCoreRender.m
//  LakeFrontHTML
//
//  Created by William Harford on 23/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHCoreRender.h"



@implementation WHCoreRender

-(void)setUp{
	canvas = [WHHtmlCanvas new];
}



-(void)testGenericTag {
	WHGenericTag* tag = [canvas tag:@"b"];
	
	STAssertTrue([[tag className] isEqualToString:@"WHGenericTag"],[tag className]);
	STAssertTrue([[tag tag] isEqualToString:@"b"],[tag tag]);
}

@end
