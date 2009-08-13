//
//  WHRequest.m
//  LakeFrontHTML
//
//  Created by William Harford on 01/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WHRequest.h"
#include <stdio.h>
#include <stdlib.h>

@implementation WHRequest
@synthesize vars;
@synthesize fastCgiRequest;
@synthesize queryString;
@synthesize postString;

-(id)init {
	self = [super init];
	if(self != nil){
		vars = [NSMutableDictionary new];
	}
	return self;
}

-(NSString*)sessionKey {
	return [vars objectForKey:@"_s"];
}

-(BOOL)hasSessionKey {
	return [vars objectForKey:@"_s"] != nil;
}

-(BOOL)hasRegistryKey {
	return [vars objectForKey:@"_r"] != nil;
}

-(NSString*)registryKey {
	return [vars objectForKey:@"_r"];
}

-(NSString*)requestVarForKey:(NSString*)key {
	return [vars objectForKey:key];
}

//No guarentee the things actualy are callback
//just what was passed in
-(NSMutableDictionary*)formCallbackKeysAndValues {
	NSMutableDictionary* formVarsAndValues = [NSMutableDictionary new];
	
	for(NSString* var in vars){
		if([var length] >= 4){
			NSArray* parts = [var componentsSeparatedByString:@"-"];
			if([[parts objectAtIndex:0] isEqualToString:@"_i"]){
				NSString *key = [parts objectAtIndex:1];
				NSString *value = [vars objectForKey:var];
				if(value != nil && key != nil){
					[formVarsAndValues setObject:value forKey:key];
				
				}
			}
		}
	}
	return formVarsAndValues;
	
}


-(void)parseVars {
	[self parseString:queryString];
	[self parseString:postString];
}


-(void)parseString: (NSString*) aString{

	NSArray * parts = [aString componentsSeparatedByString:@"&"];

	for(NSString* part in parts){
		NSArray *varValue = [part componentsSeparatedByString:@"="];
		NSString *var = @"";
		NSString *value = @"";
		if([varValue count] >= 1){
			var = [varValue objectAtIndex:0];
		}else{
			continue;
		}
		if([varValue count] >= 2){
			NSRange theRange;
			theRange.location = 1;
			theRange.length = [varValue count] - 1;
			varValue = [varValue subarrayWithRange:theRange];
			value = [varValue componentsJoinedByString:@"="];
			
			value = [value stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
		}
		
		[vars setObject:value forKey:var];
		
	}
}

-(void)setupFromFcgi{
	char *p;
	p = getenv ( "QUERY_STRING" );
	if(p != NULL){
		queryString = [NSString stringWithUTF8String:p];
	}else{
		queryString = [NSString new];
	}
	
}



@end
