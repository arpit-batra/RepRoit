import 'package:mocktail/mocktail.dart';
import 'package:rep_roit/core/util/result.dart';
import 'package:rep_roit/features/auth/domain/entities/auth_user.dart';
import 'package:rep_roit/features/auth/domain/repository_interfaces/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rep_roit/features/auth/domain/use_cases/sign_up_with_email_and_passwaord_use_case.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignUpWithEmailAndPasswaordUseCase signUpWithEmailAndPasswaordUseCase;
  const String tEmail = 'arpitbatra98@gmail.com';
  const String tPassword = 'Testing@123';
  const String tId = '1';
  const String tName = 'Arpit';
  const String tPhone = '9996836502';
  const tAuthUser = Success(
    AuthUser(id: tId, email: tEmail, name: tName, phone: tPhone),
  );

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signUpWithEmailAndPasswaordUseCase = SignUpWithEmailAndPasswaordUseCase(
      authRepository: mockAuthRepository,
    );
  });

  test('SignUpWithEmailAndPassword returns AuthUser', () async {
    when(
      () => mockAuthRepository.signUpWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      ),
    ).thenAnswer((_) async => tAuthUser);
    final outputAuthUser = await signUpWithEmailAndPasswaordUseCase.call(
      email: tEmail,
      password: tPassword,
    );
    expect(outputAuthUser, tAuthUser);
    verify(
      () => mockAuthRepository.signUpWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      ),
    ).called(1);
  });
}
