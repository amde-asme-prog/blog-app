import 'package:blog_app/core/cubits/app_user/user_cubit.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignUpUsecase signUpUsecase,
    required LoginUsecase loginUsecase,
    required CurrentUserUsecase currentUserUsecase,
    required AppUserCubit appUserCubit,
  })  : _signUpUsecase = signUpUsecase,
        _loginUsecase = loginUsecase,
        _currentUserUsecase = currentUserUsecase,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) {
      emit(AuthLoading());
    });

    on<AuthIsUserLoggedIn>(_isUserLoggedIn);

    on<AuthSignUp>(_handleSignUp);

    on<AuthLogin>(_handleSignIn);
  }
  void _isUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final response = await _currentUserUsecase(NoParams());

    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (success) => _emitAuthSuccess(success, emit),
    );
  }

  void _handleSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final response = await _signUpUsecase(SignUpParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _handleSignIn(AuthLogin event, Emitter<AuthState> emit) async {
    final response = await _loginUsecase(
      LoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _emitAuthSuccess(UserEntity user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }

  final SignUpUsecase _signUpUsecase;
  final LoginUsecase _loginUsecase;
  final CurrentUserUsecase _currentUserUsecase;
  final AppUserCubit _appUserCubit;
}
