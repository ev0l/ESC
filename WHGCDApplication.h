//
//  WHGCDApplication.h
//  ESC
//
//  Created by William Harford on 09-09-24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHApplication.h"
#include <dispatch/dispatch.h>

@interface WHGCDApplication : WHApplication {
	dispatch_queue_t sessionLifeQueue;
	NSMutableDictionary* queues;
}

-(dispatch_queue_t)queueForSession:(WHSession*)aSession;
-(void)releaseQueueForSession:(WHSession*)aSession;

@end
