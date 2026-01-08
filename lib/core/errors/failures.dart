/// Base class for all failures in the app.
/// Enables type-safe error handling across layers.
abstract class Failure {
  final String message;
  
  const Failure(this.message);
}

/// Represents Firebase-related failures.
class FirebaseFailure extends Failure {
  const FirebaseFailure(super.message);
}

/// Represents network-related failures.
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}