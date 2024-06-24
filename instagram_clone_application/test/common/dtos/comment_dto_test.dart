import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/common/common.dart';
import '../../test_utils/constants/constants.dart';
import '../../test_utils/json_reader.dart';

void main() {
  late CommentDto postCommentDto;
  late CommentDto reelCommentDto;
  const description = "This is the first comment in the app";
  const baseFileUrl = "./test/test_utils/json/comment/";

  setUp(() {
    postCommentDto = CommentDtoConstants.arrangePostCommentDtowith(
      description: description,
      date: DateTime(2024, 12, 12),
    );
    reelCommentDto = CommentDtoConstants.arrangeReelCommentDtowith(
      description: description,
      date: DateTime(2024, 12, 12),
    );
  });

  group("CommentDto", () {
    group("Post Comment", () {
      test("Two post CommentDtos with the same values should be equal", () {
        //Arrange
        final commentDto = CommentDtoConstants.arrangePostCommentDtowith(
          description: description,
          date: DateTime(2024, 12, 12),
        );
        //Act
        //Assert
        expect(postCommentDto, equals(commentDto));
      });

      test("Two post commentDtos with different values should not be equal",
          () {
        //Arrange
        final commentDto = CommentDtoConstants.postCommentDto;
        //Act
        //Assert
        expect(postCommentDto, isNot(equals(commentDto)));
      });

      group("fromJson", () {
        test("Should read post data correctly when data is a post", () {
          //Arrange
          final postDataAsString = JsonReader.readAsStringFrom(
              path: "${baseFileUrl}comment_post.json");
          final postData = json.decode(postDataAsString);
          //Act
          final result = CommentDto.fromJson(postData);
          final commentDto = result
              .getOrElse(() => throw Exception("Conversion error $result"));
          //Assert
          expect(commentDto, isA<CommentDto>());
        });

        test("Should read reel data correctly when data is a reel", () {
          //Arrange
          final reelDataAsString = JsonReader.readAsStringFrom(
              path: "${baseFileUrl}comment_reel.json");
          final reelData = json.decode(reelDataAsString);
          //Act
          final result = CommentDto.fromJson(reelData);
          final commentDto = result
              .getOrElse(() => throw Exception("Conversion error $result"));
          //Assert
          expect(commentDto, isA<CommentDto>());
        });

        test("Should return failure with invalid data when data is invalid.",
            () {
          //Arrange
          final reelDataAsString = JsonReader.readAsStringFrom(
              path: "${baseFileUrl}comment_invalid.json");
          final reelData = json.decode(reelDataAsString);
          //Act
          final result = CommentDto.fromJson(reelData);
          //Assert
          expect(result, left(Failure.invalidCommentData));
        });

        test(
            "Should valid comment when lists are empty, no likes and no replies.",
            () {
          //Arrange
          final reelDataAsString = JsonReader.readAsStringFrom(
              path: "${baseFileUrl}comment_post_empty_lists.json");
          final reelData = json.decode(reelDataAsString);
          //Act
          final result = CommentDto.fromJson(reelData);
          final commentDto = result
              .getOrElse(() => throw Exception("Conversion error $result"));
          //Assert
          expect(commentDto, isA<CommentDto>());
        });
      });
    });
    group("Reel Comment", () {
      test("Two reel CommentDtos with the same values should be equal", () {
        //Arrange
        final commentDto = CommentDtoConstants.arrangeReelCommentDtowith(
          description: description,
          date: DateTime(2024, 12, 12),
        );
        //Act
        //Assert
        expect(reelCommentDto, equals(commentDto));
      });

      test("Two reel commentDtos with different values should not be equal",
          () {
        //Arrange
        final commentDto = CommentDtoConstants.reelCommentDto;
        //Act
        //Assert
        expect(reelCommentDto, isNot(equals(commentDto)));
      });
    });
  });
}
