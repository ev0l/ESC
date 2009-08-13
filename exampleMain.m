
#import "WHExampleApplication.h"


#include "fcgi_stdio.h"

int main(int argc, char *argv[]) {
	objc_startCollectorThread();
	WHExampleApplication * example = [WHExampleApplication new];
	[example startOnPort:8892];
	
}
