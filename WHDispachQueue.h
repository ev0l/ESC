//
//  WHDispachQueue.h
//  ESC
//
//  Created by William Harford on 09-09-27.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WHDispachQueue : NSObject {
	dispatch_queue_t queue;
	int retainCount;
}

@property dispatch_queue_t queue;
@property int retainCount;


@end
