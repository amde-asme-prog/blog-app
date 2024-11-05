import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/widgets/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailAndPassword(
      username: params.username,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String username;
  final String email;
  final String password;

  UserSignUpParams({
    required this.username,
    required this.email,
    required this.password,
  });
}
