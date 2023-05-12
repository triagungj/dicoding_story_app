import 'package:json_annotation/json_annotation.dart';

part 'default_model.g.dart';

@JsonSerializable(createToJson: false)
class DefaultModel {
  DefaultModel({
    required this.error,
    this.message,
  });

  factory DefaultModel.fromJson(Map<String, dynamic> json) =>
      _$DefaultModelFromJson(json);

  final bool error;
  final String? message;
}
