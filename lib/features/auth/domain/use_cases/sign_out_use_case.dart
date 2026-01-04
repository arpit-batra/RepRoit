import 'package:rep_roit/core/util/result.dart';
import 'package:rep_roit/features/auth/domain/repository_interfaces/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository authRepository;
  SignOutUseCase({required this.authRepository});

  Future<Result<void>> call() async {
    return await authRepository.signOut();
  }
}
