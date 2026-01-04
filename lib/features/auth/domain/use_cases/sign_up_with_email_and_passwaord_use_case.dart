import 'package:rep_roit/core/util/result.dart';
import 'package:rep_roit/features/auth/domain/entities/auth_user.dart';
import 'package:rep_roit/features/auth/domain/repository_interfaces/auth_repository.dart';

class SignUpWithEmailAndPasswaordUseCase {
  final AuthRepository authRepository;

  SignUpWithEmailAndPasswaordUseCase({required this.authRepository});

  Future<Result<AuthUser>> call({
    required String email,
    required String password,
  }) async {
    return await authRepository.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
