//
//  untitled.h
//  LakeFrontHTML
//
//  Created by William Harford on 28/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "WHStateRegistry.h"

@interface WHStateRegistryTests : SenTestCase {
	WHStateRegistry* registry;
	id value;
}

@property (retain) NSString * value;


@end
