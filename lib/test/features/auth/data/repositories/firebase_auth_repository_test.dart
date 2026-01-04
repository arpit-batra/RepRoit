import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rep_roit/features/auth/data/repositories/firebase_auth_repository.dart';
import 'package:rep_roit/features/auth/domain/entities/auth_user.dart';
import 'package:rep_roit/core/errors/failures.dart';
import 'package:rep_roit/core/util/result.dart';

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
  const tAuthUser = Success(
    AuthUser(id: tId, email: tEmail, name: tName, phone: tPhone),
  );
  const tSignInError = Error<AuthUser>(AuthFailure("Firebase Sign In Failed"));
  const tSignUpError = Error<AuthUser>(AuthFailure("Firebase Sign Up Failed"));
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

    final signInResult = await firebaseAuthRepository
        .signInWithEmailAndPassword(email: tEmail, password: tPassword);

    expect(signInResult, tAuthUser);
    verify(
      () => mockFirebaseAuth.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      ),
    );
  });

  test('firebase sign in with email and password returns Error', () async {
    when(
      () => mockFirebaseAuth.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      ),
    ).thenAnswer((inv) async {
      throw (FirebaseAuthException(code: "123"));
    });
    final signInResult = await firebaseAuthRepository
        .signInWithEmailAndPassword(email: tEmail, password: tPassword);
    expect(signInResult, tSignInError);
    verify(
      () => mockFirebaseAuth.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      ),
    );
  });

  test('firebase sign up with email and password returns AuthUser', () async {
    when(
      () => mockFirebaseAuth.createUserWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      ),
    ).thenAnswer((invocation) async => mockUserCredential);
    when(() => mockUserCredential.user).thenReturn(mockUser);
    when(() => mockUser.displayName).thenReturn(tName);
    when(() => mockUser.email).thenReturn(tEmail);
    when(() => mockUser.phoneNumber).thenReturn(tPhone);
    when(() => mockUser.uid).thenReturn(tId);

    final signUpResult = await firebaseAuthRepository
        .signUpWithEmailAndPassword(email: tEmail, password: tPassword);

    expect(signUpResult, tAuthUser);
    verify(
      () => mockFirebaseAuth.createUserWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      ),
    );
  });

  test('firebase sign up with email and password returns Error', () async {
    when(
      () => mockFirebaseAuth.createUserWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      ),
    ).thenAnswer((inv) async {
      throw (FirebaseAuthException(code: "123"));
    });
    final signUpResult = await firebaseAuthRepository
        .signUpWithEmailAndPassword(email: tEmail, password: tPassword);
    expect(signUpResult, tSignUpError);
    verify(
      () => mockFirebaseAuth.createUserWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      ),
    );
  });

  test('firebase Sign out return Success', () async {
    when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async {});

    final result = await firebaseAuthRepository.signOut();
    expect(result, Success<void>(null));
    verify(() => mockFirebaseAuth.signOut()).called(1);
  });

  test('firebase Sign out return Error', () async {
    when(
      () => mockFirebaseAuth.signOut(),
    ).thenThrow(Exception('Sign Out Failed'));

    final result = await firebaseAuthRepository.signOut();
    expect(result, Error<void>(AuthFailure('Exception: Sign Out Failed')));
    verify(() => mockFirebaseAuth.signOut()).called(1);
  });

  // test('firebase Google Sign in returns AuthUser', () {
  //   when(() => mockFirebaseAuth.,)
  // });
}
