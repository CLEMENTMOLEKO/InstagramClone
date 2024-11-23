import 'package:dartz/dartz.dart';
import 'package:instagram_clone_domain/common/common.dart';
import 'package:uuid/v8.dart';

final class UserId extends ValueObject {
  final String value;

  UserId._({required this.value});

  factory UserId.createUnique() {
    return UserId._(value: const UuidV8().toString());
  }

  static Either<DomainFailure, UserId> create({required String value}) {
    // Firebase user IDs are 28 characters long
    // Match Firebase 28 char ID (alphanumeric), UUID format, or GUID format
    // TODO: Change test constants to use firebase user IDs
    const pattern =
        r'^[A-Za-z0-9]{28}$|^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$';
    if (RegExp(pattern).hasMatch(value)) {
      return right(UserId._(value: value));
    }
    return left(DomainFailure.invalidUserId);
  }

  @override
  List<Object?> get props => [value];
}
