part of 'detail_story_cubit.dart';

abstract class DetailStoryState {}

class DetailStoryInitial extends DetailStoryState {}

class DetailStoryLoading extends DetailStoryState {}

class DetailStoryFailure extends DetailStoryState {
  DetailStoryFailure(this.message);

  final String message;
}

class DetailStorySuccess extends DetailStoryState {
  DetailStorySuccess(this.result, this.message);

  final StoryModel result;
  final String message;
}
