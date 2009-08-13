//
//  WHGenericTag.h
//  LakeFrontHTML
//
//  Created by William Harford on 23/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHTag.h"

@interface WHGenericTag : WHTag {
	NSString *tag;
}
@property (retain) NSString *tag;

@end
