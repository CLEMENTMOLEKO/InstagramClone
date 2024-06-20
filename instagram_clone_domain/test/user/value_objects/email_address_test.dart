import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_domain/common/common.dart';
import 'package:instagram_clone_domain/user/user.dart';

import '../../constants/constants.dart';

void main() {
  group('EmailAddress', () {
    group("Create", () {
      for (var validEmail in UserConstants.validEmails) {
        test(
            "Should return an email address when provided a valid email address",
            () {
          //Arrange
          final email = UserConstants.arrangeEmailAddress(email: validEmail);
          //Act
          final result = EmailAddress.create(email: validEmail);
          //Assert
          expect(result, Right(email));
        });
      }

      for (var invalidEmail in UserConstants.invalidEmails) {
        test("Should return failure when provided an invalid email address",
            () {
          //Arrange
          //Act
          final result = EmailAddress.create(email: invalidEmail);
          //Assert
          expect(result, const Left(Failure.invalidEmail));
        });
      }
    });
    test('Should implement ValueObject', () {
      //Arrange
      //Act
      final email = UserConstants.arrangeEmailAddress();
      //Assert
      expect(email, isA<ValueObject>());
    });

    test('Should be equal if two EmailAddress instances have the same value',
        () {
      //Arrange
      //Act
      final email1 = UserConstants.arrangeEmailAddress(
          email: UserConstants.validEmails.last);
      final email2 = UserConstants.arrangeEmailAddress(
          email: UserConstants.validEmails.last);
      //Assert
      expect(email1, equals(email2));
    });

    test(
        'Should not be equal if two EmailAddress instances have different values',
        () {
      //Arrange
      //Act
      final email1 = UserConstants.arrangeEmailAddress(
          email: UserConstants.validEmails.first);
      final email2 = UserConstants.arrangeEmailAddress(
          email: UserConstants.validEmails.elementAt(3));
      //Assert
      expect(email1, isNot(equals(email2)));
    });
  });
}
