import 'package:dartz/dartz.dart';
import 'package:instagram_clone_domain/common/errors/errors.dart';
import 'package:uuid/v8.dart';
import 'package:uuid/validation.dart';

import '../../../value_object.dart';

final class CommentId extends ValueObject {
  final String value;

  CommentId._({required this.value});

  factory CommentId.createUnique() {
    return CommentId._(value: const UuidV8().toString());
  }

  static Either<DomainFailure, CommentId> create({required String value}) {
    if (UuidValidation.isValidUUID(fromString: value)) {
      return right(CommentId._(value: value));
    }
    return left(DomainFailure.invalidCommentId);
  }

  @override
  List<Object?> get props => [value];
}
