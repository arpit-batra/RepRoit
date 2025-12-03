import 'package:rep_roit/features/auth/domain/entities/auth_user.dart';
import 'package:rep_roit/features/auth/domain/repository_interfaces/auth_repository.dart';

class SignInWithEmailAndPasswordUseCase {
  final AuthRepository authRepository;

  SignInWithEmailAndPasswordUseCase({required this.authRepository});

  Future<AuthUser> call({required String email, required String password}) {
    return authRepository.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }
}
