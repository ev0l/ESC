//
//  WHTag.m
//  LakeFrontHTML
//
//  Created by William Harford on 23/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHTag.h"
#import "WHHtmlCanvas.h"
#import "WHSession.h"

@implementation WHTag

@synthesize needsClose;
@synthesize canvas;


-(id)init{
	self = [super init];
	if(self != nil){
		contents = [NSMutableArray new];
		attributes = [NSMutableDictionary new];
	}
	return self;
}

-(WHTag*)text:(NSString*)text {
	//NSString* value = [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	[self with:text];
	return self;
}

-(WHTag*)with:(id)tag {
	self.needsClose = YES;
	contents = [NSMutableArray arrayWithObject:tag];
	return self;
}

-(WHTag*)addContent:(id)tag{
	
	if(tag == nil){
		return self;
	}
	self.needsClose = YES;
	[contents addObject:tag];
	return self;
}

-(NSString*)tag {
	[self doesNotRecognizeSelector:_cmd];
	
	return @"NoSuchTag";
}

-(WHTag*)attributeAt:(NSString*)attribute put:(NSString*)value{
	[attributes setObject:value forKey:attribute];
	return self;
}



-(NSString*)attributesString {
	NSString *toString = @"";
	
	for(id key in attributes){
		toString = [toString stringByAppendingString:[NSString stringWithFormat:@" %@=\"%@\"", 
															[key description],
															[attributes objectForKey:key]
													]];
		
	}
	return toString;
}

-(NSString*)tagContent {
	NSString* aString = [NSString new];
	for(id child in contents){
		aString = [aString stringByAppendingString:[child description]];
	}
	return aString;
}

-(NSString*)description {
	
	NSString *toString = @"<";
	toString = [toString stringByAppendingString:[self tag]];
	NSString *attributesString =  [self attributesString];
	if([attributesString length] > 1){
		toString = [toString stringByAppendingString:attributesString];
	}
	if(self.needsClose){
		toString = [toString stringByAppendingString:@">"];
		
		
		toString = [toString stringByAppendingString:[self tagContent]];

		toString = [toString stringByAppendingString:@"</"];
		toString = [toString stringByAppendingString:[self tag]];
		toString = [toString stringByAppendingString:@">"];
	}else{
		toString = [toString stringByAppendingString:@"/>"];
	}
	
	return toString;
}


-(void)registerCallbackOnObject:(id)anObject withSelector:(SEL)aSelector andArguments:(NSArray*)args{
	callbackKey = [[self.canvas session] registerCallbackOnObject:anObject 
												   withSelector:aSelector 
				                                   andArguments:args];
}

-(void)liveUpdateOnEvent: (NSString*)jsEvent withObject:(id)anObject withSelector:(SEL)aSelector andArguments:(NSArray*)args {
	callbackKey = [[self.canvas session] registerCallbackOnObject:anObject 
													 withSelector:aSelector 
													 andArguments:args];
	
		
}

-(NSString*)liveUpdateFunctionForKey:(NSUInteger)key {
	return [self liveUpdateFunctionForUrl:[NSString stringWithFormat:@"&_ul=%@",[[self.canvas session] url]]];
}

-(NSString*)liveUpdateFunctionForUrl:(NSString*)url {
	return [NSString stringWithFormat:@"xmlLiveUpdaterUri('%@');",url];
}

@end
