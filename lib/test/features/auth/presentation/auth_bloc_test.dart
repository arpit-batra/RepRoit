import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:rep_roit/features/auth/domain/entities/auth_user.dart';
import 'package:rep_roit/features/auth/domain/use_cases/sign_in_with_email_and_password_use_case.dart';
import 'package:rep_roit/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rep_roit/features/auth/presentation/bloc/auth_bloc_event.dart';
import 'package:rep_roit/features/auth/presentation/bloc/auth_bloc_state.dart';

class MockSignInWithEmailAndPasswordUseCase extends Mock
    implements SignInWithEmailAndPasswordUseCase {}

void main() {
  late SignInWithEmailAndPasswordUseCase mockSignInWithEmailAndPasswordUseCase;
  setUp(() {
    mockSignInWithEmailAndPasswordUseCase =
        MockSignInWithEmailAndPasswordUseCase();
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
    'How bloc handles when use case fails or throws error',
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
}
