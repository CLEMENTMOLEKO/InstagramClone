part of 'constants.dart';

extension ValidatorsConstants on Constants {
  static final validPasswordInput =
      PasswordInput.dirty(value: UserDtoConstants.validPasswords.first);
  static final validEmailInput =
      EmailInput.dirty(value: UserDtoConstants.validEmails.first);

  static final invalidPasswordInput =
      PasswordInput.dirty(value: UserDtoConstants.invalidPasswords.first);
  static final invalidEmailInput =
      EmailInput.dirty(value: UserDtoConstants.invalidEmails.first);
}
