part of 'list_story_cubit.dart';

abstract class ListStoryState {}

class ListStoryInitial extends ListStoryState {}

class ListStoryLoading extends ListStoryState {}

class ListStoryFailure extends ListStoryState {
  ListStoryFailure(this.message);

  final String message;
}

class ListStorySuccess extends ListStoryState {
  ListStorySuccess(this.result);

  final ListStoryModel result;
}
