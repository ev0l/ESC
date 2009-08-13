//
//  WHTagTest.m
//  LakeFrontHTML
//
//  Created by William Harford on 24/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHTagTest.h"


@implementation WHTagTest


-(void)setUp {
	tag = [WHTag new];
	
}


-(void)testAttributes {
	[tag attributeAt:@"foo" put:@"Value"];

	STAssertTrue([[tag attributesString] isEqualToString:@" foo=\"Value\""],[tag attributesString]);

}

@end
