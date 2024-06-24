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

  @override
  List<Object?> get props =>
      [id, postId, userId, replies, likes, description, reelId, date];
}
