import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rep_roit/features/auth/data/repositories/firebase_auth_repository.dart';
import 'package:rep_roit/features/auth/domain/entities/auth_user.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late FirebaseAuthRepository firebaseAuthRepository;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;

  const tEmail = 'arpitbatra98@gmail.com';
  const tPassword = 'Testing@123';
  const tName = 'Arpit Batra';
  const tId = '1';
  const tPhone = '9996836502';
  const tAuthUser = AuthUser(
    id: tId,
    email: tEmail,
    name: tName,
    phone: tPhone,
  );

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    firebaseAuthRepository = FirebaseAuthRepository(
      firebaseAuth: mockFirebaseAuth,
    );
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
  });

  test('firebase sign in with email and password returns AuthUser', () async {
    when(
      () => mockFirebaseAuth.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      ),
    ).thenAnswer((invocation) async => mockUserCredential);
    when(() => mockUserCredential.user).thenReturn(mockUser);
    when(() => mockUser.displayName).thenReturn(tName);
    when(() => mockUser.email).thenReturn(tEmail);
    when(() => mockUser.phoneNumber).thenReturn(tPhone);
    when(() => mockUser.uid).thenReturn(tId);

    final authUser = await firebaseAuthRepository.signInWithEmailAndPassword(
      email: tEmail,
      password: tPassword,
    );

    expect(authUser, tAuthUser);
    verify(
      () => mockFirebaseAuth.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      ),
    );
  });
}
