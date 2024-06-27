import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_domain/post/post.dart';

import '../constants/constants.dart';

void main() {
  late Post sut;

  setUp(() {
    sut = PostConstants.arrangePostWith();
  });

  group("Post", () {
    test("Should extend equatable", () {
      //Arrange
      //Act
      //Assert
      expect(sut, isA<Equatable>());
    });

    test("Should be equal when two posts with same value are compared", () {
      //Arrange
      final postModel = PostConstants.arrangePostWith();
      final postModel2 = PostConstants.arrangePostWith();
      //Act
      //Assert
      expect(postModel, equals(postModel2));
    });

    test(
        "Should not be equal when two posts with different values are compared",
        () {
      //Arrange
      final postModel = PostConstants.arrangePostWith();
      final postModel2 = PostConstants.arrangePostWith(
          description: "this is a different description than default.`");
      //Act
      //Assert
      expect(postModel, isNot(equals(postModel2)));
    });

    group("CreatePost", () {
      test("Should return Post when given valid post values", () {
        //Arrange
        //Act
        final createPostResult = Post.createPost(
          id: PostConstants.postId,
          userId: UserConstants.userId,
          description: "Test post is returning correct values",
          date: DateTime(2024, 12, 12),
          likes: Constants.likes,
          comments: List.generate(
            4,
            (index) => CommentConstants.arrangePostCommentWith(
                description: "This is a test comment $index"),
          ),
        );
        final result = createPostResult
            .getOrElse(() => throw Exception("Error creating post"));
        //Assert
        expect(result, isA<Post>());
      });
    });
  });
}
