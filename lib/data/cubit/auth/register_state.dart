part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterFailure extends RegisterState {
  RegisterFailure(this.message);

  final String message;
}

class RegisterSuccess extends RegisterState {
  RegisterSuccess(this.message);

  final String message;
}
