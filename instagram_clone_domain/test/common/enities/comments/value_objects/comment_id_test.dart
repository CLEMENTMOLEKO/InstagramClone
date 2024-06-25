import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_domain/common/common.dart';
import 'package:instagram_clone_domain/common/entities/comment/value_objects/comment_id.dart';

import '../../../../constants/constants.dart';

void main() {
  group("CommentId", () {
    group("Create", () {
      for (var validCommentId in Constants.validUuids) {
        test(
          "Should return a valid comment id when given a valid comment id string",
          () {
            //Arrange
            final commentId =
                CommentConstants.arrangeCommentId(commentId: validCommentId);
            //Act
            final commentIdResult = CommentId.create(value: validCommentId);
            //Assert
            expect(commentIdResult, Right(commentId));
          },
        );
      }

      for (var invalidCommentId in Constants.invalidUuids) {
        test(
          "Should return Failure when given a invalid comment id string",
          () {
            //Arrange
            //Act
            final commentIdResult = CommentId.create(value: invalidCommentId);
            //Assert
            expect(commentIdResult, const Left(DomainFailure.invalidCommentId));
          },
        );
      }
    });

    test('Should implement ValueObject', () {
      //Arrange
      //Act
      final commentId = CommentConstants.commentId;
      //Assert
      expect(commentId, isA<ValueObject>());
    });

    test('Should be equal if two CommentId instances have the same value', () {
      //Arrange
      //Act
      final commentId = CommentConstants.arrangeCommentId(
          commentId: Constants.validUuids.elementAt(3));
      final commentId2 = CommentConstants.arrangeCommentId(
          commentId: Constants.validUuids.elementAt(3));
      //Assert
      expect(commentId, equals(commentId2));
    });

    test('Should not be equal if two CommentId instances have different values',
        () {
      //Arrange
      //Act
      final commentId = CommentConstants.arrangeCommentId(
          commentId: Constants.validUuids.elementAt(1));
      final commentId2 = CommentConstants.arrangeCommentId(
          commentId: Constants.validUuids.elementAt(3));
      //Assert
      expect(commentId, isNot(equals(commentId2)));
    });
  });
}
