import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rep_roit/features/auth/domain/use_cases/sign_in_with_email_and_password_use_case.dart';
import 'package:rep_roit/features/auth/domain/use_cases/sign_in_with_google_use_case.dart';
import 'package:rep_roit/features/auth/domain/use_cases/sign_up_with_email_and_passwaord_use_case.dart';
import 'package:rep_roit/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rep_roit/router.dart';

class MyApp extends StatelessWidget {
  final SignInWithEmailAndPasswordUseCase signInWithEmailAndPasswordUseCase;
  final SignUpWithEmailAndPasswaordUseCase signUpWithEmailAndPasswaordUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  late GoRouter _router;

  MyApp({
    super.key,
    required this.signInWithEmailAndPasswordUseCase,
    required this.signUpWithEmailAndPasswaordUseCase,
    required this.signInWithGoogleUseCase,
  }) {
    _router = createRouter();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        signInWithEmailAndPasswordUseCase: signInWithEmailAndPasswordUseCase,
        signUpWithEmailAndPasswaordUseCase: signUpWithEmailAndPasswaordUseCase,
        signInWithGoogleUseCase: signInWithGoogleUseCase,
      ),
      child: MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
