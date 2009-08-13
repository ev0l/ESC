//
//  WHRequestTest.m
//  LakeFrontHTML
//
//  Created by William Harford on 01/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHRequestTest.h"
#include <stdio.h>
#include <stdlib.h>

@implementation WHRequestTest

-(void)setUp {
	
	p = @"&_i-1=123&_i-2=124&foo=bar&smith=john&mangled=one=2=three";
	p2 = @"QUERY_STRING=";
	wholeString = [p2 stringByAppendingString:p];
	putenv((char*)[wholeString UTF8String]);
	
	request = [WHRequest new];
	[request setupFromFcgi];
}

-(void)testGetQueryString {

	
	
	NSString * query = [request queryString];
	STAssertTrue((query != nil),@"It should be something");
	
	STAssertTrue([query isEqual:p],[query stringByAppendingString:p]);		
}

-(void)testParseVars{
	[request parseVars];
	
	STAssertTrue([[request.vars valueForKey:@"foo"] isEqual:@"bar"],[request.vars valueForKey:@"foo"]);
	STAssertTrue([[request.vars valueForKey:@"smith"] isEqual:@"john"],@"oh crap");
	STAssertTrue([[request.vars valueForKey:@"mangled"] isEqual:@"one=2=three"],@"oh crap");

}

-(void)testValueAtKey {
	[request parseVars];
	STAssertTrue([[request requestVarForKey:@"foo"] isEqual:@"bar"],@"Should be the same");
}

/*
-(void)testFormValue{
	NSMutableDictionary * formValue = [request formCallbackKeysAndValues];
	STAssertTrue([[formValue objectForKey:@"2"] isEqual:@"124"],[formValue objectForKey:@"2"]);
}
 */

@end
