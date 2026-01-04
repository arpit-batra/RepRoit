import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rep_roit/core/errors/failures.dart';
import 'package:rep_roit/core/util/result.dart';
import 'package:rep_roit/features/auth/domain/entities/auth_user.dart';
import 'package:rep_roit/features/auth/domain/repository_interfaces/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthRepository({required this.firebaseAuth});

  @override
  Future<Result<AuthUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredentials = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredentials.user;
      return Success(
        AuthUser(
          id: user?.uid ?? '',
          email: user?.email ?? '',
          name: user?.displayName ?? '',
          phone: user?.phoneNumber ?? '',
        ),
      );
    } catch (e) {
      return Error(AuthFailure("Firebase Sign In Failed"));
    }
  }

  @override
  Future<Result<AuthUser>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredentials = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredentials.user;
      return Success(
        AuthUser(
          id: user?.uid ?? '',
          email: user?.email ?? '',
          name: user?.displayName ?? '',
          phone: user?.phoneNumber ?? '',
        ),
      );
    } catch (e) {
      return Error(AuthFailure("Firebase Sign Up Failed"));
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await firebaseAuth.signOut();
      return Success(null);
    } catch (e) {
      return Error(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Result<AuthUser>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      return Success(
        AuthUser(
          id: userCredential.user?.uid ?? '',
          email: userCredential.user?.email ?? '',
          name: userCredential.user?.displayName ?? '',
          phone: userCredential.user?.phoneNumber ?? '',
        ),
      );
    } catch (e) {
      return Error(AuthFailure(e.toString()));
    }
  }
}
