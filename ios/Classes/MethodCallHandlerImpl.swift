//
//  MethodCallHandlerImpl.swift
//  permission_request_page
//
//  Created by Woo Jin Hwang on 2022/09/04.
//

import CoreLocation
import Flutter
import Foundation

class MethodCallHandlerImpl: NSObject {
    private let methodChannel: FlutterMethodChannel
    
    init(messenger: FlutterBinaryMessenger) {
        self.methodChannel = FlutterMethodChannel(name: "flutter.pravera.com/permission_request_page/method", binaryMessenger: messenger)
        super.init()
        self.methodChannel.setMethodCallHandler(onMethodCall)
    }
    
    func onMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
            case "isLocationServicesEnabled":
                result(CLLocationManager.locationServicesEnabled)
            case "openLocationServicesSettings":
                if #available(iOS 10.0, *) {
                    if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsUrl, options: [:]) { enabled in result(enabled) }
                        return
                    }
                }
                result(false)
            default:
                result(FlutterMethodNotImplemented)
        }
    }
}
