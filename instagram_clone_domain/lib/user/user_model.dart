import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../common/common.dart';
import '../post/value_objects/post_id.dart';
import '../reel/reel.dart';
import 'value_objects/email_address.dart';
import 'value_objects/user_id.dart';

final class UserModel extends Equatable {
  final UserId id;
  final String userName;
  final String bio;
  final String avatarUrl;
  final EmailAddress emailAddress;
  final List<PostId> posts;
  final List<ReelId> reels;
  final DateTime joined;

  const UserModel._({
    required this.id,
    required this.userName,
    required this.bio,
    required this.avatarUrl,
    required this.emailAddress,
    required this.joined,
    this.posts = const [],
    this.reels = const [],
  });

  static Either<DomainFailure, UserModel> createUser({
    required UserId userId,
    required String userName,
    required String bio,
    required String avatarUrl,
    required EmailAddress emailAddress,
    List<PostId> posts = const [],
    List<ReelId> reels = const [],
    required DateTime joined,
  }) {
    return right(UserModel._(
      id: userId,
      userName: userName,
      bio: bio,
      avatarUrl: avatarUrl,
      emailAddress: emailAddress,
      posts: posts,
      reels: reels,
      joined: joined,
    ));
  }

  @override
  List<Object?> get props =>
      [id, userName, bio, avatarUrl, emailAddress, posts];
}
