import 'dart:io';

import 'package:flutter/services.dart';

/// An implementation of [PermissionRequestPage] method channels.
class MethodChannelPermissionRequestPage {
  MethodChannelPermissionRequestPage._internal();

  /// The instance of [MethodChannelPermissionRequestPage].
  static final instance = MethodChannelPermissionRequestPage._internal();

  final _methodChannel =
      const MethodChannel('flutter.pravera.com/permission_request_page/method');

  /// Whether the overlay permission can draw content.
  Future<bool> canDrawOverlays() async {
    if (Platform.isAndroid) {
      return await _methodChannel.invokeMethod('canDrawOverlays');
    } else {
      return Future.value(false);
    }
  }

  /// Open the overlay permission settings.
  Future<bool> openOverlayPermissionSettings() async {
    if (Platform.isAndroid) {
      return await _methodChannel.invokeMethod('openOverlayPermissionSettings');
    } else {
      return Future.value(false);
    }
  }

  /// Whether location services are enabled.
  Future<bool> isLocationServicesEnabled() async {
    return await _methodChannel.invokeMethod('isLocationServicesEnabled');
  }

  /// Open location services settings.
  Future<bool> openLocationServicesSettings() async {
    return await _methodChannel.invokeMethod('openLocationServicesSettings');
  }
}
