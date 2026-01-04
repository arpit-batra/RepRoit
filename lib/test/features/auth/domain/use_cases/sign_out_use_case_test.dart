import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rep_roit/core/errors/failures.dart';
import 'package:rep_roit/core/util/result.dart';
import 'package:rep_roit/features/auth/domain/repository_interfaces/auth_repository.dart';
import 'package:rep_roit/features/auth/domain/use_cases/sign_out_use_case.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;
  late SignOutUseCase signOutUseCase;

  setUp(() {
    authRepository = MockAuthRepository();
    signOutUseCase = SignOutUseCase(authRepository: authRepository);
  });

  test('Sign out Successfully', () async {
    when(
      () => authRepository.signOut(),
    ).thenAnswer((_) async => Success<void>(null));
    final signOutResponse = await signOutUseCase.call();
    expect(signOutResponse, Success<void>(null));
    verify(() => authRepository.signOut()).called(1);
  });
  test('Sign out Failed', () async {
    when(
      () => authRepository.signOut(),
    ).thenAnswer((_) async => Error<void>(AuthFailure('Sign Out Failed')));
    final signOutResponse = await signOutUseCase.call();
    expect(signOutResponse, Error<void>(AuthFailure('Sign Out Failed')));
    verify(() => authRepository.signOut()).called(1);
  });
}
