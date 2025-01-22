import 'package:flutter/material.dart';
import 'package:tiktok_flutter/features/video_feed/domain/entities/video_entity.dart';
import 'package:tiktok_flutter/features/video_feed/presentation/widgets/actions_toolbar.dart';
import 'package:tiktok_flutter/features/video_feed/presentation/widgets/video_description.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  final VideoEntity video;
  const VideoCard({required this.video, super.key});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> with WidgetsBindingObserver {
  late VideoPlayerController controller;
  @override
  void initState() {
     super.initState();
     controller = VideoPlayerController.networkUrl(Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'));
     controller.setLooping(true);
     controller.initialize();
     controller.addListener(() {
       if (controller.value.isInitialized){
         setState(() {
           controller.play();
         });
       }
     });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        controller.value.isInitialized
            ? GestureDetector(
                onTap: () {
                  if (controller.value.isPlaying) {
                    controller.pause();
                  } else {
                    controller.play();
                  }
                },
                child: SizedBox.expand(
                    child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: controller.value.size.width,
                    height: controller.value.size.height,
                    child: VideoPlayer(controller),
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
                VideoDescription(widget.video.user, widget.video.videoTitle, widget.video.songName),
                ActionsToolbar(widget.video.likes, widget.video.comments,
                    "https://www.andersonsobelcosmetic.com/wp-content/uploads/2018/09/chin-implant-vs-fillers-best-for-improving-profile-bellevue-washington-chin-surgery.jpg"),
              ],
            ),
            SizedBox(height: 20)
          ],
        ),
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      controller.pause();
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
