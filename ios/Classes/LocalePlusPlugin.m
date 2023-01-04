#import "LocalePlusPlugin.h"
#if __has_include(<locale_plus/locale_plus-Swift.h>)
#import <locale_plus/locale_plus-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "locale_plus-Swift.h"
#endif

@implementation LocalePlusPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLocalePlusPlugin registerWithRegistrar:registrar];
}
@end
