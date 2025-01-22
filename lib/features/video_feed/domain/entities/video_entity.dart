
class VideoEntity {
  String id;
  String user;
  String userPic;
  String videoTitle;
  String songName;
  String likes;
  String comments;
  String url;

  VideoEntity(
      {required this.id,
        required this.user,
        required this.userPic,
        required this.videoTitle,
        required this.songName,
        required this.likes,
        required this.comments,
        required this.url});
}
