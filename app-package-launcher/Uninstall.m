#import "Uninstall.h"

@implementation Uninstall

+ (BOOL)should {
#if UNINSTALL == 1
    return YES;
#endif
    
    return NO;
}

@end

