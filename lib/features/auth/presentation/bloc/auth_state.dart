part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSucess extends AuthState {
  final User user ;
  AuthSucess(this.user);
}

final class AuthFailure extends AuthState {
  final String messsage;
  AuthFailure(this.messsage);
}

final class AuthLoading extends AuthState {}
