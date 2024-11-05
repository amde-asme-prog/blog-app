//? difference b/n abstract and interface
//*abstract provide base class for concrete subclasses to inherit from
//*interface defines a set of methods classes must implement

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/common/widgets/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
      {required String username,
      required String email,
      required String password});

  Future<Either<Failure, User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();
}
