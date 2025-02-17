import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_infrastructure/instagram_clone_infrastructure.dart';
import 'package:instagram_clone_domain/instagram_clone_domain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockDocumentReference<T> extends Mock implements DocumentReference<T> {}

class MockCollectionReference<T> extends Mock
    implements CollectionReference<T> {}

void main() {
  late FirebasePostRepository repository;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;

  setUp(() {
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockDocumentReference = MockDocumentReference<Map<String, dynamic>>();
    mockCollectionReference = MockCollectionReference<Map<String, dynamic>>();
    repository = FirebasePostRepository(db: mockFirebaseFirestore);
  });

  group("createPost", () {
    final postResult = Post.createPost(
      id: PostId.createUnique(),
      userId: UserId.createUnique(),
      description: "Test post",
      date: DateTime.now(),
    );
    final post =
        postResult.getOrElse(() => throw Exception("Error creating post"));
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
}
