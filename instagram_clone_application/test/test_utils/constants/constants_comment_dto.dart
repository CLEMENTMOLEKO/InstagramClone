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
  );

  static CommentDto arrangePostCommentDtowith({
    required String description,
    DateTime? date,
  }) {
    return CommentDto.post(
      id: Constants.validUuids.first,
      postId: Constants.validUuids.first,
      userId: Constants.validUuids.first,
      likes: Constants.validUuids.toList(),
      description: description,
      date: date ?? DateTime.now(),
    );
  }

  static CommentDto arrangeReelCommentDtowith({
    required String description,
    DateTime? date,
  }) {
    return CommentDto.reel(
      id: Constants.validUuids.first,
      reelId: Constants.validUuids.first,
      userId: Constants.validUuids.first,
      likes: Constants.validUuids.toList(),
      description: description,
      date: date ?? DateTime.now(),
    );
  }
}
