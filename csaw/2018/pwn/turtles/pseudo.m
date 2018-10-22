#include <stdio.h>
#import <Foundation/Foundation.h>

@interface Turtle: NSObject
- (void)say(NSString *)phrase;
@end

@implementation Turtle: NSObject
- (void)say(NSString *)phrase;
{
	NSLog(@"%@\n", phrase);
}
@end

int main(void)
{
	char buf[0x810];

	setvbuf(stdout, NULL, _IOLBF, 0);
	setvbuf(stdout, NULL, _IOLBF, 0);

	Turtle *turtle = [[Turtle alloc] init];
	printf("Here is a Turtle: %p\n", turtle);

	read(STDIN_FILENO, buf, sizeof(buf));
	memcpy(turtle, buf, 200);

	[turtle say: @"I am a turtle."];
	[turtle release];
	return 0;
}
