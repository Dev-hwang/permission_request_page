#import "PermissionRequestPagePlugin.h"
#if __has_include(<permission_request_page/permission_request_page-Swift.h>)
#import <permission_request_page/permission_request_page-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "permission_request_page-Swift.h"
#endif

@implementation PermissionRequestPagePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPermissionRequestPagePlugin registerWithRegistrar:registrar];
}
@end
