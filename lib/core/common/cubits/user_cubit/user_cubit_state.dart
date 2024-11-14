part of 'user_cubit_cubit.dart';

sealed class UserCubitState {}

final class UserCubitInitial extends UserCubitState {}

final class AppUserState extends UserCubitState {
  final User user;
  AppUserState(this.user);
}
