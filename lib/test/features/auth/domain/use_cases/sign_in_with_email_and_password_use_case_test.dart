import 'package:mocktail/mocktail.dart';
import 'package:rep_roit/features/auth/domain/entities/auth_user.dart';
import 'package:rep_roit/features/auth/domain/repository_interfaces/auth_repository.dart';
import 'package:rep_roit/features/auth/domain/use_cases/sign_in_with_email_and_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignInWithEmailAndPasswordUseCase signInWithEmailAndPasswordUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signInWithEmailAndPasswordUseCase = SignInWithEmailAndPasswordUseCase(
      authRepository: mockAuthRepository,
    );
  });

  test('should return AuthUser when signin successds', () async {
    const tEmail = 'arpitbatra98@gmail.com';
    const tPassword = 'Testing@123';
    const tName = 'Arpit Batra';
    const tPhone = '9996836502';
    const tId = '1';

    final tAuthUser = AuthUser(
      id: tId,
      email: tEmail,
      name: tName,
      phone: tPhone,
    );

    when(
      () => mockAuthRepository.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      ),
    ).thenAnswer((_) async => tAuthUser);

    final authUserOutput = await signInWithEmailAndPasswordUseCase.call(
      email: tEmail,
      password: tPassword,
    );

    expect(authUserOutput, tAuthUser);

    verify(
      () => mockAuthRepository.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      ),
    ).called(1);
  });

  test('should trim input email', () async {
    const tEmail = 'arpitbatra98@gmail.com';
    const tEmailWithLeadingAndTrailingSpaces = '  arpitbatra98@gmail.com  ';
    const tPassword = 'Testing@123';
    const tName = 'Arpit Batra';
    const tPhone = '9996836502';
    const tId = '1';

    final tAuthUser = AuthUser(
      id: tId,
      email: tEmail,
      name: tName,
      phone: tPhone,
    );

    when(
      () => mockAuthRepository.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      ),
    ).thenAnswer((_) async => tAuthUser);

    final authUserOutput = await signInWithEmailAndPasswordUseCase.call(
      email: tEmailWithLeadingAndTrailingSpaces,
      password: tPassword,
    );

    expect(authUserOutput, tAuthUser);

    verify(
      () => mockAuthRepository.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      ),
    ).called(1);
  });
}
