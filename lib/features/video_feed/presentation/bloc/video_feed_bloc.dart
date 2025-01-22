import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tiktok_flutter/features/video_feed/domain/entities/video_entity.dart';
import 'package:tiktok_flutter/features/video_feed/domain/repositories/video_respository.dart';

part 'video_feed_event.dart';
part 'video_feed_state.dart';

class VideoFeedBloc extends Bloc<VideoFeedEvent, VideoFeedState> {
  VideoRepository videoRepository;
  List<VideoEntity> videos =[];
  VideoFeedBloc(this.videoRepository) : super(VideoFeedInitial()) {
    on<VideoFeedEvent>((event, emit) async {
      try{
        emit(LoadingVideos());
        videos.addAll( await videoRepository.getVideoList());
        if(videos.isEmpty){
          emit(NoVideosFound());
        }
        else{
          emit(LoadedVideos(videos));
        }
      }catch(e){
        emit(ErrorLoadingVideos(e.toString()));
      }
      // TODO: implement event handler
    });
  }

}
