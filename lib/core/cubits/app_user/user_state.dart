part of 'user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  AppUserLoggedIn({required this.user});

  final UserEntity user;
}
