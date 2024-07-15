import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

import '../../../test_utils/constants/constants.dart';

void main() {
  test("Should be equal when two states with same values are compared", () {
    //Arrange
    const loginState1 = LoginState();
    const loginState2 = LoginState();
    //Act
    //Assert
    expect(loginState1, loginState2);
  });

  test("Should be equal when two states with same values are compared", () {
    //Arrange
    final loginState1 = LoginState(
      formzSubmissionStatus: FormzSubmissionStatus.canceled,
      passwordInput: ValidatorsConstants.validPasswordInput,
      emailInput: ValidatorsConstants.validEmailInput,
    );
    final loginState2 = LoginState(
      formzSubmissionStatus: FormzSubmissionStatus.canceled,
      passwordInput: ValidatorsConstants.validPasswordInput,
      emailInput: ValidatorsConstants.validEmailInput,
    );
    //Act
    //Assert
    expect(loginState1, loginState2);
  });

  test("Should not be equal when two states with different values are compared",
      () {
    //Arrange
    final loginState1 = LoginState(
      formzSubmissionStatus: FormzSubmissionStatus.canceled,
      passwordInput: ValidatorsConstants.validPasswordInput,
    );
    const loginState2 = LoginState();
    //Act
    //Assert
    expect(loginState1, isNot(equals(loginState2)));
  });

  group("CopyWith", () {
    test("Should return current state when called without any different values",
        () {
      //Arrange
      const loginState = LoginState();
      //Act
      //Assert
      expect(loginState, loginState.copyWith());
    });

    test(
        "Should not return current state when called with any different values",
        () {
      //Arrange
      const loginState = LoginState();
      //Act
      //Assert
      expect(
        loginState,
        isNot(equals(loginState.copyWith(
          formzSubmissionStatus: FormzSubmissionStatus.canceled,
          passwordInput:
              PasswordInput.dirty(value: UserDtoConstants.validPasswords.first),
          emailInput:
              EmailInput.dirty(value: UserDtoConstants.validEmails.first),
          isValid: true,
        ))),
      );
    });
  });
}
