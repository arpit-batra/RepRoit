import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:rep_roit/features/auth/domain/entities/auth_user.dart';
import 'package:rep_roit/features/auth/domain/use_cases/sign_in_with_email_and_password_use_case.dart';
import 'package:rep_roit/features/auth/domain/use_cases/sign_up_with_email_and_passwaord_use_case.dart';
import 'package:rep_roit/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rep_roit/features/auth/presentation/bloc/auth_bloc_event.dart';
import 'package:rep_roit/features/auth/presentation/bloc/auth_bloc_state.dart';

class MockSignInWithEmailAndPasswordUseCase extends Mock
    implements SignInWithEmailAndPasswordUseCase {}

class MockSignUpWithEmailAndPasswordUseCase extends Mock
    implements SignUpWithEmailAndPasswaordUseCase {}

void main() {
  late SignInWithEmailAndPasswordUseCase mockSignInWithEmailAndPasswordUseCase;
  late SignUpWithEmailAndPasswaordUseCase mockSignUpWithEmailAndPasswordUseCase;

  setUp(() {
    mockSignInWithEmailAndPasswordUseCase =
        MockSignInWithEmailAndPasswordUseCase();
    mockSignUpWithEmailAndPasswordUseCase =
        MockSignUpWithEmailAndPasswordUseCase();
  });

  const tEmail = 'arpitbatra98@gmail.com';
  const tId = '1';
  const tPassword = 'Testing@123';
  const tName = 'Arpit Batra';
  const tPhone = '2489542093';
  const tAuthUser = AuthUser(
    id: tId,
    email: tEmail,
    name: tName,
    phone: tPhone,
  );
  blocTest(
    'emits [LoadingAuthBlocState,SuccessAuthBlocState] when sign in succeeds',
    build: () {
      when(
        () => mockSignInWithEmailAndPasswordUseCase.call(
          email: tEmail,
          password: tPassword,
        ),
      ).thenAnswer((_) async => tAuthUser);

      return AuthBloc(
        signInWithEmailAndPasswordUseCase:
            mockSignInWithEmailAndPasswordUseCase,
        signUpWithEmailAndPasswaordUseCase:
            mockSignUpWithEmailAndPasswordUseCase,
      );
    },
    act: (bloc) =>
        bloc.add(SignInSubmitted(email: tEmail, password: tPassword)),
    expect: () => [isA<LoadingAuthBlocState>(), isA<SuccessAuthBlocState>()],
    verify: (bloc) {
      verify(
        () => mockSignInWithEmailAndPasswordUseCase.call(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
    },
  );

  blocTest(
    'emits [Loading, Failure] when use case fails or throws error',
    build: () {
      when(
        () => mockSignInWithEmailAndPasswordUseCase.call(
          email: tEmail,
          password: tPassword,
        ),
      ).thenThrow(Exception());
      return AuthBloc(
        signInWithEmailAndPasswordUseCase:
            mockSignInWithEmailAndPasswordUseCase,
        signUpWithEmailAndPasswaordUseCase:
            mockSignUpWithEmailAndPasswordUseCase,
      );
    },
    act: (bloc) =>
        bloc.add(SignInSubmitted(email: tEmail, password: tPassword)),
    expect: () => [isA<LoadingAuthBlocState>(), isA<FailureAuthBlocState>()],
    verify: (bloc) {
      verify(
        () => mockSignInWithEmailAndPasswordUseCase.call(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
    },
  );

  blocTest(
    'Bloc emits [LoadingBlocAuthState,SuccessAuthBlocState]',
    build: () {
      when(
        () => mockSignUpWithEmailAndPasswordUseCase.call(
          email: tEmail,
          password: tPassword,
        ),
      ).thenAnswer((invocation) async => tAuthUser);
      return AuthBloc(
        signInWithEmailAndPasswordUseCase:
            mockSignInWithEmailAndPasswordUseCase,
        signUpWithEmailAndPasswaordUseCase:
            mockSignUpWithEmailAndPasswordUseCase,
      );
    },
    act: (bloc) =>
        bloc.add(SignUpSubmitted(email: tEmail, password: tPassword)),
    expect: () => [
      LoadingAuthBlocState(),
      SuccessAuthBlocState(authUser: tAuthUser),
    ],
    verify: (bloc) => verify(
      () => mockSignUpWithEmailAndPasswordUseCase(
        email: tEmail,
        password: tPassword,
      ),
    ).called(1),
  );
}
