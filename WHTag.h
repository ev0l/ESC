//
//  WHTag.h
//  LakeFrontHTML
//
//  Created by William Harford on 23/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WHHtmlCanvas;


@interface WHTag : NSObject {
	NSMutableDictionary *attributes;
	NSMutableArray *contents;
	BOOL needsClose;
	
	WHHtmlCanvas* canvas;
	NSUInteger callbackKey;
}


@property BOOL needsClose;
@property (retain) WHHtmlCanvas* canvas;

-(NSString*)attributesString;
-(WHTag*)attributeAt:(NSString*)attribute put:(NSString*)value;
-(void)registerCallbackOnObject:(id)anObject withSelector:(SEL)aSelector andArguments:(NSArray*)args;
-(WHTag*)with:(id)tag ;
-(WHTag*)addContent:(id)tag;
-(NSString*)tagContent;

-(WHTag*)text:(NSString*)text;
-(NSString*)liveUpdateFunctionForUrl:(NSString*)url;

-(void)registerBlock:(void (^)()) aBlock;

-(void)registerBlockWithArgument:(void (^)(id anObject)) aBlock ;

@end
