import 'package:equatable/equatable.dart';

/// Base class for all domain-level failures/errors.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Returned when a remote server error or non-200 HTTP response occurs.
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'A server error occurred.']);
}

/// Returned when local database or preference retrieval fails.
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'A local storage error occurred.']);
}

/// Returned when there is a network connectivity issue.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection detected.']);
}
