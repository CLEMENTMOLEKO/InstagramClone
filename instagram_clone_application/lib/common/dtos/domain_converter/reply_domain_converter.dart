part of '../reply_dto.dart';

extension ReplyDomainConverter on ReplyDto {
  Either<ApplicationFailure, Reply> toReplyDomain() {
    try {
      final userId = UserId.create(value: this.userId)
          .getOrElse(() => throw Exception("Invalid User Id"));
      final commentId = CommentId.create(value: this.commentId).getOrElse(
        () => throw Exception("Invalid Comment Id"),
      );
      final createReplyResult = Reply.create(
        id: this.id,
        userId: userId,
        description: description,
        date: date,
        commentId: commentId,
      );

      if (createReplyResult.isLeft()) {
        return left(ApplicationFailure.invalidReelData);
      }

      return right(
        createReplyResult.getOrElse(() => throw Exception("Unexpected Error")),
      );
    } catch (e) {
      return left(ApplicationFailure.invalidReplyData);
    }
  }

  static ReplyDto fromDomainReply({required Reply reply}) {
    return ReplyDto(
      id: reply.id,
      userId: reply.userId.value,
      description: reply.description,
      date: reply.date,
      commentId: reply.commentId.value,
    );
  }
}
