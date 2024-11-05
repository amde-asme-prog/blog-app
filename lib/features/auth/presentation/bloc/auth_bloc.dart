import 'package:blog_app/core/common/widgets/cubit/auth_user_cubit/auth_user_cubit.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/widgets/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AuthUserCubit _authUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AuthUserCubit authUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _authUserCubit = authUserCubit,
        super(
          AuthInitial(),
        ) {
    //? sign up condition
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final response = await _userSignUp(
        UserSignUpParams(
          username: event.username,
          email: event.email,
          password: event.password,
        ),
      );

      response.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => _emitAuthSuccess(user, emit),
      );
    });
    //!
    //? Login condition
    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      final response = await _userLogin(
        UserLoginParams(
          email: event.email,
          password: event.password,
        ),
      );

      response.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => _emitAuthSuccess(user, emit),
      );
    });

    on<AuthIsUserLoggedIn>((event, emit) async {
      emit(AuthLoading());
      final response = await _currentUser(NoParams());

      response.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => _emitAuthSuccess(user, emit),
      );
    });
  }
  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    emit(AuthSuccess(user));
    _authUserCubit.updateUser(user);
  }
}
