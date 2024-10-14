import 'package:formz/formz.dart';

// Define input validation errors
enum BirthdayInputError { invalidDateOrAge }

// Extend FormzInput and provide the input type and error type.
class BirthdayInput extends FormzInput<String, BirthdayInputError> {
  // Call super.pure to represent an unmodified form input.
  const BirthdayInput.pure() : super.pure("");

  // Call super.dirty to represent a modified form input.
  const BirthdayInput.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  BirthdayInputError? validator(String value) {
    try {
      final birthday = DateTime.parse(value);
      final now = DateTime.now();
      final bool hasNotHadBirthdayThisYear = now.month < birthday.month ||
          (now.month == birthday.month && now.day < birthday.day);
      final age =
          now.year - birthday.year - (hasNotHadBirthdayThisYear ? 1 : 0);

      if (age < 16 || birthday.isAfter(now)) {
        return BirthdayInputError.invalidDateOrAge;
      }

      return null;
    } catch (e) {
      // If parsing fails, it's an invalid date
      return BirthdayInputError.invalidDateOrAge;
    }
  }
}
