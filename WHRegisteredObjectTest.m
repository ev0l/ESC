//
//  untitled.m
//  LakeFrontHTML
//
//  Created by William Harford on 28/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHRegisteredObjectTest.h"


@implementation WHRegisteredObjectTest

@synthesize value;

-(void)setUp{
	object = [WHRegisteredObject new];
	value = @"Foo";
}


-(void)testCopy {

	object.onObject = self;
	object.keyPath = @"value";
	object.value = value;
	STAssertTrue([value isEqual:object.value],@"Ofcourse");
	[object copy];
	value = @"Bar";
	STAssertFalse([value isEqual:object.value],value);
	[object restoreState];
	STAssertTrue([value isEqual:object.value],@"Should of set it to value");
}


@end
