import 'package:dartz/dartz.dart';
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
  final DateTime date;

  const Post._({
    required this.id,
    required this.userId,
    required this.description,
    required this.imageUrls,
    required this.likes,
    required this.date,
    this.comments = const [],
  });

  static Either<DomainFailure, Post> createPost({
    required PostId id,
    required UserId userId,
    required String description,
    required DateTime date,
    List<String> imageUrls = const [],
    List<UserId> likes = const [],
    List<Comment> comments = const [],
  }) {
    return right(Post._(
      id: id,
      userId: userId,
      description: description,
      imageUrls: imageUrls,
      likes: likes,
      date: date,
      comments: comments,
    ));
  }

  @override
  List<Object?> get props => [id, userId, description, imageUrls, likes, date];
}
