import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
}

class AuthFailure extends Failure {
  const AuthFailure(String message) : super(message);

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
  @override
  List<Object?> get props => [message];
}
