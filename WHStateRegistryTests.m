//
//  untitled.m
//  LakeFrontHTML
//
//  Created by William Harford on 28/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHStateRegistryTests.h"



@implementation WHStateRegistryTests

@synthesize value;

-(void)setUp{
	registry = [WHStateRegistry new];
	value = @"Foo";
}

-(void)testRegistry {
	[registry registerObject:self onKeyPath:@"value"];
	[registry saveState];
	STAssertTrue([value isEqual:@"Foo"], @"I hope so");
	value = @"Bar";
	[registry restoreState];
	STAssertTrue([value isEqual:@"Foo"],@"Not restored");
	
}


-(void)testNSNumberResigrty {
	value = [NSNumber numberWithInt:1];
	
	[registry registerObject:self onKeyPath:@"value"];
	[registry saveState];
	STAssertTrue([value intValue] == 1, @"I hope so");
	value = [NSNumber numberWithInt:2];
	STAssertTrue([value intValue] == 2,@"Not restored");
	[registry restoreState];
	STAssertTrue([value intValue] == 1,@"Not restored");
	
	
}

@end
