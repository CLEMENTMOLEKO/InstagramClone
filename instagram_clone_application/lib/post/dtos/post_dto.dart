import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../common/dtos/comment_dto.dart';
import '../../common/errors/failure.dart';

final class PostDto extends Equatable {
  final String id;
  final String userId;
  final String description;
  final List<String> imageUrls;
  final List<String> likes;
  final List<CommentDto> comments;
  final DateTime date;

  const PostDto({
    required this.id,
    required this.userId,
    required this.description,
    required this.imageUrls,
    required this.date,
    this.likes = const [],
    this.comments = const [],
  });

  @override
  List<Object?> get props =>
      [id, userId, description, imageUrls, likes, comments, date];

  static Either<Failure, PostDto> fromJson(Map<String, dynamic> json) {
    try {
      return right(
        PostDto(
          id: json['id'] as String,
          userId: json['userId'] as String,
          description: json['description'] as String,
          imageUrls: List<String>.from(json['imageUrls'] as List<dynamic>),
          likes: List<String>.from(json['likes'] as List<dynamic>),
          comments: (json['comments'] as List<dynamic>)
              .map((comment) => CommentDto.fromJson(
                      comment as Map<String, dynamic>)
                  .getOrElse(() => throw Exception("Invalid comment data.")))
              .toList(),
          date: DateFormat("yyyy/MM/dd").parse(json['date']),
        ),
      );
    } catch (e) {
      return left(Failure.invalidPostData);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'description': description,
      'imageUrls': imageUrls,
      'likes': likes,
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'date': DateFormat("yyyy/MM/dd").format(date),
    };
  }

  PostDto copyWith({
    String? id,
    String? userId,
    String? description,
    List<String>? imageUrls,
    List<String>? likes,
    List<CommentDto>? comments,
    DateTime? date,
  }) {
    return PostDto(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      description: description ?? this.description,
      imageUrls: imageUrls ?? this.imageUrls,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      date: date ?? this.date,
    );
  }
}
