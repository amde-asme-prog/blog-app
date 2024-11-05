import 'package:blog_app/core/common/widgets/loading.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      );
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnackBar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Loading();
              }
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 30),
                    ),
                    const SizedBox(height: 20),
                    AuthTextField(
                      hintText: "Username",
                      controller: usernameController,
                    ),
                    const SizedBox(height: 20),
                    AuthTextField(
                      hintText: "Email",
                      controller: emailController,
                    ),
                    const SizedBox(height: 20),
                    AuthTextField(
                      hintText: "Password",
                      controller: passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthGradientButton(
                      buttonText: "Sign Up",
                      onPressed: () {
                        print("Signing Up");
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthSignUp(
                                  username: usernameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: "Already have an account?",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          const WidgetSpan(
                            child: SizedBox(
                              width: 5,
                            ),
                          ),
                          TextSpan(
                            text: "Login",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(context).push(
                                    LoginPage.route(),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
