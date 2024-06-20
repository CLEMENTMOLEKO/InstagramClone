import 'package:dartz/dartz.dart';
import 'package:instagram_clone_domain/common/common.dart';

final class Password extends ValueObject {
  final String value;
  Password._({required this.value});

  static Either<Failure, Password> create({required String password}) {
    if (_isValidPassword(password)) {
      return right(Password._(value: password));
    }
    return left(Failure.invalidPassword);
  }

  @override
  List<Object?> get props => [value];

  static bool _isValidPassword(String password) {
    //Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character:
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$')
        .hasMatch(password);
  }
}
