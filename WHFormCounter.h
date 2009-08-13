//
//  WHFormCounter.h
//  LakeFrontHTML
//
//  Created by William Harford on 09/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WHCounter.h"

@interface WHFormCounter : WHCounter {

}

-(void)addInputToTag:(id)aTag withHtml:(WHHtmlCanvas*) html;

@end
