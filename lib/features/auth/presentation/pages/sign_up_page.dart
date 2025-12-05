import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rep_roit/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rep_roit/features/auth/presentation/bloc/auth_bloc_event.dart';
import 'package:rep_roit/features/auth/presentation/bloc/auth_bloc_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signUpSubmission() {
    context.read<AuthBloc>().add(
      SignUpSubmitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: BlocConsumer<AuthBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is SuccessAuthBlocState) {
            context.go('/home');
          } else if (state is FailureAuthBlocState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Unable to Sign up - ${state.errorMessage}"),
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Form(
              child: Column(
                children: [
                  Padding(
                    padding: .all(16),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(hint: Text("enter email")),
                    ),
                  ),
                  Padding(
                    padding: .all(16),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(hint: Text("enter Password")),
                    ),
                  ),
                  Padding(
                    padding: .all(24),
                    child: ElevatedButton(
                      onPressed: state is LoadingAuthBlocState
                          ? null
                          : () {
                              _signUpSubmission();
                            },
                      child: state is LoadingAuthBlocState
                          ? CircularProgressIndicator()
                          : Text("Sign Up"),
                    ),
                  ),
                  Wrap(
                    children: [
                      Text("Already have an account? "),
                      GestureDetector(
                        onTap: () => context.go('/'),
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
