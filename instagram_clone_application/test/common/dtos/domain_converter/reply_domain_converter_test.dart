import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/common/common.dart';
import 'package:instagram_clone_domain/instagram_clone_domain.dart';
import 'package:instagram_clone_shared/instagram_clone_shared.dart';

void main() {
  late ReplyDto sut;

  setUp(() {
    sut = CommentDtoConstants.arrangeReplyDto(
        description: "This is a test reply");
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
            final result = sut.toReplyDomain().getOrElse(
                  () => throw Exception("Error converting to domain reply"),
                );
            //Assert
            expect(result, isA<Reply>());
          });

          test("Should return failure when it has invalid values", () {
            //Arrange
            final replyDto = CommentDtoConstants.arrangeReplyDto(
                description: "Test description",
                userId: Constants.invalidUuids.first);
            final result = replyDto.toReplyDomain();
            //Assert
            expect(result, left(ApplicationFailure.invalidReplyData));
          });
        },
      );

      group("fromDomainReply", () {
        test("Should return reply dto from domain Reply", () {
          //Arrange
          final domainReply = CommentDtoConstants.replyDto
              .toReplyDomain()
              .getOrElse(
                  () => throw Exception("Error converting to reply domain"));
          //Act
          final result =
              ReplyDomainConverter.fromDomainReply(reply: domainReply);
          //Assert
          expect(result, CommentDtoConstants.replyDto);
        });
      });
    },
  );
}
