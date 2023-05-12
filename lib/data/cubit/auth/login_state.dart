part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  LoginFailure(this.message);

  final String message;
}

class LoginSuccess extends LoginState {
  LoginSuccess(this.result);

  final LoginModel result;
}
