//
//  WHCallbackTest.m
//  LakeFrontHTML
//
//  Created by William Harford on 25/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHCallbackTest.h"


@implementation WHCallbackTest

-(void)setUp{
	callback = [WHMethodCallback new];
	called = NO;
	argument = @"argument Not Set";
}

-(id)setBool{
	called = YES;
	return self;
}

-(void)noReturn{
	called = YES;
}

-(void)testNoArguments {

	callback = (WHMethodCallback*)[WHMethodCallback newWithObject:self andSelector:@selector(noReturn)];
	[callback run];
	STAssertTrue(called,@"Argument not sent");
}



-(void)testOneArgument {
	
	callback.selector = @selector(oneArgument:);
	callback.object = self;
	callback.arguments = [NSArray arrayWithObject:@"Foo1212"];
	NSString *retVal = [callback run];
	STAssertTrue([@"Foo1212" isEqual:argument],argument);
	//They should be the same argument
	STAssertEquals(retVal,argument,argument);

}



-(NSString*)oneArgument:(NSString*) aString{
	
	argument = aString;
	return aString;
}


-(void)testTwoArgument {
	
	callback.selector = @selector(twoArguments:and:);
	callback.object = self;
	callback.arguments = [NSArray arrayWithObjects:@"Foo",@"Bar",nil];
	NSString *retVal = [callback run];
	STAssertTrue([@"Foo" isEqual:argument1],argument1);
	//They should be the same argument
	STAssertEquals(retVal,argument1,argument1);
	
}

-(id)twoArguments:(NSString*) foo and:(NSString*) bar {
	argument1 = foo;
	argument2 = bar;
	return argument1;
}



-(void)testRunWithArgument {
	callback = (WHMethodCallback*)[WHMethodCallback newWithObject:self andSelector:@selector(oneArgument:)];
	[callback runWithArgument:@"Foo2"];
	STAssertTrue([@"Foo2" isEqual:argument],argument);
	
}



@end
