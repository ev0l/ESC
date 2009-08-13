//
//  WHRegisteredCounter.m
//  LakeFrontHTML
//
//  Created by William Harford on 24/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHRegisteredCounter.h"


@implementation WHRegisteredCounter

-(void)setSession:(id)aSession{
	[super setSession:aSession];
	[session registerObject:self onKeyPath:@"counter"];
}



@end
