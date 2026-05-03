class AppException implements Exception {
  const AppException(this.message);
  final String message;
}

class CacheException extends AppException {
  const CacheException([super.message = 'Local storage operation failed.']);
}

class ValidationException extends AppException {
  const ValidationException([super.message = 'Validation failed.']);
}
