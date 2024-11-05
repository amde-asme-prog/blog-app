part of 'auth_user_cubit.dart';

@immutable
sealed class AuthUserState {}

final class AuthUserInitial extends AuthUserState {}

final class AuthUserLoggedIn extends AuthUserState {
  final User user;

  AuthUserLoggedIn(this.user);
}
