import 'package:equatable/equatable.dart';

import '../common/common.dart';
import '../user/user.dart';
import 'value_objects/post_id.dart';

final class Post extends Equatable {
  final PostId id;
  final UserId userId;
  final String description;
  final List<String> imageUrls;
  final List<UserId> likes;
  final List<Comment> comments;

  const Post({
    required this.id,
    required this.userId,
    required this.description,
    required this.imageUrls,
    required this.likes,
    this.comments = const [],
  });

  @override
  List<Object?> get props => [id, userId, description, imageUrls, likes];
}
