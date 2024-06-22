import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_domain/post/post.dart';

import '../constants/constants.dart';

void main() {
  late Post sut;

  setUp(() {
    sut = PostConstants.arrangePostWith();
  });

  group("Post", () {
    test("Should extend equatable", () {
      //Arrange
      //Act
      //Assert
      expect(sut, isA<Equatable>());
    });

    test("Should be equal when two posts with same value are compared", () {
      //Arrange
      final postModel = PostConstants.arrangePostWith();
      final postModel2 = PostConstants.arrangePostWith();
      //Act
      //Assert
      expect(postModel, equals(postModel2));
    });

    test(
        "Should not be equal when two posts with different values are compared",
        () {
      //Arrange
      final postModel = PostConstants.arrangePostWith();
      final postModel2 = PostConstants.arrangePostWith(
          description: "this is a different description than default.`");
      //Act
      //Assert
      expect(postModel, isNot(equals(postModel2)));
    });
  });
}
