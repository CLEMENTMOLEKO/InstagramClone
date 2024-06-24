import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

import '../../common/errors/failure.dart';

final class UserDto extends Equatable {
  final String id;
  final String userName;
  final String bio;
  final String imageUrl;
  final String emailAddress;
  final List<String> posts;
  final List<String> reels;
  final DateTime joined;

  const UserDto({
    required this.id,
    required this.userName,
    required this.bio,
    required this.imageUrl,
    required this.emailAddress,
    required this.joined,
    this.posts = const [],
    this.reels = const [],
  });

  @override
  List<Object?> get props =>
      [id, userName, bio, imageUrl, emailAddress, posts, reels, joined];

  static Either<Failure, UserDto> fromJson(Map<String, dynamic> json) {
    try {
      return Right(UserDto(
        id: json['id'] as String,
        userName: json['userName'] as String,
        bio: json['bio'] as String,
        imageUrl: json['imageUrl'] as String,
        emailAddress: json['emailAddress'] as String,
        posts: List<String>.from(json['posts'] as List),
        reels: List<String>.from(json['reels'] as List),
        joined: json['joined'],
      ));
    } catch (e) {
      return const Left(Failure.invalidUserData);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'bio': bio,
      'imageUrl': imageUrl,
      'emailAddress': emailAddress,
      'posts': posts,
      'reels': reels,
      'joined': joined,
    };
  }

  UserDto copyWith({
    String? id,
    String? userName,
    String? bio,
    String? imageUrl,
    String? emailAddress,
    List<String>? posts,
    List<String>? reels,
    DateTime? joined,
  }) {
    return UserDto(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      bio: bio ?? this.bio,
      imageUrl: imageUrl ?? this.imageUrl,
      emailAddress: emailAddress ?? this.emailAddress,
      posts: posts ?? this.posts,
      reels: reels ?? this.reels,
      joined: joined ?? this.joined,
    );
  }
}