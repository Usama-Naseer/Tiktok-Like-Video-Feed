import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
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
            child: PreloadPageView.builder(
              controller: PreloadPageController(
                initialPage: 0,
                viewportFraction: 1,
              ),
              itemCount: bloc.videos.length,
              preloadPagesCount: 2,

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
}
