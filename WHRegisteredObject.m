//
//  WHRegisteredObject.m
//  LakeFrontHTML
//
//  Created by William Harford on 28/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHRegisteredObject.h"


@implementation WHRegisteredObject

@synthesize onObject;
@synthesize value;
@synthesize keyPath;

-(void)restoreState {
	[onObject setValue:value forKey:keyPath];
	
}

-(void)deriveValue {
	value = [[onObject valueForKey:keyPath] copy];
}



-(id)copyWithZone:(NSZone*)zone{
	WHRegisteredObject* newish = [[[self class] allocWithZone:zone] init];
	newish.onObject = onObject;
	newish.keyPath = keyPath;
	[newish deriveValue];
	return newish;
	
}

@end
