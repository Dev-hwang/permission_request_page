Is it annoying to create a page that explains permissions to users or implement permission request
functionality? If so, try this plugin! This plugin simplifies the implementation of the above
features. If you don't like the default template, you can customize it using the builder defined
in `PermissionRequestPage`.

![image](https://user-images.githubusercontent.com/47127353/189646593-de45c0a9-8cab-4cdf-86a3-600fad7f3503.png)

## Getting started

To use this plugin, add `permission_request_page` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/). For example:

```yaml
dependencies:
  permission_request_page: ^2.0.0
```

## How to use

Declare the required permissions in your app.

```dart
const List<PermissionData> _kPermission = [
  PermissionData(
    permissionType: PermissionType.location,
    permissionName: 'Location',
    description: 'Permission for accessing the device\'s location.',
    isNecessary: true,
  ),
  PermissionData(
    permissionType: PermissionType.storage,
    permissionName: 'Storage',
    description: 'Permission for accessing external storage.',
    isNecessary: false,
  ),
  PermissionData(
    permissionType: PermissionType.notification,
    permissionName: 'Notification',
    description: 'Permission for pushing notifications.',
    isNecessary: false,
  ),
];
```

```dart
const CustomText _kCustomText = CustomText(
  permissionViewHeaderText: 'The following permissions are required to use the application.',
  permissionRequestButtonText: 'NEXT',
  popupTextWhenPermissionDenied: 'To use the application, you must grant the following permissions: ',
);
```

Write an init function to execute when all required permissions are granted.

```dart
class _SplashPageState extends State<SplashPage> {
  Future<InitResult> _initFunction() async {
    InitResult initResult;
    try {
      // Write your app initialization code.
      initResult = const InitResult(complete: true);
    } catch (error, stackTrace) {
      // Write code to handle app initialization errors.
      initResult =
          InitResult(complete: false, error: error, stackTrace: stackTrace);
    }

    // If the complete value of InitResult is true, it navigates to the nextPage.
    return initResult;
  }

  @override
  Widget build(BuildContext context) {
    // ...
  }
}
```

Add a PermissionRequestPage widget under Scaffold.

```dart
class _SplashPageState extends State<SplashPage> {
  Future<InitResult> _initFunction() async {
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PermissionRequestPage(
        permissions: _kPermission,
        customText: _kCustomText,
        initFunction: _initFunction,
        nextPage: Container(),
      ),
    );
  }
}
```

Declare the permissions to use for each platform.

### :baby_chick: Android

/android/app/src/main/AndroidManifest.xml

```xml
<!-- PermissionType.calendar -->
<uses-permission android:name="android.permission.READ_CALENDAR" />
<uses-permission android:name="android.permission.WRITE_CALENDAR" />

<!-- PermissionType.camera -->
<uses-permission android:name="android.permission.CAMERA" />

<!-- PermissionType.contacts -->
<uses-permission android:name="android.permission.READ_CONTACTS" />
<uses-permission android:name="android.permission.WRITE_CONTACTS" />
<uses-permission android:name="android.permission.GET_ACCOUNTS" />

<!-- PermissionType.storage -->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

<!-- PermissionType.sms -->
<uses-permission android:name="android.permission.SEND_SMS" />
<uses-permission android:name="android.permission.RECEIVE_SMS" />
<uses-permission android:name="android.permission.READ_SMS" />
<uses-permission android:name="android.permission.RECEIVE_WAP_PUSH" />
<uses-permission android:name="android.permission.RECEIVE_MMS" />

<!-- PermissionType.phone -->
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.CALL_PHONE" />
<uses-permission android:name="android.permission.ADD_VOICEMAIL" />
<uses-permission android:name="android.permission.USE_SIP" />
<uses-permission android:name="android.permission.READ_CALL_LOG" />
<uses-permission android:name="android.permission.WRITE_CALL_LOG" />
<uses-permission android:name="android.permission.BIND_CALL_REDIRECTION_SERVICE" />

<!-- PermissionType.location, PermissionType.locationAlways -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />

<!-- PermissionType.microphone, PermissionType.speech -->
<uses-permission android:name="android.permission.RECORD_AUDIO" />

<!-- PermissionType.accessMediaLocation -->
<uses-permission android:name="android.permission.ACCESS_MEDIA_LOCATION" />

<!-- PermissionType.sensors -->
<uses-permission android:name="android.permission.BODY_SENSORS" />

<!-- PermissionType.activityRecognition -->
<uses-permission android:name="android.permission.ACTIVITY_RECOGNITION" />

<!-- PermissionType.bluetooth -->
<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />

<!-- PermissionType.systemAlertWindow -->
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
```

### :baby_chick: iOS

/ios/Runner/info.plist

```xml
<!-- PermissionType.calendar -->
<key>NSCalendarsUsageDescription</key>
<string>description</string>

<!-- PermissionType.camera -->
<key>NSCameraUsageDescription</key>
<string>description</string>

<!-- PermissionType.contacts -->
<key>NSContactsUsageDescription</key>
<string>description</string>

<!-- PermissionType.location, PermissionType.locationAlways -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>description</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>description</string>
<key>NSLocationUsageDescription</key>
<string>description</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>description</string>

<!-- PermissionType.microphone -->
<key>NSMicrophoneUsageDescription</key>
<string>description</string>

<!-- PermissionType.photos -->
<key>NSPhotoLibraryUsageDescription</key>
<string>description</string>

<!-- PermissionType.mediaLibrary -->
<key>NSAppleMusicUsageDescription</key>
<string>description</string>
<key>kTCCServiceMediaLibrary</key>
<string>description</string>

<!-- PermissionType.sensors -->
<key>NSMotionUsageDescription</key>
<string>description</string>

<!-- PermissionType.speech -->
<key>NSSpeechRecognitionUsageDescription</key>
<string>description</string>

<!-- PermissionType.reminders -->
<key>NSRemindersUsageDescription</key>
<string>description</string>
```

/ios/Podfile

```
post_install do |installer|
  installer.pods_project.targets.each do |target|
  
    # Add
    target.build_configurations.each do |config|
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',
        
        # See the table below to add macros for permissions to use in your app.
        'PERMISSION_LOCATION=1',
        'PERMISSION_NOTIFICATIONS=1'
      ]
    end

    flutter_additional_ios_build_settings(target)
  end
end
```

| Permission                  | Info.plist                                                                                                    | Macro                        |
|-----------------------------|---------------------------------------------------------------------------------------------------------------|------------------------------|
| PermissionType.calendar     | NSCalendarsUsageDescription                                                                                   | PERMISSION_EVENTS            |
| PermissionType.reminders    | NSRemindersUsageDescription                                                                                   | PERMISSION_REMINDERS         |
| PermissionType.contacts     | NSContactsUsageDescription                                                                                    | PERMISSION_CONTACTS          |
| PermissionType.camera       | NSCameraUsageDescription                                                                                      | PERMISSION_CAMERA            |
| PermissionType.microphone   | NSMicrophoneUsageDescription                                                                                  | PERMISSION_MICROPHONE        |
| PermissionType.speech       | NSSpeechRecognitionUsageDescription                                                                           | PERMISSION_SPEECH_RECOGNIZER |
| PermissionType.photos       | NSPhotoLibraryUsageDescription                                                                                | PERMISSION_PHOTOS            |
| PermissionType.location     | NSLocationUsageDescription, NSLocationAlwaysAndWhenInUseUsageDescription, NSLocationWhenInUseUsageDescription | PERMISSION_LOCATION          |
| PermissionType.notification | PermissionGroupNotification                                                                                   | PERMISSION_NOTIFICATIONS     |
| PermissionType.mediaLibrary | NSAppleMusicUsageDescription, kTCCServiceMediaLibrary                                                         | PERMISSION_MEDIA_LIBRARY     |
| PermissionType.sensors      | NSMotionUsageDescription                                                                                      | PERMISSION_SENSORS           |
| PermissionType.bluetooth    | NSBluetoothAlwaysUsageDescription, NSBluetoothPeripheralUsageDescription                                      | PERMISSION_BLUETOOTH         |

## Support

If you find any bugs or issues while using the plugin, please register an issues on [GitHub](https://github.com/Dev-hwang/permission_request_page/issues). You can also contact us at <hwj930513@naver.com>.
