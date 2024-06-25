import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../reel/reel.dart';
import '../../../post/post.dart';
import '../../../user/user.dart';
import '../../common.dart';

final class Comment extends Equatable {
  final CommentId id;
  final PostId? postId;
  final ReelId? reelId;
  final UserId userId;
  final List<Reply> replies;
  final List<UserId> likes;
  final String description;
  final DateTime date;

  const Comment.post({
    required this.id,
    required this.postId,
    required this.userId,
    required this.replies,
    required this.likes,
    required this.description,
    required this.date,
    this.reelId,
  });

  const Comment.reel({
    required this.id,
    required this.userId,
    required this.replies,
    required this.likes,
    required this.description,
    required this.reelId,
    required this.date,
    this.postId,
  });

  static Either<DomainFailure, Comment> createComment({
    required CommentId id,
    PostId? postId,
    ReelId? reelId,
    required UserId userId,
    List<Reply> replies = const [],
    List<UserId> likes = const [],
    required String description,
    required DateTime date,
  }) {
    //Check if atleast a post or reel id exists
    if (reelId == null && postId == null) {
      return left(DomainFailure.invalidCommentData);
    }

    if (reelId != null) {
      return right(
        _createReelComment(
          id: id,
          reelId: reelId,
          userId: userId,
          description: description,
          date: date,
          replies: replies,
          likes: likes,
        ),
      );
    }

    return right(
      _createPostComment(
        id: id,
        postId: postId!,
        userId: userId,
        description: description,
        date: date,
        replies: replies,
        likes: likes,
      ),
    );
  }

  static Comment _createReelComment({
    required CommentId id,
    required ReelId reelId,
    required UserId userId,
    List<Reply> replies = const [],
    List<UserId> likes = const [],
    required String description,
    required DateTime date,
  }) {
    return Comment.reel(
      id: id,
      userId: userId,
      replies: replies,
      likes: likes,
      description: description,
      reelId: reelId,
      date: date,
    );
  }

  static Comment _createPostComment({
    required CommentId id,
    required PostId postId,
    required UserId userId,
    List<Reply> replies = const [],
    List<UserId> likes = const [],
    required String description,
    required DateTime date,
  }) {
    return Comment.post(
      id: id,
      postId: postId,
      userId: userId,
      replies: replies,
      likes: likes,
      description: description,
      date: date,
    );
  }

  @override
  List<Object?> get props =>
      [id, postId, userId, replies, likes, description, reelId, date];
}
