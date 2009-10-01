//
//  WHComponent.m
//  LakeFrontHTML
//
//  Created by William Harford on 03/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHComponent.h"
#import "WHHtmlRoot.h"

@implementation WHComponent

@synthesize parentComponent;
@synthesize session;

//Return Something that responds to description returning html content
-(id)renderContentOn:(WHHtmlCanvas*)html{
	return html;
}

+(WHComponent*)newWithSession:(WHSession*)aSession{
	WHComponent* newish = [[self class] new];
	[newish setSession:aSession];
	return newish;
}

-(id)renderOn:(WHHtmlCanvas*)html{
	WHComponent* selfOrDialog = [self selfOrDialog];
	NSString* renderedContent;
	if(selfOrDialog != self){
		renderedContent = [selfOrDialog renderOn:html];
	}else{
		renderedContent = [selfOrDialog renderContentOn:html];
	}
	
	
	return renderedContent;
}

-(NSArray*)children{
	return [NSArray new];
}

-(BOOL)isDialog{
	return parentComponent != nil;
}

-(void)callDialog:(WHComponent*)aDialog {
	dialog = aDialog;
	dialog.parentComponent = self;
	dialog.session = self.session;
}

-(id)close{
	[self.parentComponent closeDialog];
	return self;
}

-(void)closeDialog {
	dialog = nil;
}

-(WHComponent*)selfOrDialog {
	if(dialog != nil){
		return dialog;
	}
	return self;
}

-(NSString*)script{
	return @"";
}


-(NSString*)style{
	return @"";
}

//Overid this method if you want to do something
// with the htmlroot
-(void)updateRoot:(WHHtmlRoot*) anHtmlRoot {
	
	NSString* script = [self script];
	NSString* style = [self style];
	
	if(![script isEqualToString:@""]){
		[[anHtmlRoot scripts] addTag:[NSString stringWithFormat:@"<script type=\"text/javascript\">%@</script>",script]];
		
	}
	
	if(![style isEqualToString:@""]){
		[[anHtmlRoot styles] addTag:[NSString stringWithFormat:@"<style>%@</style>",style]];
	}
	
}


-(void)updateRootAndChildren:(WHHtmlRoot*)anHtmlRoot {
	if(dialog != nil){
		[self updateRoot:anHtmlRoot];
	}
	[[self selfOrDialog] updateRoot:anHtmlRoot];
	
	for( WHComponent* child in [[self selfOrDialog] children]){
		[[child selfOrDialog] updateRootAndChildren:anHtmlRoot];
	}
}


-(void)answerCallbackOnObject:(id)anObject withSelector:(SEL)aSelector andArguments:(NSArray*)args{

	answerCallback = [WHMethodCallback newWithObject:anObject andSelector:aSelector];
	answerCallback.arguments = args;
	
}



-(void)answer:(id)anObject{
	[self close];
	[answerCallback runWithArgument:anObject];
}

@end
