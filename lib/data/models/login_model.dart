import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable(createToJson: false)
class LoginModel {
  LoginModel({
    required this.error,
    required this.message,
    this.loginResult,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  final bool error;
  final String message;
  final LoginResultModel? loginResult;
}

@JsonSerializable(createToJson: false)
class LoginResultModel {
  LoginResultModel({
    required this.userId,
    required this.name,
    required this.token,
  });

  factory LoginResultModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResultModelFromJson(json);

  final String userId;
  final String name;
  final String token;
}
