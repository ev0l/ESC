//
//  WHTagCollection.h
//  LakeFrontHTML
//
//  Created by William Harford on 05/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface WHTagCollection : NSObject {
	NSMutableArray *tags;
}

-(WHTagCollection*)addTag:(id)tag;

@property (retain) NSMutableArray* tags;


@end
