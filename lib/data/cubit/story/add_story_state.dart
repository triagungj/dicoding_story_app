part of 'add_story_cubit.dart';

abstract class AddStoryState {}

class AddStoryInitial extends AddStoryState {}

class AddStoryLoading extends AddStoryState {}

class AddStoryFailure extends AddStoryState {
  AddStoryFailure(this.message);

  final String message;
}

class AddStorySuccess extends AddStoryState {
  AddStorySuccess(this.message);

  final String message;
}
