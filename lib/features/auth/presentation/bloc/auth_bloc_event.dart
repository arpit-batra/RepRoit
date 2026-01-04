import 'package:equatable/equatable.dart';

class AuthBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInSubmitted extends AuthBlocEvent {
  final String email;
  final String password;

  SignInSubmitted({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class GoogleSingInSubmitted extends AuthBlocEvent {}

class SignUpSubmitted extends AuthBlocEvent {
  final String email;
  final String password;

  SignUpSubmitted({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignOutSubmitted extends AuthBlocEvent {}
