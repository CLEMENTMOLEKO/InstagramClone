// Extend FormzInput and provide the input type and error type.
import 'package:dartz/dartz.dart';
import 'package:formz/formz.dart';

class UsernameInput extends FormzInput<String, Unit> {
  // Call super.pure to represent an unmodified form input.
  const UsernameInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const UsernameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  Unit? validator(String value) {
    return unit;
  }
}
