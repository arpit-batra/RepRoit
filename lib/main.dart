import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rep_roit/app.dart';
import 'package:rep_roit/features/auth/data/repositories/firebase_auth_repository.dart';
import 'package:rep_roit/features/auth/domain/use_cases/sign_in_with_email_and_password_use_case.dart';
import 'package:rep_roit/features/auth/domain/use_cases/sign_in_with_google_use_case.dart';
import 'package:rep_roit/features/auth/domain/use_cases/sign_up_with_email_and_passwaord_use_case.dart';
import 'package:rep_roit/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authRepository = FirebaseAuthRepository(
    firebaseAuth: FirebaseAuth.instance,
  );
  final signInWithEmailAndPasswordUseCase = SignInWithEmailAndPasswordUseCase(
    authRepository: authRepository,
  );
  final signUpWithEmailAndPasswaordUseCase = SignUpWithEmailAndPasswaordUseCase(
    authRepository: authRepository,
  );
  final signInWithGoogleUseCase = SignInWithGoogleUseCase(
    authRepository: authRepository,
  );

  runApp(
    MyApp(
      signInWithEmailAndPasswordUseCase: signInWithEmailAndPasswordUseCase,
      signUpWithEmailAndPasswaordUseCase: signUpWithEmailAndPasswaordUseCase,
      signInWithGoogleUseCase: signInWithGoogleUseCase,
    ),
  );
}
