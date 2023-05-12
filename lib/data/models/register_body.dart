import 'package:json_annotation/json_annotation.dart';

part 'register_body.g.dart';

@JsonSerializable(createFactory: false)
class RegisterBody {
  RegisterBody({
    required this.email,
    required this.name,
    required this.password,
  });

  final String email;
  final String name;
  final String password;

  Map<String, dynamic> toJson() => _$RegisterBodyToJson(this);
}
