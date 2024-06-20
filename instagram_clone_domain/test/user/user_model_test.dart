import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_domain/user/user.dart';

import '../constants/constants.dart';

void main() {
  late UserModel sut;
  setUp(() {
    sut = UserModel(
      id: "user-guid-id",
      userName: "test-user",
      bio: "test bio",
      imageUrl: "https://www.test.com",
      emailAddress: UserConstants.arrangeEmailAddress(),
    );
  });
  group("UserModel", () {
    test("Should extend equatable", () {
      expect(sut, isA<Equatable>());
    });

    test("Should be equal when two users with same value are compared", () {
      //Arrange
      final userModel = UserConstants.arrangeUserModelWith();
      final userModel2 = UserConstants.arrangeUserModelWith();
      //Act
      //Assert
      expect(userModel, equals(userModel2));
    });

    test(
        "Should not be equal when two users with different values are compared",
        () {
      //Arrange
      final userModel = UserConstants.arrangeUserModelWith();
      final userModel2 = UserConstants.arrangeUserModelWith(userName: "Sarah");
      //Act
      //Assert
      expect(userModel, isNot(equals(userModel2)));
    });
  });
}
