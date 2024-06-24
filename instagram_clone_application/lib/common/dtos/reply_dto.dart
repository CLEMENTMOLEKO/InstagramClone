import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../errors/failure.dart';

final class ReplyDto extends Equatable {
  final String id;
  final String userId;
  final String description;
  final DateTime date;

  const ReplyDto({
    required this.id,
    required this.userId,
    required this.description,
    required this.date,
  });

  @override
  List<Object?> get props => [id, userId, description, date];

  static Either<Failure, ReplyDto> fromJson(Map<String, dynamic> json) {
    try {
      return right(ReplyDto(
        id: json['id'] as String,
        userId: json['userId'] as String,
        description: json['description'] as String,
        date: DateFormat("yyyy/MM/dd").parse(json['date']),
      ));
    } catch (e) {
      return left(Failure.invalidReplyData);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'description': description,
      'date': DateFormat("yyyy/MM/dd").format(date),
    };
  }

  ReplyDto copyWith({
    String? id,
    String? userId,
    String? description,
    DateTime? date,
  }) {
    return ReplyDto(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        description: description ?? this.description,
        date: date ?? this.date);
  }
}
