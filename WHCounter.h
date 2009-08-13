//
//  WHCounter.h
//  LakeFrontHTML
//
//  Created by William Harford on 05/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WHHtmlCanvas.h"
#import "WHComponent.h"


@interface WHCounter : WHComponent {
	NSNumber* counter;

}

@property (copy) NSNumber* counter;

-(id)add;
-(id)subtract;


@end
