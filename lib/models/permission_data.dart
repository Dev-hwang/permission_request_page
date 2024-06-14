import 'permission_type.dart';

/// A data model that defines permission request information.
class PermissionData {
  /// Constructs an instance of [PermissionData].
  const PermissionData({
    required this.permissionType,
    this.permissionName,
    this.description,
    this.isNecessary = false,
  });

  /// The type of permission to request.
  final PermissionType permissionType;

  /// The permission name that will be displayed on the screen.
  final String? permissionName;

  /// The description of permission to request.
  final String? description;

  /// Whether the permission should be granted as required.
  final bool isNecessary;
}
