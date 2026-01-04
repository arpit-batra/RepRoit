import 'package:rep_roit/core/util/result.dart';
import 'package:rep_roit/features/auth/domain/entities/auth_user.dart';
import 'package:rep_roit/features/auth/domain/repository_interfaces/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository authRepository;

  SignInWithGoogleUseCase({required this.authRepository});

  Future<Result<AuthUser>> call() {
    return authRepository.signInWithGoogle();
  }
}
