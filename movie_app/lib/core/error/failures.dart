import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure({
    String message = 'A server error occurred. Please try again.',
    this.statusCode,
  }) : super(message);

  @override
  List<Object?> get props => [message, statusCode];
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    String message = 'Unable to connect to the server. Please check your internet connection.',
  }) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure({
    String message = 'Unable to load data from local cache.',
  }) : super(message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    String message = 'An unexpected error occurred. Please try again later.',
  }) : super(message);
}
