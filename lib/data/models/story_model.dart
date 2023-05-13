import 'package:json_annotation/json_annotation.dart';

part 'story_model.g.dart';

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
  final List<StoryModel>? listStory;
}

@JsonSerializable(createToJson: false)
class DetailStoryModel {
  DetailStoryModel({
    required this.error,
    required this.message,
    this.story,
  });

  factory DetailStoryModel.fromJson(Map<String, dynamic> json) =>
      _$DetailStoryModelFromJson(json);

  final bool error;
  final String message;
  final StoryModel? story;
}



@JsonSerializable(createToJson: false)
class StoryModel {
  StoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);

  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final String createdAt;
}
