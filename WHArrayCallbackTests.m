//
//  untitled.m
//  LakeFrontHTML
//
//  Created by William Harford on 28/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHArrayCallbackTests.h"
#import "WHArrayCallback.h"

@implementation WHArrayCallbackTests


-(void)setUp{
	items = [NSArray arrayWithObjects:@"Foo",@"Bar",nil];
	
}

-(void)testCallback{
	WHArrayCallback* callback = [WHArrayCallback newWithObject:self selector:@selector(setArgument:) andArray:items];
	[callback runWithArgument:[NSNumber numberWithInt:0]];
	STAssertEquals([items objectAtIndex:0],argument,argument);
	
}

-(id)setArgument:(NSString*)aString{
	argument = aString;
	return self;
	
}

@end
