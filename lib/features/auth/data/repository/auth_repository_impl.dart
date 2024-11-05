import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/error/server_exceptions.dart';
import 'package:blog_app/features/auth/data/data_sources/remote/auth_remote_data_sources.dart';
import 'package:blog_app/core/common/widgets/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb_user;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userId = await remoteDataSource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );

      return right(userId);
    } on sb_user.AuthException catch (e) {
      return left(
        Failure(e.message),
      );
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
      {required String username,
      required String email,
      required String password}) async {
    try {
      final user = await remoteDataSource.signUpWithEmailAndPassword(
        username: username,
        email: email,
        password: password,
      );

      return right(user);
    } on sb_user.AuthException catch (e) {
      return left(
        Failure(e.message),
      );
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure("User is not logged in!"));
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
