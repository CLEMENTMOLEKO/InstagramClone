import 'package:equatable/equatable.dart';

import '../../post/post.dart';
import '../../user/user.dart';
import '../common.dart';

final class Comment extends Equatable {
  final String id;
  final PostId postId;
  final UserId userId;
  final List<Reply> replies;
  final List<UserId> likes;
  final String description;

  const Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.replies,
    required this.likes,
    required this.description,
  });

  @override
  List<Object?> get props => [id, postId, userId, replies, likes, description];
}
