import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/common/dtos/comment_dto.dart';
import 'package:instagram_clone_application/common/errors/failure.dart';
import 'package:instagram_clone_domain/instagram_clone_domain.dart';

import '../../../test_utils/constants/constants.dart';

void main() {
  late CommentDto sutReelCommentDto;
  late CommentDto sutPostCommentDto;

  setUp(() {
    sutPostCommentDto = CommentDtoConstants.postCommentDto;
    sutReelCommentDto = CommentDtoConstants.reelCommentDto;
  });

  group(
    "ReelCommentDto",
    () {
      group(
        "toDomainComment",
        () {
          test(
              "Should return valid domain comment dto when it has valid values",
              () {
            //Arrange
            //Act
            final result = sutReelCommentDto.toDomainComment().getOrElse(
                  () => throw Exception("Error converting to domain comment"),
                );
            //Assert
            expect(result, isA<Comment>());
          });

          test("Should return failure when it has invalid values", () {
            //Arrange
            final reelCommentDto =
                CommentDtoConstants.arrangeReelCommentDtowith(
              description: "test description",
              userId: Constants.invalidUuids.first,
              reelId: Constants.invalidUuids.last,
            );
            //Act
            final result = reelCommentDto.toDomainComment();
            //Assert
            expect(result, left(ApplicationFailure.invalidCommentData));
          });
        },
      );
    },
  );

  group(
    "PostCommentDto",
    () {
      group(
        "toDomainComment",
        () {
          test(
              "Should return valid domain comment dto when it has valid values",
              () {
            //Arrange
            //Act
            final result = sutPostCommentDto.toDomainComment().getOrElse(
                  () => throw Exception("Error converting to domain comment"),
                );
            //Assert
            expect(result, isA<Comment>());
          });

          test("Should return failure when it has invalid values", () {
            //Arrange
            final postCommentDto =
                CommentDtoConstants.arrangePostCommentDtowith(
              description: "test description",
              userId: Constants.invalidUuids.first,
              postId: Constants.invalidUuids.last,
            );
            //Act
            final result = postCommentDto.toDomainComment();
            //Assert
            expect(result, left(ApplicationFailure.invalidCommentData));
          });
        },
      );
    },
  );

  group("fromDomainComment", () {
    test("Should return reel comment when reeelId is not null", () {
      //Arrange
      final dommainComment = CommentDtoConstants.reelCommentDto
          .toDomainComment()
          .getOrElse(() => throw Exception("Conversion Error."));
      //Act
      final result =
          CommentDomainConverter.fromDomainComment(comment: dommainComment);
      //Assert
      expect(result, CommentDtoConstants.reelCommentDto);
    });

    test("Should return post comment when reeelId is null", () {
      //Arrange
      final dommainComment = CommentDtoConstants.postCommentDto
          .toDomainComment()
          .getOrElse(() => throw Exception("Conversion Error."));
      //Act
      final result =
          CommentDomainConverter.fromDomainComment(comment: dommainComment);
      //Assert
      expect(result, CommentDtoConstants.postCommentDto);
    });
  });
}
