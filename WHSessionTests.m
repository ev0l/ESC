//
//  untitled.m
//  LakeFrontHTML
//
//  Created by William Harford on 30/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHSessionTests.h"


@implementation WHSessionTests

-(void)setUp{
	session = [WHSession new];
	value = @"Foo";
}

-(id)setTestValue:(NSString*)aString{
	value = aString;
	return self;
}

-(NSString*)value{
	return value;
}

-(void)testRegisterCallback {
	NSUInteger key = [session registerCallbackOnObject:self 
										  withSelector:@selector(description) 
										  andArguments:[NSArray new]];
	
	WHMethodCallback* callback = [session callbackByKey:key];
	STAssertEquals(callback.selector,@selector(description),@"Wrong selector");
	STAssertEquals(callback.object,self,@"We should be self");
	
}

-(void)testRegistry{
	[session registerObject:self onKeyPath:@"value"];
	NSUInteger firstKey = [session currentRegistryKey];
	STAssertTrue([value isEqual:@"Foo"],@"For Clairity");
	
	[session saveCurrentRegistry];
	
	NSUInteger secondKey = [session currentRegistryKey];
	STAssertTrue(firstKey != secondKey,@"We should get a new key");
	
	value = @"Bar";
	STAssertFalse([value isEqual:@"Foo"],@"For Clairity");
	
	[session restoreRegistryAtKey:firstKey];
	STAssertTrue([value isEqual:@"Foo"], @"The value should be put back");
	
	
}

-(void)testProcessCallback {
	WHRequest * request = [WHRequest new];
	request.vars = [NSMutableDictionary new];
	
	NSUInteger key = [session registerCallbackOnObject:self 
										  withSelector:@selector(setValue:) 
										  andArguments:[NSArray arrayWithObject:@"I ran"]];
	
	
	[request.vars setObject:[NSString stringWithFormat:@"%d",key] forKey:@"_k"];
	session.lastRequest = request;
	[session processCallback];
	
	STAssertTrue([value isEqual:@"I ran"],value);
					  
}




@end
