import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:tiktok_flutter/core/di/service_locator.dart';
import 'package:tiktok_flutter/features/video_feed/domain/repositories/video_respository.dart';
import 'package:tiktok_flutter/features/video_feed/domain/usecases/get_videos.dart';
import 'package:tiktok_flutter/features/video_feed/presentation/bloc/video_feed_bloc.dart';
import 'package:tiktok_flutter/features/video_feed/presentation/video_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_player_enhanced/better_player.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int prevVideo = 0;
  int actualScreen = 0;
  VideoFeedBloc bloc = VideoFeedBloc(GetAllVideosUserCase(repository: locator<VideoRepository>()));
  late PageController pageController;
  late BetterPlayerController currentController;
  BetterPlayerController? nextController;
  int currentIndex=0;

  @override
  void initState() {
    bloc.add(LoadVideos());
    pageController = PageController(initialPage: 0,viewportFraction: 1);
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
              controller: pageController,
              itemCount: bloc.videos.length,
              // onPageChanged: onPageChanged,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                setupController(index);
                return VideoCard(
                  betterPlayerController: currentController,
                );
              },
            ),

          );
        }, listener: (BuildContext context, state) {
          // if(state is LoadedVideos){
          //   setupController(currentIndex);
          // }
      },
      ),
    );
  }


  void setupController(int index) {
    currentController  = BetterPlayerController(
        betterPlayerDataSource: BetterPlayerDataSource.network(
           bloc.videos[index].videoUrl.link,
          cacheConfiguration: BetterPlayerCacheConfiguration(
            key: bloc.videos[index].videoUrl.link,
            useCache: true, // Enable caching
            preCacheSize: 100 * 1024 * 1024, // Pre-cache size

          ),
        ),
        BetterPlayerConfiguration(
          autoPlay: true,
          looping: true,
        ));
    if (index + 1 < bloc.videos[index].videoUrl.link.length) {
      nextController = BetterPlayerController(
          betterPlayerDataSource: BetterPlayerDataSource.network(
            bloc.videos[index+1].videoUrl.link,
            cacheConfiguration: BetterPlayerCacheConfiguration(
              key: bloc.videos[index+1].videoUrl.link,
              useCache: true, // Enable caching
              preCacheSize: 100 * 1024 * 1024, // Pre-cache size
            ),
          ),
          BetterPlayerConfiguration(
            autoPlay: true,
            looping: true,
            fullScreenByDefault: true,
          ));
    }
  }


  void onPageChanged(int index) {
    currentIndex = index;
    disposeControllers();
    setupController(index);
  }
  void disposeControllers() {
    currentController.dispose();
    nextController?.dispose();
  }
  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

}
