import 'package:equatable/equatable.dart';
import 'package:rep_roit/features/auth/domain/entities/auth_user.dart';

class AuthBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialAuthBlocState extends AuthBlocState {}

class LoadingAuthBlocState extends AuthBlocState {}

class GoogleSignInLoadingAuthBlocState extends AuthBlocState {}

class SuccessAuthBlocState extends AuthBlocState {
  final AuthUser authUser;
  SuccessAuthBlocState({required this.authUser});

  @override
  List<Object?> get props => [authUser];
}

class FailureAuthBlocState extends AuthBlocState {
  final String errorMessage;
  FailureAuthBlocState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
