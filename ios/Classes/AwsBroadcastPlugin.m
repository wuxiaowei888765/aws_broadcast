#import "AwsBroadcastPlugin.h"
#if __has_include(<aws_broadcast/aws_broadcast-Swift.h>)
#import <aws_broadcast/aws_broadcast-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "aws_broadcast-Swift.h"
#endif

@implementation AwsBroadcastPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAwsBroadcastPlugin registerWithRegistrar:registrar];
}
@end
