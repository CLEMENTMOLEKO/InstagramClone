import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/common/common.dart';
import 'package:instagram_clone_application/post/post.dart';

import '../../test_utils/constants/constants.dart';
import '../../test_utils/json_reader.dart';

void main() {
  late PostDto sut;
  const description = "This is the first post on the platform period";

  setUp(() {
    sut = PostDtoConstants.arrangePostDtoWith(
      description: description,
      date: DateTime(2024, 12, 12),
    );
  });

  group(
    "PostDto",
    () {
      test(
        "Should be equal when two post dtos with the same values are compared",
        () {
          //Arrange
          final postDto = PostDtoConstants.arrangePostDtoWith(
            description: description,
            date: DateTime(2024, 12, 12),
          );
          //Act
          //Assert
          expect(sut, equals(postDto));
        },
      );
      test(
        "Should not be equal when two post dtos with different values are compared",
        () {
          //Arrange
          final postDto = PostDtoConstants.arrangePostDtoWith(
            description: "different description entirely",
            date: DateTime.now(),
          );
          //Act
          //Assert
          expect(sut, isNot(equals(postDto)));
        },
      );

      group("fromJson", () {
        test("Should read post data correctly when given valid post data", () {
          //Arrange
          final postDataAsString =
              JsonReader.readAsStringFrom(path: "post/post.json");
          final postData = json.decode(postDataAsString);
          //Act
          final result = PostDto.fromJson(postData);
          final postDto = result
              .getOrElse(() => throw Exception("Conversion error $result"));
          //Assert
          expect(postDto, isA<PostDto>());
        });

        test("Should return failure with invalid data when data is invalid.",
            () {
          //Arrange
          final postDataAsString =
              JsonReader.readAsStringFrom(path: "post/post_invalid.json");
          final postData = json.decode(postDataAsString);
          //Act
          final result = PostDto.fromJson(postData);
          //Assert
          expect(result, left(ApplicationFailure.invalidPostData));
        });

        test(
            "Should valid post when lists are empty, no likes and no comments.",
            () {
          //Arrange
          final postDataAsString =
              JsonReader.readAsStringFrom(path: "post/post_empty_lists.json");
          final postData = json.decode(postDataAsString);
          //Act
          final result = PostDto.fromJson(postData);
          final postDto = result
              .getOrElse(() => throw Exception("Conversion error $result"));
          //Assert
          expect(postDto, isA<PostDto>());
        });
      });

      group("toJson", () {
        test("Should return correct map", () {
          //Arrange
          final postDataAsString =
              JsonReader.readAsStringFrom(path: "post/post.json");
          final postDataMap = json.decode(postDataAsString);
          final postData = PostDto.fromJson(postDataMap).getOrElse(
            () => throw Exception(
              "Invalid Comment data conversion on $postDataMap",
            ),
          );
          //Act
          final result = postData.toJson();
          //Assert
          expect(result, postDataMap);
        });
      });
    },
  );
}
