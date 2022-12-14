import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_request_page/localization.dart';

/// Defines the types of permissions that can be requested.
///
/// It works the same as the permission_handler plugin's [Permission] class.
enum PermissionType {
  /// Android: Calendar
  ///
  /// iOS: Calendar (Events)
  calendar,

  /// Android: Camera
  ///
  /// iOS: Photos (Camera Roll and Camera)
  camera,

  /// Android: Contacts
  ///
  /// iOS: AddressBook
  contacts,

  /// Android: Fine and Coarse Location
  ///
  /// iOS: CoreLocation (Always and WhenInUse)
  location,

  /// Android: Background Location
  ///
  /// iOS: CoreLocation (Always)
  locationAlways,

  /// Android: None
  ///
  /// iOS: MPMediaLibrary
  mediaLibrary,

  /// Android: Microphone
  ///
  /// iOS: Microphone
  microphone,

  /// Android: Phone
  ///
  /// iOS: Nothing
  phone,

  /// Android: Nothing
  ///
  /// iOS: Photos
  photos,

  /// Android: Nothing
  ///
  /// iOS: Reminders
  reminders,

  /// Android: Body Sensors
  ///
  /// iOS: CoreMotion
  sensors,

  /// Android: SMS
  ///
  /// iOS: Nothing
  sms,

  /// Android: Microphone
  ///
  /// iOS: Speech
  speech,

  /// Android: External Storage
  ///
  /// iOS: Access to folders like `Documents` or `Downloads`.
  storage,

  /// Android: Notification
  ///
  /// iOS: Notification
  notification,

  /// Android: Allows an application to access any geographic locations
  /// persisted in the user's shared collection.
  accessMediaLocation,

  /// Android: Activity Recognition
  ///
  /// iOS: Nothing
  activityRecognition,

  /// iOS 13 and above: The authorization state of Core Bluetooth manager.
  /// When running < iOS 13 or Android this is always allowed.
  bluetooth,

  /// Android: Allows the user to look for Bluetooth devices (e.g. BLE peripherals).
  ///
  /// iOS: Nothing
  bluetoothScan,

  /// Android: Allows the user to make this device discoverable to other Bluetooth devices.
  ///
  /// iOS: Nothing
  bluetoothAdvertise,

  /// Android: Allows the user to connect with already paired Bluetooth devices.
  ///
  /// iOS: Nothing
  bluetoothConnect,

  /// Android: Allows an app to create windows shown on top of all other apps.
  ///
  /// iOS: Nothing
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
  String defaultName({bool necessary = false}) {
    String strName;
    switch (this) {
      case PermissionType.calendar:
        strName = Localization.permissionName('calendar');
        break;
      case PermissionType.camera:
        strName = Localization.permissionName('camera');
        break;
      case PermissionType.contacts:
        strName = Localization.permissionName('contacts');
        break;
      case PermissionType.location:
        strName = Localization.permissionName('location');
        break;
      case PermissionType.locationAlways:
        strName = Localization.permissionName('locationAlways');
        break;
      case PermissionType.mediaLibrary:
        strName = Localization.permissionName('mediaLibrary');
        break;
      case PermissionType.microphone:
        strName = Localization.permissionName('microphone');
        break;
      case PermissionType.phone:
        strName = Localization.permissionName('phone');
        break;
      case PermissionType.photos:
        strName = Localization.permissionName('photos');
        break;
      case PermissionType.reminders:
        strName = Localization.permissionName('reminders');
        break;
      case PermissionType.sensors:
        strName = Localization.permissionName('sensors');
        break;
      case PermissionType.sms:
        strName = Localization.permissionName('sms');
        break;
      case PermissionType.speech:
        strName = Localization.permissionName('speech');
        break;
      case PermissionType.storage:
        strName = Localization.permissionName('storage');
        break;
      case PermissionType.notification:
        strName = Localization.permissionName('notification');
        break;
      case PermissionType.accessMediaLocation:
        strName = Localization.permissionName('accessMediaLocation');
        break;
      case PermissionType.activityRecognition:
        strName = Localization.permissionName('activityRecognition');
        break;
      case PermissionType.bluetooth:
        strName = Localization.permissionName('bluetooth');
        break;
      case PermissionType.bluetoothScan:
        strName = Localization.permissionName('bluetoothScan');
        break;
      case PermissionType.bluetoothAdvertise:
        strName = Localization.permissionName('bluetoothAdvertise');
        break;
      case PermissionType.bluetoothConnect:
        strName = Localization.permissionName('bluetoothConnect');
        break;
      case PermissionType.systemAlertWindow:
        strName = Localization.permissionName('systemAlertWindow');
        break;
      case PermissionType.unknown:
        strName = Localization.permissionName('unknown');
    }

    return strName + ' ${Localization.necessary(necessary)}';
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
