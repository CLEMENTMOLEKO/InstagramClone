import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone_application/common/errors/failure.dart';
import 'package:instagram_clone_domain/instagram_clone_domain.dart';
import 'package:intl/intl.dart';

import '../../common/dtos/comment_dto.dart';

part './domain_converter/reel_dto_domain_converter.dart';

final class ReelDto extends Equatable {
  final String id;
  final String userId;
  final String videoUrl;
  final String thumbnailUrl;
  final String description;
  final List<String> likes;
  final List<CommentDto> comments;
  final DateTime date;

  const ReelDto({
    required this.id,
    required this.userId,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.likes,
    required this.description,
    required this.date,
    this.comments = const [],
  });

  @override
  List<Object?> get props =>
      [id, userId, videoUrl, thumbnailUrl, likes, description, comments, date];

  static Either<ApplicationFailure, ReelDto> fromJson(
      Map<String, dynamic> json) {
    try {
      return right(
        ReelDto(
          id: json['id'] as String,
          userId: json['userId'] as String,
          videoUrl: json['videoUrl'] as String,
          thumbnailUrl: json['thumbnailUrl'] as String,
          description: json['description'] as String,
          likes: List<String>.from(json['likes'] as List),
          comments: (json['comments'] as List)
              .map((comment) =>
                  CommentDto.fromJson(comment as Map<String, dynamic>)
                      .getOrElse(
                    () => throw Exception("Invalid Reel Data"),
                  ))
              .toList(),
          date: DateFormat("yyyy/MM/dd").parse(json['date']),
        ),
      );
    } catch (e) {
      return left(ApplicationFailure.invalidReelData);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
      'description': description,
      'likes': likes,
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'date': DateFormat("yyyy/MM/dd").format(date),
    };
  }

  ReelDto copyWith({
    String? id,
    String? userId,
    String? videoUrl,
    String? thumbnailUrl,
    String? description,
    List<String>? likes,
    List<CommentDto>? comments,
    DateTime? date,
  }) {
    return ReelDto(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      description: description ?? this.description,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      date: date ?? this.date,
    );
  }
}
