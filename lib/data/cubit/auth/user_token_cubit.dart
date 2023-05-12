import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/common/key_constants.dart';

part 'user_token_state.dart';

class UserTokenCubit extends Cubit<UserTokenState> {
  UserTokenCubit() : super(UserTokenInitial()) {
    getUserToken();
  }

  Future<void> getUserToken() async {
    emit(UserTokenLoading());
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(KeyConstants.keyUserToken);

    emit(GetUserSuccess(token));
  }

  Future<void> setUserToken(String keyToken) async {
    final prefs = await SharedPreferences.getInstance();
    final status = await prefs.setString(KeyConstants.keyUserToken, keyToken);

    if (status) {
      emit(SaveTokenSuccess());
    } else {
      emit(UserTokenFailure());
    }
  }

  Future<void> removeUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    final status = await prefs.remove(KeyConstants.keyUserToken);

    if (status) {
      emit(RemoveTokenSuccess());
    } else {
      emit(UserTokenFailure());
    }
  }
}
