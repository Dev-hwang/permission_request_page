import 'permission_data.dart';

/// A class that represents the result of permissions request.
class PermissionsRequestResult {
  /// Constructs an instance of [PermissionsRequestResult].
  const PermissionsRequestResult({
    required this.grantedPermissions,
    required this.deferredPermissions,
    required this.deniedPermissions,
  });

  /// List of granted permissions.
  final List<PermissionData> grantedPermissions;

  /// List of deferred permissions.
  final List<PermissionData> deferredPermissions;

  /// List of denied permissions.
  final List<PermissionData> deniedPermissions;

  /// List of all requested permissions.
  List<PermissionData> get permissions =>
      grantedPermissions + deferredPermissions + deniedPermissions;

  /// Whether the required permissions are granted.
  bool get isGranted => deniedPermissions.isEmpty;

  /// Whether any of the permissions are denied.
  bool get isDenied => deniedPermissions.isNotEmpty;
}
