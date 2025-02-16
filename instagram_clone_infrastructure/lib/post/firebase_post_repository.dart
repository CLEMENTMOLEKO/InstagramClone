import 'package:dartz/dartz.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final class FirebasePostRepository implements PostRepository {
  final postsCollection = "posts";
  final FirebaseFirestore db;
  FirebasePostRepository({FirebaseFirestore? db})
      : db = db ?? FirebaseFirestore.instance;

  @override
  Future<Either<ApplicationFailure, Unit>> createPost({
    required Post post,
  }) async {
    try {
      await db
          .collection(postsCollection)
          .doc(post.id.value)
          .set(PostDtoDomainConverter.fromDomainPost(post: post).toJson());
      return right(unit);
    } catch (e) {
      return left(ApplicationFailure.errorCreatingPost);
    }
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
