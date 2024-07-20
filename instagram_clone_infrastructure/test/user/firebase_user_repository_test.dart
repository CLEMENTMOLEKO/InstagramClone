import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_application/user/user_repository.dart';
import 'package:instagram_clone_infrastructure/user/firebase_user_repository.dart';
import 'package:instagram_clone_shared/test_utils/constants/constants.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseFireStore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

void main() {
  late UserRepository sut;
  late MockCollectionReference mockCollectionReference;
  late MockDocumentReference mockDocumentReference;
  late MockFirebaseFireStore mockFirebaseFirestore;

  setUp(() {
    mockFirebaseFirestore = MockFirebaseFireStore();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    sut = FirebaseUserRepository(firebaseFirestore: mockFirebaseFirestore);

    when(() => mockFirebaseFirestore.collection(any()))
        .thenReturn(mockCollectionReference);
    when(() => mockCollectionReference.doc(any()))
        .thenReturn(mockDocumentReference);
    when(() => mockDocumentReference.set(any())).thenAnswer((_) async => unit);
  });

  test("Should not require FirebaseFirestore when initialized", () {
    //Arrange
    //Act
    //Assert
    expect(
      () => FirebaseUserRepository(),
      throwsA(isA<FirebaseException>().having((e) => e.code, 'code', 'no-app')),
    ); //TODO: We getting errors when trying to initialize app on our tests/ this exception is throw to confirm it tries to call [FirebaseFirestore.instance]
  });

  group("AddUser", () {
    test("Should return [Unit] when addUser is successful", () async {
      //Arrange
      //Act
      final result = await sut.addUser(
          userModel: UserDtoConstants.userDto
              .toDomainUser()
              .getOrElse(() => throw Exception("Error creating user")));
      //Assert
      expect(result, right(unit));
    });
  });
}
