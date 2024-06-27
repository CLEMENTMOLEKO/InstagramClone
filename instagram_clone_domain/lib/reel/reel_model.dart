import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../common/common.dart';
import '../user/user.dart';
import 'value_objects/reel_id.dart';

final class Reel extends Equatable {
  final ReelId id;
  final UserId userId;
  final String videoUrl;
  final String thumbnailUrl;
  final String description;
  final List<UserId> likes;
  final List<Comment> comments;
  final DateTime date;

  const Reel._({
    required this.id,
    required this.userId,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.likes,
    required this.description,
    required this.date,
    this.comments = const [],
  });

  static Either<DomainFailure, Reel> createReel({
    required ReelId id,
    required UserId userId,
    required String description,
    required DateTime date,
    required String videoUrl,
    required String thumbnailUrl,
    List<UserId> likes = const [],
    List<Comment> comments = const [],
  }) {
    return right(Reel._(
      id: id,
      userId: userId,
      description: description,
      videoUrl: videoUrl,
      thumbnailUrl: thumbnailUrl,
      likes: likes,
      date: date,
      comments: comments,
    ));
  }

  @override
  List<Object?> get props =>
      [id, userId, videoUrl, thumbnailUrl, likes, description, date];
}
