//
//  WHBlockCallback.h
//  ESC
//
//  Created by William Harford on 09-09-29.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHCallback.h"

@interface WHBlockCallback : WHCallback {
	 void (^block)();
}

@property (copy) void (^block)();

@end
