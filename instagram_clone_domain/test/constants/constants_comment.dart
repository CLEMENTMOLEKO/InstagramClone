part of "constants.dart";

extension CommentConstants on Constants {
  static final replies = Constants.validUuids.map((validUuid) {
    return Reply(
      id: validUuid,
      userId: UserConstants.arrangeUserId(userId: validUuid),
    );
  }).toList();

  static Comment arrangeCommentWith({required String description}) {
    return Comment(
      id: "random-uid-string",
      postId: PostConstants.postId,
      userId: UserConstants.userId,
      replies: CommentConstants.replies,
      likes: Constants.likes,
      description: description,
    );
  }
}
