import 'package:blog_app/core/common/widgets/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_user_state.dart';

class AuthUserCubit extends Cubit<AuthUserState> {
  AuthUserCubit() : super(AuthUserInitial());

  void updateUser(User? user) {
    if (user == null) {
      emit(AuthUserInitial());
    } else {
      emit(AuthUserLoggedIn(user));
    }
  }
}
