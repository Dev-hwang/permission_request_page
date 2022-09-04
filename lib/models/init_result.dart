/// A class that represents the result of app initialization.
class InitResult {
  /// Constructs an instance of [InitResult].
  const InitResult({
    required this.complete,
    this.error,
    this.stackTrace,
    this.showsError = true,
    this.errorMessage,
  });

  /// Whether the app initialization is complete.
  final bool complete;

  /// An error occurred during the app initialization.
  final dynamic error;

  /// The stackTrace of the error.
  final dynamic stackTrace;

  /// Whether to show a dialog when an error occurs.
  final bool showsError;

  /// The error message to display when [showsError] is `true`.
  final String? errorMessage;
}
