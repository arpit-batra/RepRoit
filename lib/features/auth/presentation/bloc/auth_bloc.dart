import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rep_roit/core/util/result.dart';
import 'package:rep_roit/features/auth/domain/entities/auth_user.dart';
import 'package:rep_roit/features/auth/domain/use_cases/sign_in_with_email_and_password_use_case.dart';
import 'package:rep_roit/features/auth/domain/use_cases/sign_in_with_google_use_case.dart';
import 'package:rep_roit/features/auth/domain/use_cases/sign_up_with_email_and_passwaord_use_case.dart';
import 'package:rep_roit/features/auth/presentation/bloc/auth_bloc_event.dart';
import 'package:rep_roit/features/auth/presentation/bloc/auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final SignInWithEmailAndPasswordUseCase signInWithEmailAndPasswordUseCase;
  final SignUpWithEmailAndPasswaordUseCase signUpWithEmailAndPasswaordUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;

  AuthBloc({
    required this.signInWithEmailAndPasswordUseCase,
    required this.signUpWithEmailAndPasswaordUseCase,
    required this.signInWithGoogleUseCase,
  }) : super(InitialAuthBlocState()) {
    on<SignInSubmitted>(_onSignInSubmitted);
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<GoogleSingInSubmitted>(_onSignInWithGoogle);
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(LoadingAuthBlocState());
    final signUpResult = await signUpWithEmailAndPasswaordUseCase(
      email: event.email,
      password: event.password,
    );
    switch (signUpResult) {
      case Success<AuthUser>(value: final user):
        emit(SuccessAuthBlocState(authUser: user));
      case Error<AuthUser>(failure: final failure):
        emit(FailureAuthBlocState(errorMessage: failure.message));
    }
  }

  Future<void> _onSignInSubmitted(
    SignInSubmitted event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(LoadingAuthBlocState());
    final signInResult = await signInWithEmailAndPasswordUseCase.call(
      email: event.email,
      password: event.password,
    );
    switch (signInResult) {
      case Success<AuthUser>(value: final user):
        emit(SuccessAuthBlocState(authUser: user));
      case Error<AuthUser>(failure: final failure):
        emit(FailureAuthBlocState(errorMessage: failure.message));
    }
  }

  Future<void> _onSignInWithGoogle(
    GoogleSingInSubmitted event,
    Emitter emit,
  ) async {
    emit(GoogleSignInLoadingAuthBlocState());
    final googleSignInResult = await signInWithGoogleUseCase.call();
    switch (googleSignInResult) {
      case Success<AuthUser>(value: final user):
        emit(SuccessAuthBlocState(authUser: user));

      case Error<AuthUser>(failure: final failure):
        emit(FailureAuthBlocState(errorMessage: failure.message));
    }
  }
}
