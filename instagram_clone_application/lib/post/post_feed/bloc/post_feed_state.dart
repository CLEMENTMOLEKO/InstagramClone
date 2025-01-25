part of 'post_feed_bloc.dart';

enum PostFeedStatus {
  initial,
  loading,
  success,
  failure,
}

@immutable
final class PostFeedState {
  final PostFeedStatus status;
  final List<Post> posts;
  final bool hasReachedMax;

  const PostFeedState({
    required this.status,
    required this.posts,
    required this.hasReachedMax,
  });

  factory PostFeedState.initial() {
    return PostFeedState(
      status: PostFeedStatus.initial,
      posts: [],
      hasReachedMax: false,
    );
  }
}
