import 'package:dartz/dartz.dart';
import 'package:instagram_clone_domain/instagram_clone_domain.dart';

import '../common/errors/failure.dart';

abstract class PostRepository {
  /// [createPost] returns Either an [ApplicationFailure] or [Unit],
  /// returns [ApplicationFailure] if creating post was unsuccessful and
  /// returns [Unit] after creating post.
  Future<Either<ApplicationFailure, Unit>> createPost({
    required Post post,
  });

  /// [getPost] returns Either an [ApplicationFailure] or [Post],
  /// returns [ApplicationFailure] if getting post was unsuccessful and
  /// returns [Post] after getting post from database.
  Future<Either<ApplicationFailure, Post>> getPost({
    required String postId,
  });
}
