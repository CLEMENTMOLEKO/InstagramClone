import 'package:formz/formz.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

// Define input validation errors
enum PasswordInputError { invalidPassword }

// Extend FormzInput and provide the input type and error type.
class PasswordInput extends FormzInput<String, PasswordInputError> {
  // Call super.pure to represent an unmodified form input.
  const PasswordInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PasswordInput.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  PasswordInputError? validator(String value) {
    return Password.create(password: value).isRight()
        ? null
        : PasswordInputError.invalidPassword;
  }
}
