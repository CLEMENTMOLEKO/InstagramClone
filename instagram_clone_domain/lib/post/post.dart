import 'package:equatable/equatable.dart';

final class Post extends Equatable {
  final String id;
  final String description;
  final List<String> imageUrls;

  const Post({
    required this.id,
    required this.description,
    required this.imageUrls,
  });

  @override
  List<Object?> get props => [id, description, imageUrls];
}
