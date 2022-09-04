import Flutter
import UIKit

public class SwiftPermissionRequestPagePlugin: NSObject, FlutterPlugin {
    private var methodCallHandler: MethodCallHandlerImpl? = nil
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftPermissionRequestPagePlugin()
        instance.initChannels(registrar.messenger())
    }
    
    private func initChannels(_ messenger: FlutterBinaryMessenger) {
        methodCallHandler = MethodCallHandlerImpl(messenger: messenger)
    }
}
