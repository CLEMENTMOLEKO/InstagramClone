part of "constants.dart";

extension CommentConstants on Constants {
  static final replies = Constants.validUuids.map((validUuid) {
    return Reply(
      id: validUuid,
      userId: UserConstants.arrangeUserId(userId: validUuid),
    );
  }).toList();

  static final commentId =
      arrangeCommentId(commentId: '6c84fB90-12c4-11e1-840d-7b25c5ee775a');
  static Comment arrangePostCommentWith({required String description}) {
    return Comment.post(
      id: arrangeCommentId(commentId: Constants.validUuids.first),
      postId: PostConstants.postId,
      userId: UserConstants.userId,
      replies: CommentConstants.replies,
      likes: Constants.likes,
      description: description,
    );
  }

  static Comment arrangeReelCommentWith({required String description}) {
    return Comment.reel(
      id: arrangeCommentId(commentId: Constants.validUuids.first),
      reelId: ReelConstants.reelId,
      userId: UserConstants.userId,
      replies: CommentConstants.replies,
      likes: Constants.likes,
      description: description,
    );
  }

  static CommentId arrangeCommentId({required String commentId}) {
    final commentIdResults = CommentId.create(value: commentId);
    return commentIdResults
        .getOrElse(() => throw Exception("Invalid User Id $commentId"));
  }
}
