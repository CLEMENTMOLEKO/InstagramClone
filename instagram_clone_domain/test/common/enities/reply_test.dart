import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_domain/common/common.dart';

import '../../constants/constants.dart';

void main() {
  late Reply sut;
  const description = "Test description";
  final date = DateTime.now();
  setUp(() {
    sut = Reply(
      id: Constants.validUuids.first,
      userId: UserConstants.userId,
      description: description,
      date: date,
    );
  });

  test("Should implement equatable", () {
    //Arrange
    //Act
    //Assert
    expect(sut, isA<Equatable>());
  });

  test("Should be equal when two replies with same values are compared", () {
    //Arrange
    final reply = Reply(
        id: Constants.validUuids.first,
        userId: UserConstants.userId,
        description: description,
        date: date);
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
      description: "Different description",
      date: DateTime.now(),
    );
    //Act
    //Assert
    expect(sut, isNot(equals(reply)));
  });
}
