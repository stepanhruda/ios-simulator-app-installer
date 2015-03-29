#import <Foundation/Foundation.h>

// Ideally we would only bridge a C function, but the compiler doesn't like that.
@interface TargetDevice: NSObject

+ (NSString *)deviceString;

@end
