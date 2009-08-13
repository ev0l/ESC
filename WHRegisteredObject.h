//
//  WHRegisteredObject.h
//  LakeFrontHTML
//
//  Created by William Harford on 28/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface WHRegisteredObject : NSObject {
	id onObject;
	NSString* keyPath;
	id value;
}

@property (retain) id onObject;
@property (retain) NSString* keyPath;
@property (retain) id value;



-(void)restoreState;
-(void)deriveValue ;

@end
