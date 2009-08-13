//
//  WHTagCollection.m
//  LakeFrontHTML
//
//  Created by William Harford on 05/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHTagCollection.h"
#import "WHTag.h"

@implementation WHTagCollection
@synthesize tags;

-(id)init {
	self = [super init];
	if(self != nil){
		tags = [NSMutableArray new];
	}
	return self;
}

-(WHTagCollection*)addTag:(id)tag{
	[tags addObject:tag];
	return self;
}

-(NSString*)description{
	NSString* string;
	string = [NSString new];
	for(WHTag* tag in tags){
		string = [string stringByAppendingString:[tag description]];
	}
	return string;
}

@end
