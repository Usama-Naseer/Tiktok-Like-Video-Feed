part of 'video_feed_bloc.dart';

@immutable
sealed class VideoFeedEvent {}

class LoadVideos extends VideoFeedEvent{}