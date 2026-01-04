import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rep_roit/core/util/result.dart';
import 'package:rep_roit/features/auth/domain/entities/auth_user.dart';
import 'package:rep_roit/features/auth/domain/repository_interfaces/auth_repository.dart';
import 'package:rep_roit/features/auth/domain/use_cases/sign_in_with_google_use_case.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignInWithGoogleUseCase signInWithGoogleUseCase;

  const tEmail = 'arpitbatra98@gmail.com';
  const tAuthUser = AuthUser(
    id: '1',
    email: tEmail,
    name: 'Arpit Batra',
    phone: '9996836502',
  );

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signInWithGoogleUseCase = SignInWithGoogleUseCase(
      authRepository: mockAuthRepository,
    );
  });

  // test('should return AuthUser when SignInWithGoogle Succeeds ', () async {
  //   when(
  //     () => mockAuthRepository.signInWithGoogle(email: tEmail),
  //   ).thenAnswer((_) async => Success(tAuthUser));
  //   final actualAuthUser = await signInWithGoogleUseCase.call(tEmail);
  //   expect(actualAuthUser, Success(tAuthUser));
  //   verify(() => mockAuthRepository.signInWithGoogle(email: tEmail)).called(1);
  // });
}
