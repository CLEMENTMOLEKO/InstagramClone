import 'package:equatable/equatable.dart';

import '../../user/user.dart';

final class Reply extends Equatable {
  final String id;
  final UserId userId;
  final String description;

  const Reply({
    required this.id,
    required this.userId,
    required this.description,
  });

  @override
  List<Object?> get props => [id, userId, description];
}
