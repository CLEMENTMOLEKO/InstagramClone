import 'package:equatable/equatable.dart';

import '../../user/user.dart';

final class Reply extends Equatable {
  final String id;
  final UserId userId;

  const Reply({
    required this.id,
    required this.userId,
  });

  @override
  List<Object?> get props => [id, userId];
}
