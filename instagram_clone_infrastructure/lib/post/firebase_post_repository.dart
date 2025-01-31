import 'package:dartz/dartz.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

final class FirebasePostRepository implements PostRepository {
  @override
  Future<Either<ApplicationFailure, Unit>> createPost({
    required Post post,
  }) async {
    return right(unit);
  }

  @override
  Future<Either<ApplicationFailure, Post>> getPost({
    required String postId,
  }) async {
    return left(ApplicationFailure.errorGettingPost);
  }

  @override
  Future<Either<ApplicationFailure, List<Post>>> getPosts({
    required int limit,
    required int offset,
  }) async {
    return right([]);
  }

  @override
  //TODO: implement postsStream
  Stream<List<Post>> get postsStream => Stream.value([]);
}
