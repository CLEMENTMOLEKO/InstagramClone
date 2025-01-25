import 'package:dartz/dartz.dart';
import 'package:instagram_clone_domain/instagram_clone_domain.dart';

import '../common/errors/failure.dart';

abstract class PostRepository {
  /// [postsStream] returns a stream of [List<Post>]
  /// this stream is used to get the posts in real-time.
  Stream<List<Post>> get postsStream;

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

  /// [getPosts] returns Either an [ApplicationFailure] or [List<Post>],
  /// returns [ApplicationFailure] if getting posts was unsuccessful and
  /// returns [List<Post>] after getting posts from database.
  /// [limit] is the number of posts to get.
  /// [offset] is the number of posts to skip.
  Future<Either<ApplicationFailure, List<Post>>> getPosts({
    required int limit,
    required int offset,
  });
}
