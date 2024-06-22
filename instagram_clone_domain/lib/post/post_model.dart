import 'package:equatable/equatable.dart';

import '../user/user.dart';

final class Post extends Equatable {
  final String id;
  final UserId userId;
  final String description;
  final List<String> imageUrls;
  final List<UserId> likes;

  const Post({
    required this.id,
    required this.userId,
    required this.description,
    required this.imageUrls,
    required this.likes,
  });

  @override
  List<Object?> get props => [id, userId, description, imageUrls, likes];
}
