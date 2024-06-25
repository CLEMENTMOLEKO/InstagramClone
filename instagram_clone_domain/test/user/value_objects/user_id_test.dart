import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_domain/common/common.dart';
import 'package:instagram_clone_domain/user/user.dart';

import '../../constants/constants.dart';

void main() {
  group("UserId", () {
    group("Create", () {
      for (var validUserId in Constants.validUuids) {
        test(
          "Should return a valid user id when given a valid user id string",
          () {
            //Arrange
            final userId = UserConstants.arrangeUserId(userId: validUserId);
            //Act
            final userIdResult = UserId.create(value: validUserId);
            //Assert
            expect(userIdResult, Right(userId));
          },
        );
      }

      for (var invalidUserId in Constants.invalidUuids) {
        test(
          "Should return Failure when given a invalid user id string",
          () {
            //Arrange
            //Act
            final userIdResult = UserId.create(value: invalidUserId);
            //Assert
            expect(userIdResult, const Left(DomainFailure.invalidUserId));
          },
        );
      }
    });

    test('Should implement ValueObject', () {
      //Arrange
      //Act
      final userId = UserConstants.userId;
      //Assert
      expect(userId, isA<ValueObject>());
    });

    test('Should be equal if two UserId instances have the same value', () {
      //Arrange
      //Act
      final userId = UserConstants.arrangeUserId(
          userId: Constants.validUuids.elementAt(3));
      final userId2 = UserConstants.arrangeUserId(
          userId: Constants.validUuids.elementAt(3));
      //Assert
      expect(userId, equals(userId2));
    });

    test('Should not be equal if two Userd instances have different values',
        () {
      //Arrange
      //Act
      final userId = UserConstants.arrangeUserId(
          userId: Constants.validUuids.elementAt(1));
      final userId2 = UserConstants.arrangeUserId(
          userId: Constants.validUuids.elementAt(3));
      //Assert
      expect(userId, isNot(equals(userId2)));
    });
  });
}
