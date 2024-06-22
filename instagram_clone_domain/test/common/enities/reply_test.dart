import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_domain/common/entities/reply.dart';

import '../../constants/constants.dart';

void main() {
  late Reply sut;
  const description = "Test comment";

  setUp(() {
    sut = Reply(id: Constants.validUuids.first, userId: UserConstants.userId);
  });

  test("Should implement equatable", () {
    //Arrange
    //Act
    //Assert
    expect(sut, isA<Equatable>());
  });

  test("Should be equal when two replies with same values are compared", () {
    //Arrange
    final reply =
        Reply(id: Constants.validUuids.first, userId: UserConstants.userId);
    //Act
    //Assert
    expect(sut, equals(reply));
  });

  test(
      "Should not be equal when two replies with different values are compared",
      () {
    //Arrange
    final reply = Reply(
      id: Constants.validUuids.first,
      userId: UserConstants.arrangeUserId(userId: Constants.validUuids.last),
    );
    //Act
    //Assert
    expect(sut, isNot(equals(reply)));
  });
}
