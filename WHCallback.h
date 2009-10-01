//
//  WHCallback.h
// Implicitly abstract class
//  ESC
//
//  Created by William Harford on 09-09-29.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>

/*ABSTRACT*/
@interface WHCallback : NSObject {

}

-(id)runWithArguments:(NSArray*)args;
/*
 ** Inserts an argument at the beginning of the list 
 ** and runs this callback
 */
-(id)runWithArgument:(id)anObject ;
-(id)run;


@end
