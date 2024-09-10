import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_infrastructure/user/firebase_user_repository.dart';
import 'package:instagram_clone_shared/instagram_clone_shared.dart';
import 'package:instagram_clone_shared/test_utils/constants/constants.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseFireStore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

class MockFirebaseException extends Mock implements FirebaseException {}

void main() {
  late UserRepository sut;
  late MockCollectionReference mockCollectionReference;
  late MockDocumentReference mockDocumentReference;
  late MockFirebaseFireStore mockFirebaseFirestore;
  late FirebaseException mockFirebaseException;
  late MockDocumentSnapshot mockDocumentSnapshot;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    mockFirebaseFirestore = MockFirebaseFireStore();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    mockFirebaseException = MockFirebaseException();
    mockDocumentSnapshot = MockDocumentSnapshot();
    sut = FirebaseUserRepository(firebaseFirestore: mockFirebaseFirestore);

    when(() => mockFirebaseFirestore.collection(any()))
        .thenReturn(mockCollectionReference);
    when(() => mockCollectionReference.doc(any()))
        .thenReturn(mockDocumentReference);
    when(() => mockDocumentReference.set(any())).thenAnswer((_) async => unit);
    when(() => mockDocumentReference.get())
        .thenAnswer((_) async => mockDocumentSnapshot);
  });

  Future<Either<ApplicationFailure, Unit>> callAddUser() async {
    return await sut.addUser(
        userModel: UserDtoConstants.userDto
            .toDomainUser()
            .getOrElse(() => throw Exception("Error creating user")));
  }

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
      final result = await callAddUser();
      //Assert
      expect(result, right(unit));
    });

    group("FirebaseException", () {
      setUp(() {
        when(
          () => mockDocumentReference.set(any()),
        ).thenThrow(mockFirebaseException);
      });
      test(
          "Should return [ApplcationFailure.permissionDenied] when code is permission denied",
          () async {
        //Arrange
        when(
          () => mockFirebaseException.code,
        ).thenReturn("permission-denied");
        //Act
        final result = await callAddUser();
        //Assert
        expect(result, left(ApplicationFailure.permissionDenied));
      });

      test(
          "Should return [ApplcationFailure.networkFailure] when code is unavailable",
          () async {
        //Arrange
        when(
          () => mockFirebaseException.code,
        ).thenReturn("unavailable");
        //Act
        final result = await callAddUser();
        //Assert
        expect(result, left(ApplicationFailure.networkFailure));
      });

      test(
          "Should return [ApplcationFailure.unexpected] when throws an exception",
          () async {
        //Arrange
        when(
          () => mockFirebaseException.code,
        ).thenReturn("random code");
        //Act
        final result = await callAddUser();
        //Assert
        expect(result, left(ApplicationFailure.unexpected));
      });
    });

    group("GetUser", () {
      test("Should return [UserModel] when get is successful", () async {
        //Arrange
        final userDataAsString =
            await JsonReader.readAsStringFrom(path: "user/user.json");
        final userData = json.decode(userDataAsString);
        when(
          () => mockDocumentSnapshot.exists,
        ).thenReturn(true);
        when(
          () => mockDocumentSnapshot.data(),
        ).thenReturn(userData);
        //Act
        final result = await sut.getUser(userId: Constants.validUuids.first);
        final userModel = result.getOrElse(
          () => throw Exception("Error gettng user"),
        );
        //Assert
        expect(result.isRight(), equals(true));
        expect(
          userModel,
          isA<UserModel>()
              .having(
                (e) => e.id.value,
                'id',
                equals(userData["id"]),
              )
              .having(
                (e) => e.emailAddress.value,
                "emailAddress",
                equals(userData['emailAddress']),
              ),
        );
      });

      test(
          "Should return [ApplicationFailure.errorGettingUser] when snapshot doesn't exist",
          () async {
        //Arrange
        when(
          () => mockDocumentSnapshot.exists,
        ).thenReturn(false);
        //Act
        final result = await sut.getUser(userId: Constants.validUuids.first);
        //Assert
        expect(result, left(ApplicationFailure.errorGettingUser));
      });
    });
  });
}
