part of 'post_feed_bloc.dart';

@immutable
sealed class PostFeedEvent {}

final class PostFeedFetched extends PostFeedEvent {}
