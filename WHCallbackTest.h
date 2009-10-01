

#import <SenTestingKit/SenTestingKit.h>
#import "WHMethodCallback.h"

@interface WHCallbackTest : SenTestCase {
	
	BOOL called;
	WHMethodCallback* callback;
	NSString* argument;
	NSString* argument1;
	NSString* argument2;

}



@end
