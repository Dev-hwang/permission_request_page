import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_request_page/localization.dart';

/// Defines the types of permissions that can be requested.
///
/// It works the same as the permission_handler plugin's [Permission] class.
enum PermissionType {
  /// Permission for accessing the device's calendar.
  ///
  /// Android: Calendar
  /// iOS: Calendar (Events)
  calendar,

  /// Permission for accessing the device's camera.
  ///
  /// Android: Camera
  /// iOS: Photos (Camera Roll and Camera)
  camera,

  /// Permission for accessing the device's contacts.
  ///
  /// Android: Contacts
  /// iOS: AddressBook
  contacts,

  /// Permission for accessing the device's location.
  ///
  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation (Always and WhenInUse)
  location,

  /// Permission for accessing the device's location when the app is running in
  /// the background.
  ///
  /// Android: Background Location
  /// iOS: CoreLocation (Always)
  locationAlways,

  /// Permission for accessing the device's media library. (iOS 9.3+ only)
  mediaLibrary,

  /// Permission for accessing the device's microphone.
  microphone,

  /// Permission for accessing the device's phone state. (Android only)
  phone,

  /// Permission for accessing the device's photos.
  photos,

  /// Permission for accessing the device's reminders. (iOS only)
  reminders,

  /// Permission for accessing the device's sensors.
  ///
  /// Android: Body Sensors
  /// iOS: CoreMotion
  sensors,

  /// Permission for sending and reading SMS messages. (Android only)
  sms,

  /// Permission for accessing speech recognition.
  ///
  /// Android: Microphone
  /// iOS: Speech
  speech,

  /// Permission for accessing external storage.
  ///
  /// Android: External Storage
  /// iOS: Access to folders like `Documents` or `Downloads`.
  storage,

  /// Permission for pushing notifications.
  notification,

  /// Permission for accessing the device's media library.
  ///
  /// Android 10+ (API 29+)
  accessMediaLocation,

  /// Permission for accessing the activity recognition.
  ///
  /// Android 10+ (API 29+)
  activityRecognition,

  /// Permission for accessing the device's bluetooth adapter state.
  ///
  /// iOS 13 and above: The authorization state of Core Bluetooth manager.
  /// When running < iOS 13 or Android this is always allowed.
  bluetooth,

  /// Permission for scanning for Bluetooth devices.
  ///
  /// Android 12+ (API 31+)
  bluetoothScan,

  /// Permission for advertising Bluetooth devices.
  ///
  /// Android 12+ (API 31+)
  bluetoothAdvertise,

  /// Permission for connecting to Bluetooth devices.
  ///
  /// Android 12+ (API 31+)
  bluetoothConnect,

  /// Permission for creating system alert window. (Android only)
  systemAlertWindow,

  /// The unknown only used for return type, never requested.
  unknown,
}

extension PermissionTypeExtension on PermissionType {
  /// Returns the default permission icon.
  Icon defaultIcon({Color? color}) {
    IconData iconData;
    switch (this) {
      case PermissionType.calendar:
        iconData = Icons.calendar_today;
        break;
      case PermissionType.camera:
        iconData = Icons.camera;
        break;
      case PermissionType.contacts:
        iconData = Icons.perm_contact_cal;
        break;
      case PermissionType.location:
        iconData = Icons.location_pin;
        break;
      case PermissionType.locationAlways:
        iconData = Icons.location_pin;
        break;
      case PermissionType.mediaLibrary:
        iconData = Icons.music_note;
        break;
      case PermissionType.microphone:
        iconData = Icons.mic;
        break;
      case PermissionType.phone:
        iconData = Icons.call;
        break;
      case PermissionType.photos:
        iconData = Icons.photo;
        break;
      case PermissionType.reminders:
        iconData = Icons.schedule;
        break;
      case PermissionType.sensors:
        iconData = Icons.sensors;
        break;
      case PermissionType.sms:
        iconData = Icons.sms;
        break;
      case PermissionType.speech:
        iconData = Icons.mic;
        break;
      case PermissionType.storage:
        iconData = Icons.sd_storage;
        break;
      case PermissionType.notification:
        iconData = Icons.notifications;
        break;
      case PermissionType.accessMediaLocation:
        iconData = Icons.perm_media;
        break;
      case PermissionType.activityRecognition:
        iconData = Icons.accessibility;
        break;
      case PermissionType.bluetooth:
        iconData = Icons.bluetooth;
        break;
      case PermissionType.bluetoothScan:
        iconData = Icons.bluetooth_searching;
        break;
      case PermissionType.bluetoothAdvertise:
        iconData = Icons.bluetooth_searching;
        break;
      case PermissionType.bluetoothConnect:
        iconData = Icons.bluetooth_connected;
        break;
      case PermissionType.systemAlertWindow:
        iconData = Icons.palette;
        break;
      case PermissionType.unknown:
        iconData = Icons.question_mark;
    }

    return Icon(iconData, color: color);
  }

  /// Returns the default permission name.
  String defaultName() {
    switch (this) {
      case PermissionType.calendar:
        return Localization.permissionName('calendar');
      case PermissionType.camera:
        return Localization.permissionName('camera');
      case PermissionType.contacts:
        return Localization.permissionName('contacts');
      case PermissionType.location:
        return Localization.permissionName('location');
      case PermissionType.locationAlways:
        return Localization.permissionName('locationAlways');
      case PermissionType.mediaLibrary:
        return Localization.permissionName('mediaLibrary');
      case PermissionType.microphone:
        return Localization.permissionName('microphone');
      case PermissionType.phone:
        return Localization.permissionName('phone');
      case PermissionType.photos:
        return Localization.permissionName('photos');
      case PermissionType.reminders:
        return Localization.permissionName('reminders');
      case PermissionType.sensors:
        return Localization.permissionName('sensors');
      case PermissionType.sms:
        return Localization.permissionName('sms');
      case PermissionType.speech:
        return Localization.permissionName('speech');
      case PermissionType.storage:
        return Localization.permissionName('storage');
      case PermissionType.notification:
        return Localization.permissionName('notification');
      case PermissionType.accessMediaLocation:
        return Localization.permissionName('accessMediaLocation');
      case PermissionType.activityRecognition:
        return Localization.permissionName('activityRecognition');
      case PermissionType.bluetooth:
        return Localization.permissionName('bluetooth');
      case PermissionType.bluetoothScan:
        return Localization.permissionName('bluetoothScan');
      case PermissionType.bluetoothAdvertise:
        return Localization.permissionName('bluetoothAdvertise');
      case PermissionType.bluetoothConnect:
        return Localization.permissionName('bluetoothConnect');
      case PermissionType.systemAlertWindow:
        return Localization.permissionName('systemAlertWindow');
      case PermissionType.unknown:
        return Localization.permissionName('unknown');
    }
  }

  /// Returns the default permission description.
  String defaultDesc() {
    switch (this) {
      case PermissionType.calendar:
        return Localization.permissionDesc('calendar');
      case PermissionType.camera:
        return Localization.permissionDesc('camera');
      case PermissionType.contacts:
        return Localization.permissionDesc('contacts');
      case PermissionType.location:
        return Localization.permissionDesc('location');
      case PermissionType.locationAlways:
        return Localization.permissionDesc('locationAlways');
      case PermissionType.mediaLibrary:
        return Localization.permissionDesc('mediaLibrary');
      case PermissionType.microphone:
        return Localization.permissionDesc('microphone');
      case PermissionType.phone:
        return Localization.permissionDesc('phone');
      case PermissionType.photos:
        return Localization.permissionDesc('photos');
      case PermissionType.reminders:
        return Localization.permissionDesc('reminders');
      case PermissionType.sensors:
        return Localization.permissionDesc('sensors');
      case PermissionType.sms:
        return Localization.permissionDesc('sms');
      case PermissionType.speech:
        return Localization.permissionDesc('speech');
      case PermissionType.storage:
        return Localization.permissionDesc('storage');
      case PermissionType.notification:
        return Localization.permissionDesc('notification');
      case PermissionType.accessMediaLocation:
        return Localization.permissionDesc('accessMediaLocation');
      case PermissionType.activityRecognition:
        return Localization.permissionDesc('activityRecognition');
      case PermissionType.bluetooth:
        return Localization.permissionDesc('bluetooth');
      case PermissionType.bluetoothScan:
        return Localization.permissionDesc('bluetoothScan');
      case PermissionType.bluetoothAdvertise:
        return Localization.permissionDesc('bluetoothAdvertise');
      case PermissionType.bluetoothConnect:
        return Localization.permissionDesc('bluetoothConnect');
      case PermissionType.systemAlertWindow:
        return Localization.permissionDesc('systemAlertWindow');
      case PermissionType.unknown:
        return Localization.permissionDesc('unknown');
    }
  }

  /// Converts to [Permission] object.
  Permission toPermissionObj() {
    switch (this) {
      case PermissionType.calendar:
        return Permission.calendar;
      case PermissionType.camera:
        return Permission.camera;
      case PermissionType.contacts:
        return Permission.contacts;
      case PermissionType.location:
        return Permission.location;
      case PermissionType.locationAlways:
        return Permission.locationAlways;
      case PermissionType.mediaLibrary:
        return Permission.mediaLibrary;
      case PermissionType.microphone:
        return Permission.microphone;
      case PermissionType.phone:
        return Permission.phone;
      case PermissionType.photos:
        return Permission.photos;
      case PermissionType.reminders:
        return Permission.reminders;
      case PermissionType.sensors:
        return Permission.sensors;
      case PermissionType.sms:
        return Permission.sms;
      case PermissionType.speech:
        return Permission.speech;
      case PermissionType.storage:
        return Permission.storage;
      case PermissionType.notification:
        return Permission.notification;
      case PermissionType.accessMediaLocation:
        return Permission.accessMediaLocation;
      case PermissionType.activityRecognition:
        return Permission.activityRecognition;
      case PermissionType.bluetooth:
        return Permission.bluetooth;
      case PermissionType.bluetoothScan:
        return Permission.bluetoothScan;
      case PermissionType.bluetoothAdvertise:
        return Permission.bluetoothAdvertise;
      case PermissionType.bluetoothConnect:
        return Permission.bluetoothConnect;
      case PermissionType.systemAlertWindow:
        return Permission.unknown;
      case PermissionType.unknown:
        return Permission.unknown;
    }
  }
}
