part of 'constants.dart';

extension CommentDtoConstants on Constants {
  static final postCommentDto = CommentDto.post(
    id: Constants.validUuids.first,
    postId: Constants.validUuids.first,
    userId: Constants.validUuids.first,
    likes: Constants.validUuids.toList(),
    description: "This is the first application comment.",
    date: DateTime.now(),
  );

  static final reelCommentDto = CommentDto.reel(
    id: Constants.validUuids.first,
    reelId: Constants.validUuids.first,
    userId: Constants.validUuids.first,
    likes: Constants.validUuids.toList(),
    description: "This is the first application comment.",
    date: DateTime.now(),
  );

  static final replyDto = ReplyDto(
    id: Constants.validUuids.first,
    userId: Constants.validUuids.first,
    description: "You lying this is not production it's test env.",
    date: DateTime.now(),
    commentId: Constants.validUuids.first,
  );

  static CommentDto arrangePostCommentDtowith({
    required String description,
    DateTime? date,
    String? postId,
    String? userId,
    String? id,
  }) {
    return CommentDto.post(
      id: id ?? Constants.validUuids.first,
      postId: postId ?? Constants.validUuids.first,
      userId: userId ?? Constants.validUuids.first,
      likes: Constants.validUuids.toList(),
      description: description,
      date: date ?? DateTime.now(),
    );
  }

  static CommentDto arrangeReelCommentDtowith({
    required String description,
    DateTime? date,
    String? reelId,
    String? userId,
    String? id,
  }) {
    return CommentDto.reel(
      id: id ?? Constants.validUuids.first,
      reelId: reelId ?? Constants.validUuids.first,
      userId: userId ?? Constants.validUuids.first,
      likes: Constants.validUuids.toList(),
      description: description,
      date: date ?? DateTime.now(),
    );
  }

  static ReplyDto arrangeReplyDto({
    required String description,
    DateTime? date,
    String? userId,
  }) {
    return ReplyDto(
      id: Constants.validUuids.first,
      userId: userId ?? Constants.validUuids.first,
      description: "You lying, this is not production, it's test environment.",
      date: date ?? DateTime.now(),
      commentId: Constants.validUuids.last,
    );
  }
}
