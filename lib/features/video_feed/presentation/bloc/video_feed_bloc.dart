import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'video_feed_event.dart';
part 'video_feed_state.dart';

class VideoFeedBloc extends Bloc<VideoFeedEvent, VideoFeedState> {
  VideoFeedBloc() : super(VideoFeedInitial()) {
    on<VideoFeedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

}
