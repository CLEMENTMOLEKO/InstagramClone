import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/common/common.dart';
import 'package:instagram_clone_application/user/user.dart';

import '../../test_utils/constants/constants.dart';
import '../../test_utils/json_reader.dart';

void main() {
  late UserDto sut;
  const bio =
      "I'm Clement a software developer and I like to build good stuff.";

  setUp(() {
    sut = UserDtoConstants.arrangeUserDtoWith(
      bio: bio,
      joined: DateTime(2024, 12, 12),
    );
  });

  group(
    "UserDto",
    () {
      test(
        "Should be equal when two user dtos with the same values are compared",
        () {
          //Arrange
          final userDto = UserDtoConstants.arrangeUserDtoWith(
            bio: bio,
            joined: DateTime(2024, 12, 12),
          );
          //Act
          //Assert
          expect(sut, equals(userDto));
        },
      );
      test(
        "Should not be equal when two user dtos with different values are compared",
        () {
          //Arrange
          final userDto = UserDtoConstants.arrangeUserDtoWith(
            bio: "different bio entirely",
            joined: DateTime.now(),
          );
          //Act
          //Assert
          expect(sut, isNot(equals(userDto)));
        },
      );

      group("fromJson", () {
        test("Should read user data correctly when given valid user data", () {
          //Arrange
          final userDataAsString =
              JsonReader.readAsStringFrom(path: "user/user.json");
          final userData = json.decode(userDataAsString);
          //Act
          final result = UserDto.fromJson(userData);
          final userDto = result
              .getOrElse(() => throw Exception("Conversion error $result"));
          //Assert
          expect(userDto, isA<UserDto>());
        });

        test("Should return failure with invalid data when data is invalid.",
            () {
          //Arrange
          final userDataAsString =
              JsonReader.readAsStringFrom(path: "user/user_invalid.json");
          final userData = json.decode(userDataAsString);
          //Act
          final result = UserDto.fromJson(userData);
          //Assert
          expect(result, left(ApplicationFailure.invalidUserData));
        });

        test("Should valid user when lists are empty, no posts and no reels.",
            () {
          //Arrange
          final userDataAsString =
              JsonReader.readAsStringFrom(path: "user/user_empty_lists.json");
          final userData = json.decode(userDataAsString);
          //Act
          final result = UserDto.fromJson(userData);
          final userDto = result
              .getOrElse(() => throw Exception("Conversion error $result"));
          //Assert
          expect(userDto, isA<UserDto>());
        });
      });

      group("toJson", () {
        test("Should return correct map", () {
          //Arrange
          final userDataAsString =
              JsonReader.readAsStringFrom(path: "user/user.json");
          final postDataMap = json.decode(userDataAsString);
          final userData = UserDto.fromJson(postDataMap).getOrElse(
            () => throw Exception(
              "Invalid Comment data conversion on $postDataMap",
            ),
          );
          //Act
          final result = userData.toJson();
          //Assert
          expect(result, postDataMap);
        });
      });
    },
  );
}
