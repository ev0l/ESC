//
//  WHNavigation.h
//  LakeFrontHTML
//
//  Created by William Harford on 23/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WHComponent.h"
#import "WHTagCollection.h"

@interface WHNavigation : WHComponent {
	NSMutableArray* components;
	NSMutableArray* labels;
	id selection;
	
}

@property (retain) id selection;

-(void)addComponent:(id)aComponent withLabel:(NSString*) aString;

-(NSString*)labelForComponent:(id)aComponent;

-(WHTag*)renderOptionsOn:(WHHtmlCanvas*) html;

-(WHTag*)renderOptionOn:(WHHtmlCanvas*) html forComponent:(id)aComponent;

-(WHTag*)renderSelectionOn:(WHHtmlCanvas*) html;

-(WHTag*)renderComponentLabelOn:(WHHtmlCanvas*)html forComponent:(id)aComponent;


@end
