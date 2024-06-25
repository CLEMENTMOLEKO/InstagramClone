import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/validation.dart';

import '../../user/user.dart';
import '../common.dart';

final class Reply extends Equatable {
  final String id;
  final UserId userId;
  final CommentId commentId;
  final String description;
  final DateTime date;

  const Reply({
    required this.id,
    required this.userId,
    required this.description,
    required this.date,
    required this.commentId,
  });

  static Either<DomainFailure, Reply> create({
    required String id,
    required UserId userId,
    required String description,
    required DateTime date,
    required CommentId commentId,
  }) {
    if (UuidValidation.isValidUUID(fromString: id)) {
      return right(
        Reply(
          id: id,
          userId: userId,
          description: description,
          date: date,
          commentId: commentId,
        ),
      );
    }
    return left(DomainFailure.invalidReplyId);
  }

  @override
  List<Object?> get props => [id, userId, description, date, commentId];
}
