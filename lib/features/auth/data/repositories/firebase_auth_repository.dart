import 'package:firebase_auth/firebase_auth.dart';
import 'package:rep_roit/features/auth/domain/entities/auth_user.dart';
import 'package:rep_roit/features/auth/domain/repository_interfaces/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthRepository({required this.firebaseAuth});

  @override
  Future<AuthUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredentials = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredentials.user;
      return AuthUser(
        id: user?.uid ?? '',
        email: user?.email ?? '',
        name: user?.displayName ?? '',
        phone: user?.phoneNumber ?? '',
      );
    } catch (e) {
      return AuthUser(id: "", email: "", name: "", phone: "");
    }
  }

  @override
  Future<AuthUser> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    //TODO: implement signUpWithPassword
    throw UnimplementedError();
  }
}
