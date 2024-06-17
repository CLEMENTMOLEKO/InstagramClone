import 'package:dartz/dartz.dart';
import 'package:instagram_clone_domain/Authentication/Errors/failure.dart';
import 'package:instagram_clone_domain/Models/value_object.dart';

final class EmailAddress extends ValueObject {
  final String value;
  EmailAddress._({required this.value});

  static Either<Failure, EmailAddress> create({required String email}) {
    if (_isValidEmail(email)) {
      return right(EmailAddress._(value: email));
    }
    return left(Failure.invalidEmail);
  }

  static bool _isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  @override
  List<Object?> get props => [value];
}
