import 'package:equatable/equatable.dart';

import '../../user/user.dart';

final class Reply extends Equatable {
  final String id;
  final UserId userId;
  final String description;
  final DateTime date;

  const Reply({
    required this.id,
    required this.userId,
    required this.description,
    required this.date,
  });

  @override
  List<Object?> get props => [id, userId, description, date];
}
