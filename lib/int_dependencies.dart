import 'package:blog_app/features/auth/data/data_sources/remote/auth_remote_data_sources.dart';
import 'package:blog_app/core/common/widgets/cubit/auth_user_cubit/auth_user_cubit.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);
  _initAuth();

  //! core
  serviceLocator.registerLazySingleton(() => AuthUserCubit());
}

void _initAuth() {
  //! Data source
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      serviceLocator<SupabaseClient>(),
    ),
  );
  //! Repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator<AuthRemoteDataSourceImpl>(),
    ),
  );

  //! UseCases
  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserLogin(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => CurrentUser(
      serviceLocator(),
    ),
  );

  //! Bloc
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
      currentUser: serviceLocator(),
      authUserCubit: serviceLocator(),
    ),
  );

// //*=== by cascading the logic===
//   //! Data source
//   serviceLocator
//     ..registerFactory<AuthRemoteDataSource>(
//       () => AuthRemoteDataSourceImpl(
//         serviceLocator<SupabaseClient>(),
//       ),
//     )
//     //! Repository
//     ..registerFactory<AuthRepository>(
//       () => AuthRepositoryImpl(
//         serviceLocator<AuthRemoteDataSourceImpl>(),
//       ),
//     )

//     //! UseCases
//     ..registerFactory(
//       () => UserSignUp(
//         serviceLocator(),
//       ),
//     )
//     ..registerFactory(
//       () => UserLogin(
//         serviceLocator(),
//       ),
//     )

//     //! Bloc
//     ..registerLazySingleton(
//       () => AuthBloc(
//         userSignUp: serviceLocator(),
//         userLogin: serviceLocator(),
//       ),
//     );
}
