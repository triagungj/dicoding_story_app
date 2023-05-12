import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/data/api/auth_service.dart';
import 'package:story_app/data/models/login_body.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authService) : super(LoginInitial());
  final AuthService authService;

  Future<void> login(LoginBody body) async {
    emit(LoginLoading());

    final response = await authService.login(body);
    if (response.error) {
      emit(LoginFailure(response.message));
    } else {
      emit(LoginSuccess(response.message));
    }
  }
}
