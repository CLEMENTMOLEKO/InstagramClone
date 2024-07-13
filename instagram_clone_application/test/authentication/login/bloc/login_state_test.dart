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
}
