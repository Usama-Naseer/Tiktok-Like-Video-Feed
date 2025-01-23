import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tiktok_flutter/features/video_feed/domain/entities/video_entity.dart';
import 'package:tiktok_flutter/features/video_feed/domain/usecases/get_videos.dart';

part 'video_feed_event.dart';
part 'video_feed_state.dart';

class VideoFeedBloc extends Bloc<VideoFeedEvent, VideoFeedState> {
  late GetAllVideosUserCase getAllVideosUserCase;
  List<VideoEntity> videos =[];
  int page=0;
  VideoFeedBloc(this.getAllVideosUserCase) : super(VideoFeedInitial()) {
    on<VideoFeedEvent>((event, emit) async {
      try{
        emit(LoadingVideos());
        page++;
        videos = await getAllVideosUserCase.call(page: page);
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
