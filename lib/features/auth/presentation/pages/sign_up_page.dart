import 'package:blog_app/core/common/widgets/loading.dart';
import 'package:blog_app/core/utils/app_navigator.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Loading();
            }
            return Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 15,
                  children: [
                    Text(
                      'Sign Up Page',
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleLarge?.fontSize),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthTextField(
                      controller: _nameController,
                      hintText: 'Name',
                    ),
                    AuthTextField(
                      controller: _emailController,
                      hintText: 'Email',
                    ),
                    AuthTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthSignUp(
                                  name:
                                      _nameController.text.trim().toLowerCase(),
                                  email: _emailController.text
                                      .trim()
                                      .toLowerCase(),
                                  password: _passwordController.text.trim(),
                                ),
                              );
                        }
                      },
                      text: 'Sign Up',
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                AppNavigator.pop(context);
                              },
                          ),
                        ],
                      ),
                    )
                  ]),
            );
          },
        ),
      ),
    );
  }
}
