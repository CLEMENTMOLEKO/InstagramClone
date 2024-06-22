import 'package:dartz/dartz.dart';
import 'package:uuid/v8.dart';
import 'package:uuid/validation.dart';

import '../../common/common.dart';

final class ReelId extends ValueObject {
  final String value;

  ReelId._({required this.value});

  factory ReelId.createUnique() {
    return ReelId._(value: const UuidV8().toString());
  }

  static Either<Failure, ReelId> create({required String value}) {
    if (UuidValidation.isValidUUID(fromString: value)) {
      return right(ReelId._(value: value));
    }
    return left(Failure.invalidReelId);
  }

  @override
  List<Object?> get props => [value];
}
