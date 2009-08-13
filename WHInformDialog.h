//
//  WHInformDialog.h
//  LakeFrontHTML
//
//  Created by William Harford on 08/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WHComponent.h"

@interface WHInformDialog : WHComponent {
	NSString* message;
}

@property (retain) NSString* message;

@end
