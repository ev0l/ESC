//
//  WHFormExample.h
//  LakeFrontHTML
//
//  Created by William Harford on 21/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WHComponent.h"

@interface WHFormExample : WHComponent {
	NSString* firstName;
	NSString* lastName;
	NSString* sex;
	

}

@property (retain) NSString* firstName;
@property (retain) NSString* lastName;
@property (retain) NSString* sex;

@end
