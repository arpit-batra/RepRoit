import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rep_roit/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rep_roit/features/auth/presentation/bloc/auth_bloc_event.dart';
import 'package:rep_roit/features/auth/presentation/bloc/auth_bloc_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  _onSignInPressed() {
    context.read<AuthBloc>().add(
      SignInSubmitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In")),
      body: BlocConsumer<AuthBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is SuccessAuthBlocState) {
            context.go('/home');
          } else if (state is FailureAuthBlocState) {
            showAboutDialog(
              context: context,
              children: [Text(state.errorMessage)],
            );
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          final isLoading = state is LoadingAuthBlocState;
          return Padding(
            padding: .all(16),
            child: Column(
              children: [
                Padding(
                  padding: .only(bottom: 12),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                ),
                Padding(
                  padding: .only(bottom: 24),
                  child: TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                ),
                ElevatedButton(
                  onPressed: isLoading ? null : _onSignInPressed,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Sign-in'),
                ),
                Wrap(
                  children: [
                    Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () => context.go('/sign-up'),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(GoogleSingInSubmitted());
                  },
                  child: state is GoogleSignInLoadingAuthBlocState
                      ? CircularProgressIndicator()
                      : Text("Sign in with Google"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
