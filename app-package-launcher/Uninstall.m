#import "Uninstall.h"

@implementation Uninstall

+ (BOOL)should {
#ifdef UNINSTALL
    return YES;
#endif
    
    return NO;
}

@end

