//
//  WHCollectionCallback.m
//  LakeFrontHTML
//
//  Created by William Harford on 28/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHArrayCallback.h"


@implementation WHArrayCallback

@synthesize items;


//Should we do this as a number or a string?
-(id)runWithArgument:(NSNumber*)aNumber{
	if([aNumber intValue] < 0){
		return nil;
	}
	if([aNumber intValue] >= [items count]){
		return nil;
	}
	return [super runWithArgument:[self objectForKey:[aNumber intValue]]];
	
}
-(id)objectForKey:(NSUInteger)key{
	return [items objectAtIndex:key];
}


+(id)newWithObject:(id)anObject selector:(SEL)aSelector andArray:(NSArray*) anArray {
	WHArrayCallback* newish = (WHArrayCallback*)[super newWithObject:anObject	andSelector:aSelector];
	newish.items = anArray;
	return newish;
}


@end
