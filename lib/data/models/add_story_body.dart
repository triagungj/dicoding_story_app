class AddStoryBody {
  AddStoryBody({
    required this.description,
    required this.imageByte,
    required this.fileName,
    this.lat,
    this.lon,
  });

  final String description;
  final String fileName;
  final List<int> imageByte;
  final double? lat;
  final double? lon;
}
