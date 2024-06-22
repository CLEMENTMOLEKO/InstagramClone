import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_domain/common/errors/errors.dart';
import 'package:instagram_clone_domain/common/value_object.dart';
import 'package:instagram_clone_domain/post/value_objects/post_id.dart';

import '../../constants/constants.dart';

void main() {
  group("PostId", () {
    group("Create", () {
      for (var validUserId in Constants.validUuids) {
        test(
          "Should return a valid user id when given a valid user id string",
          () {
            //Arrange
            final postId = PostConstants.arrangePostId(userId: validUserId);
            //Act
            final userIdResult = PostId.create(value: validUserId);
            //Assert
            expect(userIdResult, Right(postId));
          },
        );
      }

      for (var invalidUserId in Constants.invalidUuids) {
        test(
          "Should return Failure when given a invalid user id string",
          () {
            //Arrange
            //Act
            final userIdResult = PostId.create(value: invalidUserId);
            //Assert
            expect(userIdResult, const Left(Failure.invalidPostId));
          },
        );
      }
    });

    test('Should implement ValueObject', () {
      //Arrange
      //Act
      final userId = PostConstants.postId;
      //Assert
      expect(userId, isA<ValueObject>());
    });

    test('Should be equal if two PostId instances have the same value', () {
      //Arrange
      //Act
      final userId = PostConstants.arrangePostId(
          userId: Constants.validUuids.elementAt(3));
      final userId2 = PostConstants.arrangePostId(
          userId: Constants.validUuids.elementAt(3));
      //Assert
      expect(userId, equals(userId2));
    });

    test('Should not be equal if two PostId instances have different values',
        () {
      //Arrange
      //Act
      final userId = PostConstants.arrangePostId(
          userId: Constants.validUuids.elementAt(1));
      final userId2 = PostConstants.arrangePostId(
          userId: Constants.validUuids.elementAt(3));
      //Assert
      expect(userId, isNot(equals(userId2)));
    });
  });
}
