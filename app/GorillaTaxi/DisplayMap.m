#import "DisplayMap.h"

@implementation DisplayMap

@synthesize coordinate,title,subtitle;

-(void)dealloc{
    [title release];
    [super dealloc];
}

@end