//
//  untitled.h
//  LakeFrontHTML
//
//  Created by William Harford on 28/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface WHStateRegistry : NSObject {
	NSMutableArray* registeredObjects;
	
}


@property (retain) NSMutableArray* registeredObjects;



-(void)registerObject:(id)anObject onKeyPath:(NSString*)aKeyPath;
-(void)restoreState;
-(void)saveState ;



@end
