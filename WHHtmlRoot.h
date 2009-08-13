//
//  WHHtmlRoot.h
//  LakeFrontHTML
//
//  Created by William Harford on 12/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WHHtmlCanvas.h"
#import "WHTagCollection.h";

@interface WHHtmlRoot : NSObject {
	NSString* mimeType;
	NSString* title;
	
	WHTagCollection* styles;
	WHTagCollection* scripts;
	
	WHTagCollection* headTags;
	
	NSMutableDictionary* urlArgs;
	
	NSString * docType;
	
}

@property (retain) NSString* mimeType;
@property (retain) NSString* title;
@property (retain) WHTagCollection* styles;
@property (retain) WHTagCollection* scripts;
@property (retain) WHTagCollection* headTags;
@property (retain) NSString* docType;

@property (retain) NSMutableDictionary* urlArgs;


-(id)renderHeadOn:(WHHtmlCanvas*) html;

-(id)renderDocumentOn:(WHHtmlCanvas*)html withContent:(id)content;
-(void)makeLiveResponce;

@end
