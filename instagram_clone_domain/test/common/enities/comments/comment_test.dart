import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_domain/common/common.dart';

import '../../../constants/constants.dart';

void main() {
  late Comment sut;
  const description = "Test comment";

  setUp(() {
    sut = CommentConstants.arrangePostCommentWith(description: description);
  });

  test("Should implement equatable", () {
    //Arrange
    //Act
    //Assert
    expect(sut, isA<Equatable>());
  });

  test("Should be equal when two comments with same value are compared", () {
    //Arrange
    final comment =
        CommentConstants.arrangePostCommentWith(description: description);
    //Act
    //Assert
    expect(sut, equals(comment));
  });

  test(
      "Should not be equal when two comments with different values are compared",
      () {
    //Arrange
    final comment = CommentConstants.arrangePostCommentWith(
        description: "different value desctiption");
    //Act
    //Assert
    expect(sut, isNot(equals(comment)));
  });

  group("CreateComment", () {
    test(
      "Should return domain failure when given null reelId and null postId",
      () {
        //Arrange
        //Act
        final result = Comment.createComment(
          id: CommentConstants.commentId,
          userId: UserConstants.userId,
          description: description,
          date: DateTime(2024, 12, 12),
        );
        //Assert
        expect(result, left(DomainFailure.invalidCommentData));
      },
    );
    test(
      "Should return domain failure when given reelId and postId",
      () {
        //Arrange
        //Act
        final result = Comment.createComment(
          id: CommentConstants.commentId,
          userId: UserConstants.userId,
          description: description,
          reelId: ReelConstants.reelId,
          postId: PostConstants.postId,
          date: DateTime(2024, 12, 12),
        );
        //Assert
        expect(result, left(DomainFailure.invalidCommentData));
      },
    );

    test("Should return Comment.reel when given reelId", () {
      //Arrange
      final reelComment = Comment.reel(
        id: CommentConstants.commentId,
        replies: const [],
        likes: const [],
        userId: UserConstants.userId,
        description: description,
        reelId: ReelConstants.reelId,
        date: DateTime(2024, 12, 12),
      );
      //Act
      final result = Comment.createComment(
        id: CommentConstants.commentId,
        replies: const [],
        likes: const [],
        reelId: ReelConstants.reelId,
        userId: UserConstants.userId,
        description: description,
        date: DateTime(2024, 12, 12),
      );
      //Assert
      expect(result, equals(right(reelComment)));
    });

    test("Should return Comment.post when given postId", () {
      //Arrange
      final postComment = Comment.post(
        id: CommentConstants.commentId,
        replies: const [],
        likes: const [],
        userId: UserConstants.userId,
        description: description,
        postId: PostConstants.postId,
        date: DateTime(2024, 12, 12),
      );
      //Act
      final result = Comment.createComment(
        id: CommentConstants.commentId,
        replies: const [],
        likes: const [],
        postId: PostConstants.postId,
        userId: UserConstants.userId,
        description: description,
        date: DateTime(2024, 12, 12),
      );
      //Assert
      expect(result, equals(right(postComment)));
    });
  });
}
