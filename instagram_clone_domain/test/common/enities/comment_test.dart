import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_domain/common/common.dart';

import '../../constants/constants.dart';

void main() {
  late Comment sut;
  const description = "Test comment";

  setUp(() {
    sut = CommentConstants.arrangeCommentWith(description: description);
  });

  test("Should implement equatable", () {
    //Arrange
    //Act
    //Assert
    expect(sut, isA<Equatable>());
  });

  test("Should be equal when two comments with same value are compared", () {
    //Arrange
    final comment =
        CommentConstants.arrangeCommentWith(description: description);
    //Act
    //Assert
    expect(sut, equals(comment));
  });

  test(
      "Should not be equal when two comments with different values are compared",
      () {
    //Arrange
    final comment = CommentConstants.arrangeCommentWith(
        description: "different value desctiption");
    //Act
    //Assert
    expect(sut, isNot(equals(comment)));
  });
}
