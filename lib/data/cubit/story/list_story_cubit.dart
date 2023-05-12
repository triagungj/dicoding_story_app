import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/data/api/story_service.dart';
import 'package:story_app/data/models/list_story_body.dart';
import 'package:story_app/data/models/list_story_model.dart';

part 'list_story_state.dart';

class ListStoryCubit extends Cubit<ListStoryState> {
  ListStoryCubit(this.storyService) : super(ListStoryInitial());

  Future<void> getListStory(ListStoryBody body) async {
    emit(ListStoryLoading());

    final response = await storyService.getListStories(body);

    if (!response.error) {
      emit(ListStorySuccess(response));
    } else {
      emit(ListStoryFailure(response.message));
    }
  }

  final StoryService storyService;
}
