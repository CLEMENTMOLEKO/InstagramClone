import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_infrastructure/instagram_clone_infrastructure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockDocumentReference<T> extends Mock implements DocumentReference<T> {}

class MockDocumentSnapshot<T> extends Mock implements DocumentSnapshot<T> {}

class MockQuerySnapshot<T> extends Mock implements QuerySnapshot<T> {}

class MockQueryDocumentSnapshot<T> extends Mock
    implements QueryDocumentSnapshot<T> {}

class MockCollectionReference<T> extends Mock
    implements CollectionReference<T> {}

void main() {
  late FirebasePostRepository repository;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockDocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot;
  late MockQuerySnapshot<Map<String, dynamic>> mockQuerySnapshot;
  late MockQueryDocumentSnapshot<Map<String, dynamic>>
      mockQueryDocumentSnapshot;

  setUp(() {
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockDocumentReference = MockDocumentReference<Map<String, dynamic>>();
    mockCollectionReference = MockCollectionReference<Map<String, dynamic>>();
    mockDocumentSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();
    mockQuerySnapshot = MockQuerySnapshot<Map<String, dynamic>>();
    mockQueryDocumentSnapshot =
        MockQueryDocumentSnapshot<Map<String, dynamic>>();
    repository = FirebasePostRepository(db: mockFirebaseFirestore);
  });
  final postResult = Post.createPost(
    id: PostId.createUnique(),
    userId: UserId.createUnique(),
    description: "Test post",
    date: DateTime.now(),
  );
  final post =
      postResult.getOrElse(() => throw Exception("Error creating post"));
  group("createPost", () {
    test("Should return right unit when createPost is successful", () async {
      when(() => mockFirebaseFirestore.collection(any())).thenReturn(
        mockCollectionReference,
      );
      when(() => mockCollectionReference.doc(any()))
          .thenReturn(mockDocumentReference);
      when(() => mockDocumentReference.set(any()))
          .thenAnswer((_) async => true);
      final result = await repository.createPost(post: post);
      expect(result, isA<Right>());
    });

    test("Should return left error when createPost fails", () async {
      when(() => mockFirebaseFirestore.collection(any()))
          .thenReturn(mockCollectionReference);
      when(() => mockCollectionReference.doc(any()))
          .thenReturn(mockDocumentReference);
      when(() => mockDocumentReference.set(any())).thenThrow(Exception());
      final result = await repository.createPost(post: post);
      expect(result, left(ApplicationFailure.errorCreatingPost));
    });
  });

  group("getPost", () {
    final post = Post.createPost(
      id: PostId.createUnique(),
      userId: UserId.createUnique(),
      description: "Test post",
      date: DateTime.now(),
    ).getOrElse(() => throw Exception("Error creating post"));

    test("Should return post when getPost is successful", () async {
      when(() => mockFirebaseFirestore.collection(any()))
          .thenReturn(mockCollectionReference);
      when(() => mockCollectionReference.doc(any()))
          .thenReturn(mockDocumentReference);
      when(() => mockDocumentReference.get())
          .thenAnswer((_) async => mockDocumentSnapshot);
      when(() => mockDocumentSnapshot.data()).thenReturn(
        PostDtoDomainConverter.fromDomainPost(post: post).toJson(),
      );
      final result = await repository.getPost(postId: post.id.value);
      expect(result, isA<Right>());
    });

    test("Should return left error when getPost fails", () async {
      when(() => mockFirebaseFirestore.collection(any()))
          .thenReturn(mockCollectionReference);
      when(() => mockCollectionReference.doc(any()))
          .thenReturn(mockDocumentReference);
      when(() => mockDocumentReference.get()).thenThrow(Exception());
      final result = await repository.getPost(postId: post.id.value);
      expect(result, left(ApplicationFailure.errorGettingPost));
    });
  });

  group("getPosts", () {
    test("Should return list of posts when getPosts is successful", () async {
      when(() => mockFirebaseFirestore.collection(any()))
          .thenReturn(mockCollectionReference);
      when(() => mockCollectionReference.get())
          .thenAnswer((_) async => mockQuerySnapshot);
      when(() => mockQuerySnapshot.docs)
          .thenReturn([mockQueryDocumentSnapshot]);
      when(() => mockQueryDocumentSnapshot.data()).thenReturn(
        PostDtoDomainConverter.fromDomainPost(post: post).toJson(),
      );
      final result = await repository.getPosts(limit: 10, offset: 0);
      expect(result, isA<Right>());
      expect(result.getOrElse(() => throw Exception("Error getting posts")),
          isA<List<Post>>());
    });

    test("Should return left error when getPosts fails", () async {
      when(() => mockFirebaseFirestore.collection(any()))
          .thenReturn(mockCollectionReference);
      when(() => mockCollectionReference.get()).thenThrow(Exception());
      final result = await repository.getPosts(limit: 10, offset: 0);
      expect(result, left(ApplicationFailure.errorGettingPosts));
    });
  });

  group("postsStream", () {
    test("Should return stream of posts when postsStream is called", () {
      when(() => mockFirebaseFirestore.collection(any()))
          .thenReturn(mockCollectionReference);
      when(() => mockCollectionReference.snapshots())
          .thenAnswer((_) => Stream.value(mockQuerySnapshot));
      when(() => mockQuerySnapshot.docs)
          .thenReturn([mockQueryDocumentSnapshot]);
      when(() => mockQueryDocumentSnapshot.data()).thenReturn(
        PostDtoDomainConverter.fromDomainPost(post: post).toJson(),
      );
      final result = repository.postsStream;
      expect(result, isA<Stream<List<Post>>>());
      result.listen((posts) {
        expect(posts, isA<List<Post>>());
      });
    });
  });
}
