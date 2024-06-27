import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/common/common.dart';
import 'package:instagram_clone_application/reel/reel.dart';
import 'package:instagram_clone_domain/instagram_clone_domain.dart';

import '../../../test_utils/constants/constants.dart';

void main() {
  late ReelDto sut;

  setUp(() {
    sut = ReelDtoConstants.reelDto;
  });

  group(
    "toDomainReel",
    () {
      test("Should return valid domain reel when it has valid values", () {
        //Arrange
        //Act
        final result = sut.toDomainReel().getOrElse(
              () => throw Exception("Error converting to domain reel"),
            );
        //Assert
        expect(result, isA<Reel>());
      });

      test("Should return failure when it has invalid values", () {
        //Arrange
        final reelDto = ReelDtoConstants.arrangeReelDtoWith(
          description: "Test invalid reel",
          reelId: Constants.invalidUuids.first,
          userId: Constants.invalidUuids.last,
        );
        //Act
        final result = reelDto.toDomainReel();
        //Assert
        expect(result, left(ApplicationFailure.invalidReelData));
      });
    },
  );

  group("fromDomainReel", () {
    test("Should return reelDto", () {
      //Arrange
      final domainReel = ReelDtoConstants.reelDto
          .toDomainReel()
          .getOrElse(() => throw Exception("Reel Conversion To Domain Error."));
      //Act
      final result = ReelDtoDomainConverter.fromDomainReel(reel: domainReel);
      //Assert
      expect(result, equals(ReelDtoConstants.reelDto));
    });
  });
}
