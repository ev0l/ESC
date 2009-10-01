//
//  WHBlockCallback.m
//  ESC
//
//  Created by William Harford on 09-09-29.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHBlockCallback.h"


@implementation WHBlockCallback

@synthesize block;

-(id)runWithArguments:(NSArray*)args{
	return [self run];
}
/*
 ** Inserts an argument at the beginning of the list 
 ** and runs this callback
 */
-(id)runWithArgument:(id)anObject {
	return [self run];
}

-(id)run{
	block();
	return self;
}




@end
