import 'package:blog_app/core/utils/app_navigator.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 15,
              children: [
                Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleLarge?.fontSize),
                ),
                const SizedBox(
                  height: 15,
                ),
                AuthTextField(
                  controller: emailController,
                  hintText: 'Email',
                ),
                AuthTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                AuthButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          AuthLogin(
                            email: emailController.text.trim().toLowerCase(),
                            password: passwordController.text.trim(),
                          ),
                        );
                  },
                  text: 'Login',
                ),
                RichText(
                  text: TextSpan(
                    text: 'Don\'t Have an Account? ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            AppNavigator.push(
                              context,
                              SignUpPage(),
                            );
                          },
                      ),
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
