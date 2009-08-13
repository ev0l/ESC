//
//  WHHtmlRoot.m
//  LakeFrontHTML
//
//  Created by William Harford on 12/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHHtmlRoot.h"


@implementation WHHtmlRoot
@synthesize mimeType;
@synthesize title;
@synthesize styles;
@synthesize scripts;
@synthesize headTags;
@synthesize docType;


@synthesize urlArgs;

-(id)init {
	self = [super init];
	if(self != nil){
		mimeType = @"text/html";
		title = @"LakeFront";
		styles = [WHTagCollection new];
		scripts = [WHTagCollection new];
		docType = @"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">";
	}
	return self;
}

-(id)renderHeadOn:(WHHtmlCanvas*) html {
	WHTag *titleTag = [[html tag:@"title"] with:[self title]];
	WHTag *head = [html tag:@"head"];
	WHTag *metaType = [html tag:@"meta"];
	[metaType attributeAt:@"content" put:[NSString stringWithFormat:@"%@; charset=utf-8", mimeType]];
	[metaType attributeAt: @"http-equiv" put:@"Content-type"];
	
	[head addContent:metaType];
	[head addContent:titleTag];
	[head addContent:scripts];
	[head addContent:styles];
	
	
	return head;
	
}

-(id)renderDocumentOn:(WHHtmlCanvas*)html withContent:(id)content{
	WHTag* htmlRoot = [html tag:@"html"];
	WHTag* headTag = [self renderHeadOn:html];
	WHTag* bodyTag = [html tag:@"body"];
	[bodyTag with:content];
	
	[htmlRoot addContent:headTag];
	[htmlRoot addContent:bodyTag];
	
	return [NSString stringWithFormat:@"%@\n%@",docType,[htmlRoot description]];

}


-(void)makeLiveResponce {
	self.docType = @"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>"
						"<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp \"&#160;\"> ]>'";
	self.mimeType = @"text/html";
	
}

@end
