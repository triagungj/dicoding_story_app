import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/data/api/story_service.dart';
import 'package:story_app/data/models/story_model.dart';

part 'detail_story_state.dart';

class DetailStoryCubit extends Cubit<DetailStoryState> {
  DetailStoryCubit(this.storyService) : super(DetailStoryInitial());

  Future<void> getDetailStory(String id) async {
    emit(DetailStoryLoading());

    final response = await storyService.getDetailStory(id);

    if (!response.error) {
      emit(DetailStorySuccess(response.story!, response.message));
    } else {
      emit(DetailStoryFailure(response.message));
    }
  }

  final StoryService storyService;
}
