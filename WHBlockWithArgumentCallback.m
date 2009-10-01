//
//  WHBlockWithArgumentCallback.m
//  ESC
//
//  Created by William Harford on 09-09-29.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHBlockWithArgumentCallback.h"


@implementation WHBlockWithArgumentCallback

@synthesize block;

-(id)runWithArguments:(NSArray*)args{
	return [self runWithArgument:[args objectAtIndex:0]];
}
/*
 ** Inserts an argument at the beginning of the list 
 ** and runs this callback
 */
-(id)runWithArgument:(id)anObject {
	block(anObject);
	return self;
}

/*
 * Should we die or try ?
 */
-(id)run{
	
	block(self);
	return self;
}


@end
