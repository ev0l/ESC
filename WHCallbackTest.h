

#import <SenTestingKit/SenTestingKit.h>
#import "WHCallback.h"

@interface WHCallbackTest : SenTestCase {
	
	BOOL called;
	WHCallback* callback;
	NSString* argument;
	NSString* argument1;
	NSString* argument2;

}



@end
