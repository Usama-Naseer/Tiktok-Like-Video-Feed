part of 'video_feed_bloc.dart';

@immutable
sealed class VideoFeedState {}

final class VideoFeedInitial extends VideoFeedState {}
final class LoadingVideos extends VideoFeedState {}
final class NoVideosFound extends VideoFeedState {}
final class ErrorLoadingVideos extends VideoFeedState {
  final String error;
  ErrorLoadingVideos(this.error);
}
final class LoadedVideos extends VideoFeedState{
  final List<VideoEntity> videos;
  LoadedVideos(this.videos);
}

