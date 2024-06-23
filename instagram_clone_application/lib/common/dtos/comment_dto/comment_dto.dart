import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../errors/failure.dart';
import '../reply_dto.dart';

final class CommentDto extends Equatable {
  final String id;
  final String? postId;
  final String? reelId;
  final String userId;
  final List<ReplyDto>? replies;
  final List<String> likes;
  final String description;

  const CommentDto.post({
    required this.id,
    required this.postId,
    required this.userId,
    this.replies,
    required this.likes,
    required this.description,
    this.reelId,
  });

  const CommentDto.reel({
    required this.id,
    this.postId,
    required this.userId,
    this.replies,
    required this.likes,
    required this.description,
    required this.reelId,
  });

  @override
  List<Object?> get props =>
      [id, postId, userId, replies, likes, description, reelId];

  static Either<Failure, CommentDto> fromJson(Map<String, dynamic> json) {
    try {
      if (json['postId'] != null) {
        return _fromPostJson(json);
      } else if (json['reelId'] != null) {
        return _fromReelJson(json);
      } else {
        return left(Failure.invalidCommentData);
      }
    } catch (e) {
      return left(Failure.invalidCommentData);
    }
  }

  static Either<Failure, CommentDto> _fromPostJson(Map<String, dynamic> json) {
    return right(CommentDto.post(
      id: json['id'] as String,
      postId: json['postId'] as String?,
      userId: json['userId'] as String,
      replies: _parseReplies(json['replies']),
      likes: _parseLikes(json['likes']),
      description: json['description'] as String,
    ));
  }

  static Either<Failure, CommentDto> _fromReelJson(Map<String, dynamic> json) {
    return right(CommentDto.reel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      replies: _parseReplies(json['replies']),
      likes: _parseLikes(json['likes']),
      description: json['description'] as String,
      reelId: json['reelId'] as String?,
    ));
  }

  static List<ReplyDto>? _parseReplies(List<dynamic> repliesJson) {
    return repliesJson
        .map((reply) => ReplyDto.fromJson(reply as Map<String, dynamic>)
            .getOrElse(() => throw Exception("Invalid reply data")))
        .toList();
  }

  static List<String> _parseLikes(List<dynamic> likesJson) {
    return List<String>.from(likesJson);
  }

  Map<String, dynamic> toJson() {
    final json = {
      'id': id,
      'postId': postId,
      'reelId': reelId,
      'userId': userId,
      'replies': replies?.map((reply) => reply.toJson()).toList(),
      'likes': likes,
      'description': description,
    };

    return json;
  }

  CommentDto copyWith({
    String? id,
    String? postId,
    String? reelId,
    String? userId,
    List<ReplyDto>? replies,
    List<String>? likes,
    String? description,
  }) {
    if (this.postId != null) {
      return CommentDto.post(
        id: id ?? this.id,
        postId: postId ?? this.postId,
        userId: userId ?? this.userId,
        replies: replies ?? this.replies,
        likes: likes ?? this.likes,
        description: description ?? this.description,
        reelId: reelId ?? this.reelId,
      );
    } else if (this.reelId != null) {
      return CommentDto.reel(
        id: id ?? this.id,
        postId: postId ?? this.postId,
        userId: userId ?? this.userId,
        replies: replies ?? this.replies,
        likes: likes ?? this.likes,
        description: description ?? this.description,
        reelId: reelId ?? this.reelId,
      );
    } else {
      throw Exception('Unknown type');
    }
  }
}
