import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:instagram_clone_application/authentication/validators/username_input_validator.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_shared/instagram_clone_shared.dart';

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

  group("CopyWith", () {
    test("Should return current state when called without any different values",
        () {
      //Arrange
      const signUpState = SignUpState();
      //Act
      //Assert
      expect(signUpState, signUpState.copyWith());
    });

    test(
        "Should not return current state when called with any different values",
        () {
      //Arrange
      const signUpState = SignUpState();
      //Act
      //Assert
      expect(
        signUpState,
        isNot(equals(signUpState.copyWith(
          formzSubmissionStatus: FormzSubmissionStatus.canceled,
          passwordInput:
              PasswordInput.dirty(value: UserDtoConstants.validPasswords.first),
          emailInput:
              EmailInput.dirty(value: UserDtoConstants.validEmails.first),
          usernameInput: const UsernameInput.dirty(value: "Clement"),
          isUsernameValid: true,
        ))),
      );
    });
  });
}
