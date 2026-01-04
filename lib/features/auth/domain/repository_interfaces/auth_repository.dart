import 'package:rep_roit/core/util/result.dart';
import 'package:rep_roit/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Future<Result<AuthUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Result<AuthUser>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Result<AuthUser>> signInWithGoogle();

  Future<Result<void>> signOut();
}
