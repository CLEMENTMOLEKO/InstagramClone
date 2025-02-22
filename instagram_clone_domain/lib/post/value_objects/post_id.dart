import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/validation.dart';

import '../../common/common.dart';

final class PostId extends ValueObject {
  final String value;

  PostId._({required this.value});

  factory PostId.createUnique() {
    return PostId._(value: const Uuid().v8());
  }

  static Either<DomainFailure, PostId> create({required String value}) {
    if (UuidValidation.isValidUUID(fromString: value)) {
      return right(PostId._(value: value));
    }
    return left(DomainFailure.invalidPostId);
  }

  @override
  List<Object?> get props => [value];
}
