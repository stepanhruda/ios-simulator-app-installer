#import "Parameters.h"

#define PREPROCESSOR_NAME(f) #f
#define PREPROCESSOR_VALUE(f) PREPROCESSOR_NAME(f)

@implementation Parameters

+ (NSString *)deviceString {
    return [NSString stringWithFormat:@"%s", PREPROCESSOR_VALUE(TARGET_DEVICE)];
}

+ (BOOL)shouldUninstallFirst {
#if UNINSTALL == 1
    return YES;
#else
    return NO;
#endif
}

@end
