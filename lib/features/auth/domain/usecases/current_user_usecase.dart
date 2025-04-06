import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUserUsecase implements UseCaseWithParams<UserEntity, NoParams> {
  final AuthRepo _authRepo;

  CurrentUserUsecase(this._authRepo);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await _authRepo.currentUser();
  }
}

// class NoParams {}
