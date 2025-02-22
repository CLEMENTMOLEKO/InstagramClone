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
    try {
      final postDocument =
          await db.collection(postsCollection).doc(postId).get();
      final postDto = PostDto.fromJson(postDocument.data()!)
          .getOrElse(() => throw Exception("Error getting post from json"));
      final post = postDto.toDomainPost().getOrElse(
          () => throw Exception("Error converting post dto to domain post"));
      return right(post);
    } catch (e) {
      return left(ApplicationFailure.errorGettingPost);
    }
  }

  @override
  Future<Either<ApplicationFailure, List<Post>>> getPosts({
    required int limit,
    required int offset,
  }) async {
    final postsDocuments = await db.collection(postsCollection).get();
    final postsDto = postsDocuments.docs
        .map((doc) => PostDto.fromJson(doc.data()).getOrElse(
              () => throw Exception("Error getting post from json"),
            ))
        .toList();
    final posts = postsDto
        .map((postDto) => postDto.toDomainPost().getOrElse(
            () => throw Exception("Error converting post dto to domain post")))
        .toList();
    return right(posts);
  }

  @override
  Stream<List<Post>> get postsStream {
    final snapShots = db.collection(postsCollection).snapshots();
    final posts = snapShots.map(
      (snapshot) => snapshot.docs.map(
        (doc) {
          return PostDto.fromJson(doc.data())
              .getOrElse(
                () => throw Exception("Error getting post from json"),
              )
              .toDomainPost()
              .getOrElse(
                () =>
                    throw Exception("Error converting post dto to domain post"),
              );
        },
      ).toList(),
    );
    return posts;
  }
}
