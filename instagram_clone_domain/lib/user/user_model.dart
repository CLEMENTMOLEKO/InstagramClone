import 'package:equatable/equatable.dart';

import '../post/value_objects/post_id.dart';
import 'value_objects/email_address.dart';
import 'value_objects/user_id.dart';

final class UserModel extends Equatable {
  final UserId id;
  final String userName;
  final String bio;
  final String imageUrl;
  final EmailAddress emailAddress;
  final List<PostId> posts;

  const UserModel({
    required this.id,
    required this.userName,
    required this.bio,
    required this.imageUrl,
    required this.emailAddress,
    this.posts = const [],
  });

  @override
  List<Object?> get props => [id, userName, bio, imageUrl, emailAddress, posts];
}
