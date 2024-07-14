import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

import '../../../test_utils/constants/constants.dart';

void main() {
  late SignUpState sut;

  setUp(() {
    sut = const SignUpState();
  });

  test("Should be equal when two states with same values are compared", () {
    //Arrange
    const loginState2 = SignUpState();
    //Act
    //Assert
    expect(sut, loginState2);
  });

  test("Should be equal when two states with same values are compared", () {
    //Arrange
    final signUpSate1 = SignUpState(
      formzSubmissionStatus: FormzSubmissionStatus.canceled,
      passwordInput: ValidatorsConstants.validPasswordInput,
      emailInput: ValidatorsConstants.validEmailInput,
    );
    final signUpSate2 = SignUpState(
      formzSubmissionStatus: FormzSubmissionStatus.canceled,
      passwordInput: ValidatorsConstants.validPasswordInput,
      emailInput: ValidatorsConstants.validEmailInput,
    );
    //Act
    //Assert
    expect(signUpSate1, signUpSate2);
  });

  test("Should not be equal when two states with different values are compared",
      () {
    //Arrange
    final signUpSate1 = SignUpState(
      formzSubmissionStatus: FormzSubmissionStatus.canceled,
      passwordInput: ValidatorsConstants.validPasswordInput,
    );
    //Act
    //Assert
    expect(sut, isNot(equals(signUpSate1)));
  });
}
