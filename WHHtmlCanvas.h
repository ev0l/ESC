//
//  WHHTML.h
//  LakeFrontHTML
//
//  Created by William Harford on 23/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHGenericTag.h"
#import "WHSession.h"
#import "WHAnchorTag.h"
#import "WHFormTag.h"
#import "WHFormInputTag.h"
#import "WHFormSelectTag.h"
#import "WHTagCollection.h"

@interface WHHtmlCanvas : NSObject {

	WHSession * session;
}


@property (retain) WHSession* session;


-(WHGenericTag*)tag:(NSString*) aString;
-(WHAnchorTag*)anchorTag;
-(WHFormTag*)formTag;
-(WHFormInputTag*)formInputTagWithType:(NSString*)aType;
-(WHFormSelectTag*)select;
-(WHTag*)br ;

-(WHTagCollection*)collection;
-(id)render:(id)aComponent;

@end
