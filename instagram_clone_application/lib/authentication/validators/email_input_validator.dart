import 'package:formz/formz.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

// Define input validation errors
enum EmailInputError { invalidEmail }

// Extend FormzInput and provide the input type and error type.
class EmailInput extends FormzInput<String, EmailInputError> {
  // Call super.pure to represent an unmodified form input.
  const EmailInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const EmailInput.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  EmailInputError? validator(String value) {
    return EmailAddress.create(email: value).isRight()
        ? null
        : EmailInputError.invalidEmail;
  }
}
