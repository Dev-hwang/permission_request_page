import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import 'models/permission_data.dart';
import 'models/permission_type.dart';
import 'models/permissions_request_result.dart';
import 'permission_request_page_method_channel.dart';

/// Utility class that provides functions used in [PermissionRequestPage].
class PermissionRequestPageUtils {
  PermissionRequestPageUtils._internal();

  /// The instance of [PermissionRequestPageUtils].
  static final instance = PermissionRequestPageUtils._internal();

  /// Check permissions status.
  Future<PermissionsRequestResult> checkPermissions(
      List<PermissionData> permissions) async {
    final filteredPermissions =
        await filterByVersion(await filterByPlatform(permissions));

    final methodChannel = MethodChannelPermissionRequestPage.instance;
    final grantedPermissions = <PermissionData>[];
    final deferredPermissions = <PermissionData>[];
    final deniedPermissions = <PermissionData>[];
    PermissionType permissionType;
    Permission permissionObj;
    for (final p in filteredPermissions) {
      permissionType = p.permissionType;
      permissionObj = permissionType.toPermissionObj();

      if (permissionType == PermissionType.systemAlertWindow) {
        if (await methodChannel.canDrawOverlays()) {
          grantedPermissions.add(p);
        } else {
          if (p.isNecessary) {
            deniedPermissions.add(p);
          } else {
            deferredPermissions.add(p);
          }
        }
      } else {
        if (permissionType == PermissionType.locationAlways) {
          permissionObj = Permission.location;
        }

        if (await permissionObj.isGranted) {
          grantedPermissions.add(p);
        } else {
          if (p.isNecessary) {
            deniedPermissions.add(p);
          } else {
            deferredPermissions.add(p);
          }
        }
      }
    }

    return PermissionsRequestResult(
      grantedPermissions: grantedPermissions,
      deferredPermissions: deferredPermissions,
      deniedPermissions: deniedPermissions,
    );
  }

  /// Request permissions.
  Future<PermissionsRequestResult> requestPermissions(
      List<PermissionData> permissions) async {
    final filteredPermissions =
        await filterByVersion(await filterByPlatform(permissions));

    final methodChannel = MethodChannelPermissionRequestPage.instance;
    PermissionType permissionType;
    Permission permissionObj;
    bool willOpenOverlayPermissionSettings = false;
    for (final p in filteredPermissions) {
      permissionType = p.permissionType;
      permissionObj = permissionType.toPermissionObj();

      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        final androidSdk = androidInfo.version.sdkInt;

        if (permissionType == PermissionType.locationAlways) {
          // Android 11(API 수준 30) 이상일 때는 location 권한 먼저 요청한다.
          final isLocationPermissionGranted = androidSdk >= 30
              ? await Permission.location.request().isGranted
              : true;
          if (isLocationPermissionGranted) {
            await Permission.locationAlways.request();
          }
        } else if (permissionType == PermissionType.systemAlertWindow) {
          if (!await methodChannel.canDrawOverlays() && p.isNecessary) {
            willOpenOverlayPermissionSettings = true;
          }
        } else {
          await permissionObj.request();
        }
      } else {
        await permissionObj.request();
      }
    }

    // Overlay 권한 요청
    if (willOpenOverlayPermissionSettings) {
      await methodChannel.openOverlayPermissionSettings();
    }

    return checkPermissions(permissions);
  }

  /// Filters unused [permissions] on a specific platform.
  Future<List<PermissionData>> filterByPlatform(
      List<PermissionData> permissions) async {
    final result = <PermissionData>[];
    PermissionType permissionType;
    for (final permission in permissions) {
      permissionType = permission.permissionType;

      if (Platform.isAndroid) {
        if (permissionType == PermissionType.mediaLibrary ||
            permissionType == PermissionType.photos ||
            permissionType == PermissionType.reminders) {
          continue;
        }
      } else {
        if (permissionType == PermissionType.phone ||
            permissionType == PermissionType.sms ||
            permissionType == PermissionType.activityRecognition ||
            permissionType == PermissionType.systemAlertWindow ||
            permissionType == PermissionType.bluetoothScan ||
            permissionType == PermissionType.bluetoothAdvertise ||
            permissionType == PermissionType.bluetoothConnect) {
          continue;
        }
      }

      result.add(permission);
    }

    return result;
  }

  /// Filters unused [permissions] on a specific version.
  Future<List<PermissionData>> filterByVersion(
      List<PermissionData> permissions) async {
    final result = <PermissionData>[];
    PermissionType permissionType;
    for (final permission in permissions) {
      permissionType = permission.permissionType;

      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        final androidSdk = androidInfo.version.sdkInt;
        if (androidSdk < 29 &&
            permissionType == PermissionType.activityRecognition) {
          continue;
        }
      }

      result.add(permission);
    }

    return result;
  }
}
