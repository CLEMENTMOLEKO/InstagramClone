import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

import '../../../test_utils/constants/constants.dart';

void main() {
  const userName = "Clement";
  group("SignUpRequested", () {
    test(
        "Should be equal when two SignUpRequested with same values are compared.",
        () {
      //Arrange
      final signUpRequested = SignUpRequested(
        email: UserDtoConstants.validEmails.first,
        password: UserDtoConstants.validPasswords.first,
        userName: userName,
      );
      final signUpRequested1 = SignUpRequested(
        email: UserDtoConstants.validEmails.first,
        password: UserDtoConstants.validPasswords.first,
        userName: userName,
      );
      //Act
      //Assert
      expect(signUpRequested1, signUpRequested);
    });

    test(
        "Should not be equal when two SignUpRequested with different values are compared",
        () {
      //Arrange
      final signUpRequested = SignUpRequested(
        email: UserDtoConstants.validEmails.last,
        password: UserDtoConstants.validPasswords.last,
        userName: userName,
      );
      final signUpRequested1 = SignUpRequested(
        email: UserDtoConstants.validEmails.first,
        password: UserDtoConstants.validPasswords.first,
        userName: "${userName}J",
      );
      //Act
      //Assert
      expect(signUpRequested1, isNot(equals(signUpRequested)));
    });
  });

  group("SignUpEmailChanged", () {
    test(
        "Should be equal when two SignUpEmailChanged with same values are compared.",
        () {
      //Arrange
      final emailChanged =
          SignUpEmailChanged(email: UserDtoConstants.validEmails.first);
      final emailChanged1 =
          SignUpEmailChanged(email: UserDtoConstants.validEmails.first);
      //Act
      //Assert
      expect(emailChanged1, emailChanged);
    });

    test(
        "Should not be equal when two SignUpEmailChanged with different values are compared",
        () {
      //Arrange
      final emailChanged =
          SignUpEmailChanged(email: UserDtoConstants.validEmails.first);
      final emailChanged1 =
          SignUpEmailChanged(email: UserDtoConstants.validEmails.last);
      //Act
      //Assert
      expect(emailChanged, isNot(equals(emailChanged1)));
    });
  });

  group("SignUpPasswordChanged", () {
    test(
        "Should be equal when two SignUpPasswordChanged with same values are compared.",
        () {
      //Arrange
      final passwordChanged = SignUpPasswordChanged(
          password: UserDtoConstants.validPasswords.first);
      final passwordChanged1 = SignUpPasswordChanged(
          password: UserDtoConstants.validPasswords.first);
      //Act
      //Assert
      expect(passwordChanged1, passwordChanged);
    });

    test(
        "Should not be equal when two SignUpPasswordChanged with different values are compared",
        () {
      //Arrange
      final passwordChanged = SignUpPasswordChanged(
          password: UserDtoConstants.validPasswords.first);
      final passwordChanged1 =
          SignUpPasswordChanged(password: UserDtoConstants.validPasswords.last);
      //Act
      //Assert
      expect(passwordChanged1, isNot(equals(passwordChanged)));
    });
  });

  group("UserNameChanged", () {
    test(
        "Should be equal when two UserNameChanged with same values are compared.",
        () {
      //Arrange
      final userNameChanged = UserNameChanged(userName: userName);
      final userNameChanged1 = UserNameChanged(userName: userName);
      //Act
      //Assert
      expect(userNameChanged1, userNameChanged);
    });

    test(
        "Should not be equal when two SignUpRequested with different values are compared",
        () {
      //Arrange
      final userNameChanged = UserNameChanged(userName: userName);
      final userNameChanged1 = UserNameChanged(userName: "${userName}J");
      //Act
      //Assert
      expect(userNameChanged1, isNot(equals(userNameChanged)));
    });
  });
}
