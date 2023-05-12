part of 'user_token_cubit.dart';

abstract class UserTokenState {}

class UserTokenInitial extends UserTokenState {}

class UserTokenLoading extends UserTokenState {}

class UserTokenFailure extends UserTokenState {}

class GetUserSuccess extends UserTokenState {
  GetUserSuccess(this.token);

  final String? token;
}

class SaveTokenSuccess extends UserTokenState {}

class RemoveTokenSuccess extends UserTokenState {}
