#import "DisplayMap.h"


@implementation DisplayMap

@synthesize coordinate,title,subtitle,image;

-(void)dealloc{
    [title release];
    [super dealloc];
}

@end