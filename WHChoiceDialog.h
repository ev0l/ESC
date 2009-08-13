//
//  WHChoiceDialog.h
//  LakeFrontHTML
//
//  Created by William Harford on 13/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WHInformDialog.h"

@interface WHChoiceDialog : WHInformDialog {

}

-(WHTag*)renderButtonFormOn:(WHHtmlCanvas*)html;

@end
