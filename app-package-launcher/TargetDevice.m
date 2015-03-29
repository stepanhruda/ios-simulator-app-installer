#import "TargetDevice.h"

#define PREPROCESSOR_NAME(f) #f
#define PREPROCESSOR_VALUE(f) PREPROCESSOR_NAME(f)

@implementation TargetDevice

+ (NSString *)deviceString {
    return [NSString stringWithFormat:@"%s", PREPROCESSOR_VALUE(TARGET_DEVICE)];
}

@end
