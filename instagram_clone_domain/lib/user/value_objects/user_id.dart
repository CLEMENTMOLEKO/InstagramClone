import 'package:dartz/dartz.dart';
import 'package:instagram_clone_domain/common/common.dart';
import 'package:uuid/v8.dart';
import 'package:uuid/validation.dart';

final class UserId extends ValueObject {
  final String value;

  UserId._({required this.value});

  factory UserId.createUnique() {
    return UserId._(value: const UuidV8().toString());
  }

  static Either<Failure, UserId> create({required String value}) {
    if (UuidValidation.isValidUUID(fromString: value)) {
      return right(UserId._(value: value));
    }
    return left(Failure.invalidUserId);
  }

  @override
  List<Object?> get props => [value];
}
