import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rep_roit/features/auth/domain/use_cases/sign_in_with_email_and_password_use_case.dart';
import 'package:rep_roit/features/auth/domain/use_cases/sign_up_with_email_and_passwaord_use_case.dart';
import 'package:rep_roit/features/auth/presentation/bloc/auth_bloc_event.dart';
import 'package:rep_roit/features/auth/presentation/bloc/auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final SignInWithEmailAndPasswordUseCase signInWithEmailAndPasswordUseCase;
  final SignUpWithEmailAndPasswaordUseCase signUpWithEmailAndPasswaordUseCase;

  AuthBloc({
    required this.signInWithEmailAndPasswordUseCase,
    required this.signUpWithEmailAndPasswaordUseCase,
  }) : super(InitialAuthBlocState()) {
    on<SignInSubmitted>(_onSignInSubmitted);
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(LoadingAuthBlocState());
    try {
      final authUser = await signUpWithEmailAndPasswaordUseCase(
        email: event.email,
        password: event.password,
      );
      emit(SuccessAuthBlocState(authUser: authUser));
    } catch (e) {
      emit(FailureAuthBlocState(errorMessage: e.toString()));
    }
  }

  Future<void> _onSignInSubmitted(
    SignInSubmitted event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(LoadingAuthBlocState());
    try {
      final authUser = await signInWithEmailAndPasswordUseCase.call(
        email: event.email,
        password: event.password,
      );
      emit(SuccessAuthBlocState(authUser: authUser));
    } catch (e) {
      emit(FailureAuthBlocState(errorMessage: e.toString()));
    }
  }
}
