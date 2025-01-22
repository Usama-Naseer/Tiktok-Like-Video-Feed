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

class _VideoCardState extends State<VideoCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.video.controller != null
            ? GestureDetector(
                onTap: () {
                  if (widget.video.controller!.value.isPlaying) {
                    widget.video.controller?.pause();
                  } else {
                    widget.video.controller?.play();
                  }
                },
                child: SizedBox.expand(
                    child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: widget.video.controller?.value.size.width ?? 0,
                    height: widget.video.controller?.value.size.height ?? 0,
                    child: VideoPlayer(widget.video.controller!),
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
}
