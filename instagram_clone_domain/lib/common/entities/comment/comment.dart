import 'package:equatable/equatable.dart';
import 'package:instagram_clone_domain/instagram_clone_domain.dart';

import '../../../post/post.dart';
import '../../../user/user.dart';
import '../../common.dart';
import 'value_objects/comment_id.dart';

final class Comment extends Equatable {
  final CommentId id;
  final PostId? postId;
  final ReelId? reelId;
  final UserId userId;
  final List<Reply> replies;
  final List<UserId> likes;
  final String description;

  const Comment.post({
    required this.id,
    required this.postId,
    required this.userId,
    required this.replies,
    required this.likes,
    required this.description,
    this.reelId,
  });

  const Comment.reel({
    required this.id,
    this.postId,
    required this.userId,
    required this.replies,
    required this.likes,
    required this.description,
    required this.reelId,
  });

  @override
  List<Object?> get props => [id, postId, userId, replies, likes, description];
}
