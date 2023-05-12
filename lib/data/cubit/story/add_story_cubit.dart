import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/data/api/story_service.dart';
import 'package:story_app/data/models/add_story_body.dart';

part 'add_story_state.dart';

class AddStoryCubit extends Cubit<AddStoryState> {
  AddStoryCubit(this.storyService) : super(AddStoryInitial());

  Future<void> addStory(AddStoryBody body) async {
    emit(AddStoryLoading());

    final result = await storyService.addNewStory(body);

    if (!result.error) {
      emit(AddStorySuccess(result.message!));
    } else {
      emit(AddStoryFailure(result.message!));
    }
  }

  final StoryService storyService;
}
