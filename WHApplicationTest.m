//
//  WHApplicationTest.m
//  LakeFrontHTML
//
//  Created by William Harford on 05/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHApplicationTest.h"
#import "WHSession.h"

@implementation WHApplicationTest

-(void)setUp{
	application = [WHApplication new];
}


-(void)testNewSessionKey {
	NSString * keyOne = [application newSessionKey]; 
	NSString * keyTwo = [application newSessionKey]; 
	STAssertFalse([keyOne isEqual:keyTwo],@"They should be diffrent");
}

-(void)testProcessSession {
	
	
}

-(void)testRemoveOldestSession {
	WHSession *youngSession = [WHSession new];
	WHSession *oldSession = [WHSession new];
	
	oldSession.lastAccess = [NSDate dateWithTimeIntervalSinceNow:-30000];
	
	[application.sessions setObject:youngSession forKey:@"1"];
	[application.sessions setObject:oldSession forKey:@"2"];
	
	[application removeOldestSession];
	
	STAssertTrue([application.sessions count] == 1,@"Did we remove anything");
	STAssertTrue([application.sessions objectForKey:@"1"] != nil,@"Yep Still there");
	STAssertTrue([application.sessions objectForKey:@"2"] == nil,@"We should be gone");
	
}

@end
