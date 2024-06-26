part of '../comment_dto.dart';

extension CommentDomainConverter on CommentDto {
  Either<ApplicationFailure, Comment> toDomainComment() {
    return _createDomainValues();
  }

  Either<ApplicationFailure, Comment> _createDomainValues() {
    late ReelId? _reelId;
    late PostId? _postId;
    try {
      final commentId = CommentId.create(value: this.id)
          .getOrElse(() => throw Exception("Invalid Comment Id"));
      final userId = UserId.create(value: this.userId)
          .getOrElse(() => throw Exception("Invalid User Id"));
      final replies = this
          .replies
          .map((replyDto) => replyDto
              .toReplyDomain()
              .getOrElse(() => throw Exception("Invalid Reply $replyDto")))
          .toList();
      final likes = this
          .likes
          .map((like) => UserId.create(value: like)
              .getOrElse(() => throw Exception("Invalid Likes")))
          .toList();
      ReelId.create(value: reelId ?? "")
          .fold((_) => _reelId = null, (value) => _reelId = value);
      PostId.create(value: postId ?? "")
          .fold((_) => _postId = null, (value) => _postId = value);
      final createCommentResult = Comment.createComment(
        id: commentId,
        userId: userId,
        description: description,
        date: date,
        reelId: _reelId,
        postId: _postId,
        likes: likes,
        replies: replies,
      );
      return right(
        createCommentResult.getOrElse(
          () => throw Exception("Invalid Comment Data"),
        ),
      );
    } catch (e) {
      return left(ApplicationFailure.invalidCommentData);
    }
  }

  static CommentDto fromDomainComment({required Comment comment}) {
    if (comment.reelId != null) {
      return CommentDto.reel(
        id: comment.id.value,
        userId: comment.userId.value,
        likes: comment.likes.map((like) => like.value).toList(),
        description: comment.description,
        reelId: comment.reelId!.value,
        date: comment.date,
      );
    }

    return CommentDto.post(
      id: comment.id.value,
      postId: comment.postId!.value,
      userId: comment.userId.value,
      likes: comment.likes.map((like) => like.value).toList(),
      description: comment.description,
      date: comment.date,
    );
  }
}
