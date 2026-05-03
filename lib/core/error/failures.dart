abstract class Failure {
  const Failure(this.message);
  final String message;
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Unable to process local data.']);
}

class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Invalid input provided.']);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Something went wrong.']);
}
