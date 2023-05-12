import 'package:json_annotation/json_annotation.dart';

part 'list_story_body.g.dart';

@JsonSerializable(createFactory: false)
class ListStoryBody {
  ListStoryBody(this.page, this.size);

  Map<String, dynamic> toJson() => _$ListStoryBodyToJson(this);

  final int page;
  final int size;
}
