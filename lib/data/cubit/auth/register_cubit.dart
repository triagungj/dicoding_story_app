import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/data/api/auth_service.dart';
import 'package:story_app/data/models/register_body.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authService) : super(RegisterInitial());

  final AuthService authService;

  Future<void> registerUser(RegisterBody body) async {
    emit(RegisterLoading());

    final response = await authService.register(body);
    if (response.error) {
      emit(RegisterFailure(response.message ?? 'Unknown Error'));
    } else {
      emit(RegisterSuccess(response.message ?? 'Register Success'));
    }
  }
}
