import 'package:blog_app/core/cubits/app_user/user_cubit.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/data/repository/auth_repo_impl.dart';
import 'package:blog_app/features/auth/data/sources/remote/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repo.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/repo/blog_repo_impl.dart';
import 'package:blog_app/features/blog/data/sources/local/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/sources/remote/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/domain/repo/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs_usecase.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);

  serviceLocator.registerFactory(() => InternetConnection());

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton<Box>(() => Hive.box(name: "blogs"));

  _authInit();

  _blogInit();
}

void _authInit() {
  //*** DATA SOURCES ***//
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      serviceLocator<SupabaseClient>(), //?mentioning the type is optional
    ),
  );
  //==========================================================================

  //*** REPOSITORY ***//
  serviceLocator.registerFactory<AuthRepo>(
    () => AuthRepoImpl(
      serviceLocator(),
      serviceLocator(),
    ),
  );
  //==========================================================================

  //*** USE CASES ***//
  serviceLocator.registerFactory(
    () => SignUpUsecase(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => LoginUsecase(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => CurrentUserUsecase(
      serviceLocator(),
    ),
  );
  //==========================================================================

  //core
  serviceLocator.registerLazySingleton<AppUserCubit>(
    () => AppUserCubit(),
  );

  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );
//==========================================================================
  //*** BLoC ***//
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      signUpUsecase: serviceLocator(),
      loginUsecase: serviceLocator(),
      currentUserUsecase: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}

void _blogInit() {
  //*** DATA SOURCES ***//
  serviceLocator.registerFactory<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(
      serviceLocator<SupabaseClient>(),
    ),
  );

  serviceLocator.registerFactory<BlogLocalDataSource>(
    () => BlogLocalDataSourceImpl(
      serviceLocator<Box>(),
    ),
  );

  //*** REPOSITORY ***//
  serviceLocator.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ),
  );

  //*** USE CASES ***//
  serviceLocator.registerFactory<GetAllBlogsUsecase>(
    () => GetAllBlogsUsecase(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UploadBlogUsecase(
      serviceLocator(),
    ),
  );

  //** BLoC ***//
  serviceLocator.registerLazySingleton(
    () => BlogBloc(
      uploadBlogUsecase: serviceLocator(),
      getAllBlogsUsecase: serviceLocator(),
    ),
  );
}
