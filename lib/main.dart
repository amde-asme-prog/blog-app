import 'package:blog_app/core/common/widgets/cubit/auth_user_cubit/auth_user_cubit.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/int_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthUserCubit>(
          create: (context) => serviceLocator<AuthUserCubit>(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => serviceLocator<AuthBloc>(),
        ),
      ],
      child: const Landing(),
    ),
  );
}

class Landing extends StatefulWidget {
  const Landing({
    super.key,
  });

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      darkTheme: ThemeData.dark(),
      home: BlocSelector<AuthUserCubit, AuthUserState, bool>(
        selector: (state) {
          return state is AuthUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          // if (isLoggedIn) {
          //   return const Scaffold(
          //     body: Center(
          //       child: Text("logged in"),
          //     ),
          //   );
          // }
          return const LoginPage();
        },
      ),
    );
  }
}
