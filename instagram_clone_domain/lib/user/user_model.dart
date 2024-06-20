import 'package:equatable/equatable.dart';
import 'value_objects/email_address.dart';

final class UserModel extends Equatable {
  final String id;
  final String userName;
  final String bio;
  final String imageUrl;
  final EmailAddress emailAddress;

  const UserModel({
    required this.id,
    required this.userName,
    required this.bio,
    required this.imageUrl,
    required this.emailAddress,
  });

  @override
  List<Object?> get props => [id, userName, bio, imageUrl, emailAddress];
}
