import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:meta/meta.dart';

part 'post_feed_event.dart';
part 'post_feed_state.dart';

class PostFeedBloc extends Bloc<PostFeedEvent, PostFeedState> {
  final PostRepository postRepository;

  PostFeedBloc({
    required this.postRepository,
  }) : super(PostFeedState.initial()) {
    on<PostFeedFetched>(_onPostFeedFetched);
  }

  Future<void> _onPostFeedFetched(event, emit) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(status: PostFeedStatus.loading));
    final getPostsResult = await postRepository.getPosts(
      limit: 10,
      offset: state.posts.length,
    );

    getPostsResult.fold(
      (failure) => emit(state.copyWith(status: PostFeedStatus.failure)),
      (posts) => emit(state.copyWith(
        status: PostFeedStatus.success,
        posts: state.posts + posts,
        hasReachedMax: posts.isEmpty,
      )),
    );
  }
}
