//
//  WHComponent.h
//  LakeFrontHTML
//
//  Created by William Harford on 03/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WHHtmlCanvas.h"
#import "WHHtmlRoot.h"
#import "WHMethodCallback.h"


@interface WHComponent : NSObject {
	id session;
	WHComponent* parentComponent;
	WHComponent* dialog;
	
	WHMethodCallback* answerCallback;
	
}

@property (retain) id session;
@property (retain) WHComponent* parentComponent;

//Return Something that responds to description returning html content
-(id)renderContentOn:(WHHtmlCanvas*)html;
-(id)renderOn:(WHHtmlCanvas*)html;

-(id)renderOn:(WHHtmlCanvas*)html;
-(NSArray*)children;
-(BOOL)isDialog;
-(WHComponent*)selfOrDialog;
-(void)closeDialog;
-(void)callDialog:(WHComponent*)aDialog;
-(void)updateRoot:(WHHtmlRoot*) anHtmlRoot;

//This is where this component should send it's answer
-(void)answerCallbackOnObject:(id)anObject withSelector:(SEL)aSelector andArguments:(NSArray*)args;
//Call answer when you want this component to pop off the stack
// and send the pass value to the answer callback
-(void)answer:(id)anObject;

//This one in final
-(void)updateRootAndChildren:(WHHtmlRoot*)anHtmlRoot;

+(WHComponent*)newWithSession:(WHSession*)aSession;

@end
