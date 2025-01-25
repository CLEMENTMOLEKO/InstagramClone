import 'package:bloc/bloc.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:meta/meta.dart';

part 'post_feed_event.dart';
part 'post_feed_state.dart';

class PostFeedBloc extends Bloc<PostFeedEvent, PostFeedState> {
  PostFeedBloc() : super(PostFeedState.initial()) {
    on<PostFeedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
