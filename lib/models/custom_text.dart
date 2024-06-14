/// The text to be displayed on the permission request screen.
class CustomText {
  const CustomText({
    this.permissionViewHeaderText,
    this.permissionRequestButtonText,
    this.popupTextWhenPermissionDenied,
  });

  /// The text to be displayed in the header on the permission request screen.
  /// It is used to inform the user that the following permissions are required to use the app.
  final String? permissionViewHeaderText;

  /// The text to be displayed in the permission request button on the permission request screen.
  final String? permissionRequestButtonText;

  /// The text to be displayed in pop-up when required permission is denied.
  final String? popupTextWhenPermissionDenied;
}
