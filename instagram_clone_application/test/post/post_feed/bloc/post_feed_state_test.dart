import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

void main() {
  test(
      "Should be equal when two initial states with same properties are compared",
      () {
    //Arrange
    final state1 = PostFeedState(
      status: PostFeedStatus.stale,
      posts: [],
      hasReachedMax: false,
    );
    final state2 = PostFeedState(
      status: PostFeedStatus.stale,
      posts: [],
      hasReachedMax: false,
    );

    //Assert
    expect(state1, state2);
  });
}
