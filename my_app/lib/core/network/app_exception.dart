/// Typed exception used for predictable user-facing failures.
class AppException implements Exception {
  /// Creates an application exception.
  const AppException(this.message);

  final String message;

  @override
  String toString() => message;
}
