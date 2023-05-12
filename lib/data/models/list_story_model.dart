import 'package:json_annotation/json_annotation.dart';

part 'list_story_model.g.dart';

@JsonSerializable(createToJson: false)
class ListStoryModel {
  ListStoryModel({
    required this.error,
    required this.message,
    this.listStory,
  });

  factory ListStoryModel.fromJson(Map<String, dynamic> json) =>
      _$ListStoryModelFromJson(json);

  final bool error;
  final String message;
  final List<StoryDetailModel>? listStory;
}

@JsonSerializable(createToJson: false)
class StoryDetailModel {
  StoryDetailModel({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
  });

  factory StoryDetailModel.fromJson(Map<String, dynamic> json) =>
      _$StoryDetailModelFromJson(json);

  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final String createdAt;
}
