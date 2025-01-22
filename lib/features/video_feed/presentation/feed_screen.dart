import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_flutter/features/video_feed/domain/entities/video_entity.dart';
import 'package:tiktok_flutter/widgets/actions_toolbar.dart';
import 'package:tiktok_flutter/widgets/video_description.dart';
import 'package:get_it/get_it.dart';
import 'package:video_player/video_player.dart';

import '../data/source/remote/remote_videos_repository.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final locator = GetIt.instance;
  @override
  void initState() {
    loadVideo(0);
    loadVideo(1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        PageView.builder(
          controller: PageController(
            initialPage: 0,
            viewportFraction: 1,
          ),
          itemCount: videoSource!.listVideos.length,
          onPageChanged: (index) {
            index = (videoSource!.listVideos.length);
            changeVideo(index);
          },
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            // index = index % (feedViewModel.videoSource!.listVideos.length);
            return videoCard(videoSource!.listVideos[index]);
          },
        ),
      ],
    ));
  }

  Widget videoCard(VideoEntity video) {
    return Stack(
      children: [
        video.controller != null
            ? GestureDetector(
                onTap: () {
                  if (video.controller!.value.isPlaying) {
                    video.controller?.pause();
                  } else {
                    video.controller?.play();
                  }
                },
                child: SizedBox.expand(
                    child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: video.controller?.value.size.width ?? 0,
                    height: video.controller?.value.size.height ?? 0,
                    child: VideoPlayer(video.controller!),
                  ),
                )),
              )
            : Container(
                color: Colors.red,
                child: Center(
                  child: Text("Loading"),
                ),
              ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                VideoDescription(video.user, video.videoTitle, video.songName),
                ActionsToolbar(video.likes, video.comments, "https://www.andersonsobelcosmetic.com/wp-content/uploads/2018/09/chin-implant-vs-fillers-best-for-improving-profile-bellevue-washington-chin-surgery.jpg"),
              ],
            ),
            SizedBox(height: 20)
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  VideoPlayerController? controller;
  RemoteVideosRepository? videoSource = RemoteVideosRepository();

  int prevVideo = 0;

  int actualScreen = 0;

  changeVideo(index) async {
    if (videoSource!.listVideos[index].controller == null) {
      // await videoSource!.listVideos[index].loadController();
    }
    videoSource!.listVideos[index].controller!.play();
    //videoSource.listVideos[prevVideo].controller.removeListener(() {});

    if (videoSource!.listVideos[prevVideo].controller != null) videoSource!.listVideos[prevVideo].controller!.pause();

    prevVideo = index;

    print(index);
  }

  void loadVideo(int index) async {
    if (videoSource!.listVideos.length > index) {
      videoSource!.listVideos[index].controller?.play();
    }
  }

  void setActualScreen(index) {
    actualScreen = index;
    if (index == 0) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
  }
}
