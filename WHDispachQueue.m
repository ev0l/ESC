//
//  WHDispachQueue.m
//  ESC
//
//  Created by William Harford on 09-09-27.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHDispachQueue.h"


@implementation WHDispachQueue

@synthesize queue;
@synthesize retainCount;

-(id)init{
	self = [super init];
	if(self){
		retainCount = 1;
	}
	return self;
}

@end
