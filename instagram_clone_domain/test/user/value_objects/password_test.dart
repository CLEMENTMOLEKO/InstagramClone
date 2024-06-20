import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_domain/common/common.dart';
import 'package:instagram_clone_domain/user/user.dart';

import '../../constants/constants.dart';

void main() {
  group("Password", () {
    group("Create", () {
      for (var validPassword in UserConstants.validPasswords) {
        test("Should return Password when given valid password", () {
          //Arrange
          final password =
              UserConstants.arrangePassword(password: validPassword);
          //Act
          final result = Password.create(password: validPassword);
          //Assert
          expect(result, right(password));
        });
      }

      for (var invalidPassword in UserConstants.invalidPasswords) {
        test("Should return Failure when given invalid password", () {
          //Arrange
          //Act
          final result = Password.create(password: invalidPassword);
          //Assert
          expect(result, left(Failure.invalidPassword));
        });
      }
    });

    test('Should implement ValueObject', () {
      //Arrange
      //Act
      final email = UserConstants.arrangePassword(
          password: UserConstants.validPasswords.elementAt(2));
      //Assert
      expect(email, isA<ValueObject>());
    });

    test('Should be equal if two EmailAddress instances have the same value',
        () {
      //Arrange
      //Act
      final password3 = UserConstants.arrangePassword(
          password: UserConstants.validPasswords.elementAt(3));
      final password2 = UserConstants.arrangePassword(
          password: UserConstants.validPasswords.elementAt(3));
      //Assert
      expect(password3, equals(password2));
    });

    test(
        'Should not be equal if two EmailAddress instances have different values',
        () {
      //Arrange
      //Act
      final password1 = UserConstants.arrangePassword(
          password: UserConstants.validPasswords.elementAt(1));
      final passwrod2 = UserConstants.arrangePassword(
          password: UserConstants.validPasswords.elementAt(2));
      //Assert
      expect(password1, isNot(equals(passwrod2)));
    });
  });
}
