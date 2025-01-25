part of 'post_feed_bloc.dart';

enum PostFeedStatus {
  stale,
  loading,
  success,
  failure,
}

@immutable
final class PostFeedState extends Equatable {
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
      status: PostFeedStatus.stale,
      posts: [],
      hasReachedMax: false,
    );
  }

  PostFeedState copyWith({
    PostFeedStatus? status,
    List<Post>? posts,
    bool? hasReachedMax,
  }) {
    return PostFeedState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, posts, hasReachedMax];
}
