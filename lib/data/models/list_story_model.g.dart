// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListStoryModel _$ListStoryModelFromJson(Map<String, dynamic> json) =>
    ListStoryModel(
      error: json['error'] as bool,
      message: json['message'] as String,
      listStory: (json['listStory'] as List<dynamic>?)
          ?.map((e) => StoryDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

StoryDetailModel _$StoryDetailModelFromJson(Map<String, dynamic> json) =>
    StoryDetailModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      photoUrl: json['photoUrl'] as String,
      createdAt: json['createdAt'] as String,
    );
