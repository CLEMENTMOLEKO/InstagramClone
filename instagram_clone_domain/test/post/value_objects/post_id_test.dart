import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_domain/common/common.dart';
import 'package:instagram_clone_domain/post/post.dart';

import '../../constants/constants.dart';

void main() {
  group("PostId", () {
    group("Create", () {
      for (var validPostId in Constants.validUuids) {
        test(
          "Should return a valid post id when given a valid user id string",
          () {
            //Arrange
            final postId = PostConstants.arrangePostId(postId: validPostId);
            //Act
            final postIdResult = PostId.create(value: validPostId);
            //Assert
            expect(postIdResult, Right(postId));
          },
        );
      }

      for (var invalidPostId in Constants.invalidUuids) {
        test(
          "Should return Failure when given a invalid user id string",
          () {
            //Arrange
            //Act
            final postIdResult = PostId.create(value: invalidPostId);
            //Assert
            expect(postIdResult, const Left(Failure.invalidPostId));
          },
        );
      }
    });

    test('Should implement ValueObject', () {
      //Arrange
      //Act
      final postId = PostConstants.postId;
      //Assert
      expect(postId, isA<ValueObject>());
    });

    test('Should be equal if two PostId instances have the same value', () {
      //Arrange
      //Act
      final postId = PostConstants.arrangePostId(
          postId: Constants.validUuids.elementAt(3));
      final postId2 = PostConstants.arrangePostId(
          postId: Constants.validUuids.elementAt(3));
      //Assert
      expect(postId, equals(postId2));
    });

    test('Should not be equal if two PostId instances have different values',
        () {
      //Arrange
      //Act
      final postId = PostConstants.arrangePostId(
          postId: Constants.validUuids.elementAt(1));
      final postId2 = PostConstants.arrangePostId(
          postId: Constants.validUuids.elementAt(3));
      //Assert
      expect(postId, isNot(equals(postId2)));
    });
  });
}
