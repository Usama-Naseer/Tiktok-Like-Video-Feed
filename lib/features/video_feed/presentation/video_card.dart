import 'package:better_player_enhanced/better_player.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_flutter/features/video_feed/domain/entities/video_entity.dart';
import 'package:tiktok_flutter/features/video_feed/presentation/widgets/actions_toolbar.dart';
import 'package:tiktok_flutter/features/video_feed/presentation/widgets/video_description.dart';

class VideoCard extends StatefulWidget {
  final BetterPlayerController betterPlayerController;
  // final VideoEntity video;
  const VideoCard({required this.betterPlayerController, super.key});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> with WidgetsBindingObserver {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.betterPlayerController.isVideoInitialized()==true
            ? GestureDetector(
                onTap: () {
                  if (widget.betterPlayerController.videoPlayerController?.value.isPlaying ?? false) {
                    widget.betterPlayerController.pause();
                  } else {
                    widget.betterPlayerController.play();
                  }
                },
                child: BetterPlayer(
                  controller: widget.betterPlayerController,
                ),
              )
            : Container(
                color: Colors.red,
                child: Center(
                  child: Text("Loading"),
                ),
              ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    widget.betterPlayerController.addEventsListener((e){
      if(e.betterPlayerEventType==BetterPlayerEventType.initialized){
        setState(() {
          print('_FeedScreenState.setupController');

        });
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
  }
}
