import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_domain/common/common.dart';
import 'package:instagram_clone_domain/reel/reel.dart';

import '../../constants/constants.dart';

void main() {
  group("ReelId", () {
    group("Create", () {
      for (var validReelId in Constants.validUuids) {
        test(
          "Should return a valid reel id when given a valid reel id string",
          () {
            //Arrange
            final reelId = ReelConstants.arrangeReelId(reelId: validReelId);
            //Act
            final reelIdResult = ReelId.create(value: validReelId);
            //Assert
            expect(reelIdResult, Right(reelId));
          },
        );
      }

      for (var invalidReelId in Constants.invalidUuids) {
        test(
          "Should return Failure when given a invalid reel id string",
          () {
            //Arrange
            //Act
            final reelIdResult = ReelId.create(value: invalidReelId);
            //Assert
            expect(reelIdResult, const Left(Failure.invalidReelId));
          },
        );
      }
    });

    test('Should implement ValueObject', () {
      //Arrange
      //Act
      final reelId = ReelConstants.reelId;
      //Assert
      expect(reelId, isA<ValueObject>());
    });

    test('Should be equal if two ReelId instances have the same value', () {
      //Arrange
      //Act
      final reelId = ReelConstants.arrangeReelId(
          reelId: Constants.validUuids.elementAt(3));
      final reelId2 = ReelConstants.arrangeReelId(
          reelId: Constants.validUuids.elementAt(3));
      //Assert
      expect(reelId, equals(reelId2));
    });

    test('Should not be equal if two ReelId instances have different values',
        () {
      //Arrange
      //Act
      final reelId = ReelConstants.arrangeReelId(
          reelId: Constants.validUuids.elementAt(1));
      final reelId2 = ReelConstants.arrangeReelId(
          reelId: Constants.validUuids.elementAt(3));
      //Assert
      expect(reelId, isNot(equals(reelId2)));
    });
  });
}
