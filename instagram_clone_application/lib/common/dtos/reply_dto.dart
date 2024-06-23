import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failure.dart';

final class ReplyDto extends Equatable {
  final String id;
  final String userId;
  final String description;

  const ReplyDto({
    required this.id,
    required this.userId,
    required this.description,
  });

  @override
  List<Object?> get props => [id, userId, description];

  static Either<Failure, ReplyDto> fromJson(Map<String, dynamic> json) {
    try {
      return right(ReplyDto(
        id: json['id'] as String,
        userId: json['userId'] as String,
        description: json['description'],
      ));
    } catch (e) {
      return left(Failure.invalidReplyData);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
    };
  }

  ReplyDto copyWith({
    String? id,
    String? userId,
    String? description,
  }) {
    return ReplyDto(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      description: description ?? this.description,
    );
  }
}
