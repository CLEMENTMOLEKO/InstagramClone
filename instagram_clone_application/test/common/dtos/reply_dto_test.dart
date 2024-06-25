import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

import '../../test_utils/constants/constants.dart';
import '../../test_utils/json_reader.dart';

void main() {
  late ReplyDto sut;
  const description = "You lying this is not production environment";
  final date = DateTime(2024, 24, 24);

  setUp(() {
    sut = CommentDtoConstants.arrangeReplyDto(
      description: description,
      date: date,
    );
  });

  group("ReplyDto", () {
    test(
      "Should be equal when two ReplyDtos with same values are compared",
      () {
        //Arrange
        final replyDto = CommentDtoConstants.arrangeReplyDto(
          description: description,
          date: DateTime(2024, 24, 24),
        );
        //Act
        //Assert
        expect(sut, equals(replyDto));
      },
    );

    test(
      "Should not be equal when two ReplyDtos with different values are compared",
      () {
        //Arrange
        final replyDto = CommentDtoConstants.arrangeReplyDto(
            description: "Different value with DateTime now.");
        //Act
        //Assert
        expect(sut, isNot(equals(replyDto)));
      },
    );

    group(
      "fromJson",
      () {
        test(
          "Should return valid ReplyDto given valid data",
          () {
            //Arrange
            final replyDtoAsString =
                JsonReader.readAsStringFrom(path: "reply/reply.json");
            final replyDtoMap = json.decode(replyDtoAsString);
            //Act
            final result = ReplyDto.fromJson(replyDtoMap).getOrElse(
              () => throw Exception("Invalid ReplyDto data."),
            );
            //Assert
            expect(result, isA<ReplyDto>());
          },
        );
        test(
          "Should return Failure invalidReplyData given invalid data",
          () {
            //Arrange
            final replyDtoAsString =
                JsonReader.readAsStringFrom(path: "reply/reply_invalid.json");
            final replyDtoMap = json.decode(replyDtoAsString);
            //Act
            final result = ReplyDto.fromJson(replyDtoMap);
            //Assert
            expect(result, left(ApplicationFailure.invalidReplyData));
          },
        );
      },
    );

    group("toJson", () {
      test("Should return valid map", () {
        //Arrange
        final replyDataAsString =
            JsonReader.readAsStringFrom(path: "reply/reply.json");
        final replyDataMap = json.decode(replyDataAsString);
        final replyData = ReplyDto.fromJson(replyDataMap).getOrElse(
          () => throw Exception(
            "Invalid reply data conversion on $replyDataMap",
          ),
        );
        //Act
        final result = replyData.toJson();
        //Assert
        expect(result, replyDataMap);
      });
    });
  });
}
