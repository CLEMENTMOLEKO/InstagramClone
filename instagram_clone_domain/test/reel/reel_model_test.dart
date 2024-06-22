import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_domain/reel/reel.dart';

import '../constants/constants.dart';

void main() {
  late Reel sut;

  setUp(() {
    sut = ReelConstants.arrangeReelWith();
  });

  group("Reel", () {
    test("Should extend equatable", () {
      //Arrange
      //Act
      //Assert
      expect(sut, isA<Equatable>());
    });

    test("Should be equal when two posts with same value are compared", () {
      //Arrange
      final reelModel = ReelConstants.arrangeReelWith();
      final reelModel2 = ReelConstants.arrangeReelWith();
      //Act
      //Assert
      expect(reelModel, equals(reelModel2));
    });

    test(
        "Should not be equal when two posts with different values are compared",
        () {
      //Arrange
      final reelModel = ReelConstants.arrangeReelWith();
      final reelModel2 = ReelConstants.arrangeReelWith(
          description: "this is a different description than default.`");
      //Act
      //Assert
      expect(reelModel, isNot(equals(reelModel2)));
    });
  });
}
