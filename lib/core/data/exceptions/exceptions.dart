sealed class CoreException implements Exception {
  final String? message;

  CoreException([this.message]);
}

class UnknownException extends CoreException {
  UnknownException([super.message]);
}
