// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListStoryModel _$ListStoryModelFromJson(Map<String, dynamic> json) =>
    ListStoryModel(
      error: json['error'] as bool,
      message: json['message'] as String,
      listStory: (json['listStory'] as List<dynamic>?)
          ?.map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DetailStoryModel _$DetailStoryModelFromJson(Map<String, dynamic> json) =>
    DetailStoryModel(
      error: json['error'] as bool,
      message: json['message'] as String,
      story: json['story'] == null
          ? null
          : StoryModel.fromJson(json['story'] as Map<String, dynamic>),
    );

StoryModel _$StoryModelFromJson(Map<String, dynamic> json) => StoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      photoUrl: json['photoUrl'] as String,
      createdAt: json['createdAt'] as String,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
    );
