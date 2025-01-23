class VideoUrlEntity{
  int id;
  String quality;
  String fileType;
  int width;
  int height;
  int fps;
  String link;
  int size;

  VideoUrlEntity({
    required this.id,
    required this.quality,
    required this.fileType,
    required this.width,
    required this.height,
    required this.fps,
    required this.link,
    required this.size,
  });
}
