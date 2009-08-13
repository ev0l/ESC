//
//  WHExampleApplication.m
//  LakeFrontHTML
//
//  Created by William Harford on 24/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHExampleApplication.h"
#import "WHCounter.h"
#import "WHMultiCounter.h"
#import "WHFormCounter.h"
#import "WHNavigation.h"
#import "WHFormExample.h"
#import "WHRegisteredCounter.h"

@implementation WHExampleApplication

-(id)newMainComponent {
	
	WHNavigation* nav = [WHNavigation new];
	[nav addComponent:[WHFormExample new] withLabel:@"Forms"];
	[nav addComponent:[WHCounter new] withLabel:@"Counter"];
	[nav addComponent:[WHMultiCounter new] withLabel:@"Embeded Counters"];
	[nav addComponent:[WHFormCounter new] withLabel:@"Form Counter"];
	[nav addComponent:[WHRegisteredCounter new] withLabel:@"Registered Counter"];
	return nav;
	
}


@end
