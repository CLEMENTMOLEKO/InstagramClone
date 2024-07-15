import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/authentication/authentication.dart';

import '../../../test_utils/constants/constants.dart';

void main() {
  group("LoginRequested", () {
    test(
        "Should be equal when two LoginRequested with same values are compared.",
        () {
      //Arrange
      final loginRequested = LoginRequested(
        email: UserDtoConstants.validEmails.first,
        password: UserDtoConstants.validPasswords.first,
      );
      final loginRequested1 = LoginRequested(
        email: UserDtoConstants.validEmails.first,
        password: UserDtoConstants.validPasswords.first,
      );
      //Act
      //Assert
      expect(loginRequested1, loginRequested);
    });

    test(
        "Should not be equal when two LoginRequested with different values are compared",
        () {
      //Arrange
      final loginRequested = LoginRequested(
        email: UserDtoConstants.validEmails.last,
        password: UserDtoConstants.validPasswords.last,
      );
      final loginRequested1 = LoginRequested(
        email: UserDtoConstants.validEmails.first,
        password: UserDtoConstants.validPasswords.first,
      );
      //Act
      //Assert
      expect(loginRequested1, isNot(equals(loginRequested)));
    });
  });

  group("EmailChanged", () {
    test(
        "Should be equal when two LoginRequested with same values are compared.",
        () {
      //Arrange
      final emailChanged =
          EmailChanged(email: UserDtoConstants.validEmails.first);
      final emailChanged1 =
          EmailChanged(email: UserDtoConstants.validEmails.first);
      //Act
      //Assert
      expect(emailChanged1, emailChanged);
    });

    test(
        "Should not be equal when two LoginRequested with different values are compared",
        () {
      //Arrange
      final emailChanged =
          EmailChanged(email: UserDtoConstants.validEmails.first);
      final emailChanged1 =
          EmailChanged(email: UserDtoConstants.validEmails.last);
      //Act
      //Assert
      expect(emailChanged, isNot(equals(emailChanged1)));
    });
  });

  group("PasswordChanged", () {
    test(
        "Should be equal when two LoginRequested with same values are compared.",
        () {
      //Arrange
      final passwordChanged =
          PasswordChanged(password: UserDtoConstants.validPasswords.first);
      final passwordChanged1 =
          PasswordChanged(password: UserDtoConstants.validPasswords.first);
      //Act
      //Assert
      expect(passwordChanged1, passwordChanged);
    });

    test(
        "Should not be equal when two LoginRequested with different values are compared",
        () {
      //Arrange
      final passwordChanged =
          PasswordChanged(password: UserDtoConstants.validPasswords.first);
      final passwordChanged1 =
          PasswordChanged(password: UserDtoConstants.validPasswords.last);
      //Act
      //Assert
      expect(passwordChanged1, isNot(equals(passwordChanged)));
    });
  });
}
