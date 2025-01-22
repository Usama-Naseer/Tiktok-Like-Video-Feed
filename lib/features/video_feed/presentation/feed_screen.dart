import 'package:flutter/material.dart';
import 'package:tiktok_flutter/core/di/service_locator.dart';
import 'package:tiktok_flutter/features/video_feed/domain/repositories/video_respository.dart';
import 'package:tiktok_flutter/features/video_feed/presentation/bloc/video_feed_bloc.dart';
import 'package:tiktok_flutter/features/video_feed/presentation/video_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int prevVideo = 0;
  int actualScreen = 0;
  VideoFeedBloc bloc = VideoFeedBloc(locator<VideoRepository>());

  @override
  void initState() {
    bloc.add(LoadVideos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BlocConsumer(
        bloc: bloc,
        builder: (context, state) {
          if(state is LoadingVideos){
            return Center(child: CircularProgressIndicator());
          }
          else if(state is NoVideosFound){
            return Center(child: Text('No videos found'));
          }
          else if(state is ErrorLoadingVideos){
            return Center(child: Text('Error loading videos'));
          }
          return Container(
            child: PageView.builder(
              controller: PageController(
                initialPage: 0,
                viewportFraction: 1,
              ),
              itemCount: bloc.videos.length,
              onPageChanged: (index) {
                changeVideo(index);
              },
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return VideoCard(
                  video: bloc.videos[index],
                );
              },
            ),

          );
        }, listener: (BuildContext context, state) {
      },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }


  changeVideo(index) async {
    if (bloc.videos[index].controller == null) {
      // await videoSource!.listVideos[index].loadController();
    }
    bloc.videos[index].controller!.play();
    //videoSource.listVideos[prevVideo].controller.removeListener(() {});

    if (bloc.videos[prevVideo].controller != null) bloc.videos[prevVideo].controller!.pause();

    prevVideo = index;

    print(index);
  }

  void loadVideo(int index) async {
    if (bloc.videos.length > index) {
      bloc.videos[index].controller?.play();
    }
  }
}
