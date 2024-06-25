import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/common/common.dart';
import 'package:instagram_clone_application/reel/reel.dart';

import '../../test_utils/constants/constants.dart';
import '../../test_utils/json_reader.dart';

void main() {
  late ReelDto sut;
  const description = "This is the first reel on the platform period";

  setUp(() {
    sut = ReelDtoConstants.arrangeReelDtoWith(
      description: description,
      date: DateTime(2024, 12, 12),
    );
  });

  group(
    "ReelDto",
    () {
      test(
        "Should be equal when two reel dtos with the same values are compared",
        () {
          //Arrange
          final reelDto = ReelDtoConstants.arrangeReelDtoWith(
            description: description,
            date: DateTime(2024, 12, 12),
          );
          //Act
          //Assert
          expect(sut, equals(reelDto));
        },
      );
      test(
        "Should not be equal when two reel dtos with different values are compared",
        () {
          //Arrange
          final reelDto = ReelDtoConstants.arrangeReelDtoWith(
            description: "different description entirely",
            date: DateTime.now(),
          );
          //Act
          //Assert
          expect(sut, isNot(equals(reelDto)));
        },
      );

      group("fromJson", () {
        test("Should read reel data correctly when given valid reel data", () {
          //Arrange
          final reelDataAsString =
              JsonReader.readAsStringFrom(path: "reel/reel.json");
          final reelData = json.decode(reelDataAsString);
          //Act
          final result = ReelDto.fromJson(reelData);
          final reelDto = result
              .getOrElse(() => throw Exception("Conversion error $result"));
          //Assert
          expect(reelDto, isA<ReelDto>());
        });

        test("Should return failure with invalid data when data is invalid.",
            () {
          //Arrange
          final reelDataAsString =
              JsonReader.readAsStringFrom(path: "reel/reel_invalid.json");
          final reelData = json.decode(reelDataAsString);
          //Act
          final result = ReelDto.fromJson(reelData);
          //Assert
          expect(result, left(ApplicationFailure.invalidReelData));
        });

        test(
            "Should valid reel when lists are empty, no likes and no comments.",
            () {
          //Arrange
          final reelDataAsString =
              JsonReader.readAsStringFrom(path: "reel/reel_empty_lists.json");
          final reelData = json.decode(reelDataAsString);
          //Act
          final result = ReelDto.fromJson(reelData);
          final reelDto = result
              .getOrElse(() => throw Exception("Conversion error $result"));
          //Assert
          expect(reelDto, isA<ReelDto>());
        });
      });

      group("toJson", () {
        test("Should return correct map", () {
          //Arrange
          final reelDataAsString =
              JsonReader.readAsStringFrom(path: "reel/reel.json");
          final reelDataMap = json.decode(reelDataAsString);
          final reelData = ReelDto.fromJson(reelDataMap).getOrElse(
            () => throw Exception(
              "Invalid Comment data conversion on $reelDataMap",
            ),
          );
          //Act
          final result = reelData.toJson();
          //Assert
          expect(result, reelDataMap);
        });
      });
    },
  );
}
