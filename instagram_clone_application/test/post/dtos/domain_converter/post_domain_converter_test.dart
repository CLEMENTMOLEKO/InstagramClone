import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/common/common.dart';
import 'package:instagram_clone_application/post/post.dart';
import 'package:instagram_clone_domain/instagram_clone_domain.dart';
import 'package:instagram_clone_shared/instagram_clone_shared.dart';

void main() {
  late PostDto sut;

  setUp(() {
    sut = PostDtoConstants.postDto;
  });

  group(
    "toDomainPost",
    () {
      test("Should return valid domain post when it has valid values", () {
        //Arrange
        //Act
        final result = sut.toDomainPost().getOrElse(
              () => throw Exception("Error converting to domain post"),
            );
        //Assert
        expect(result, isA<Post>());
      });

      test("Should return failure when it has invalid values", () {
        //Arrange
        final postDto = PostDtoConstants.arrangePostDtoWith(
          description: "Test invalid post",
          id: Constants.invalidUuids.first,
          userId: Constants.invalidUuids.last,
        );
        //Act
        final result = postDto.toDomainPost();
        //Assert
        expect(result, left(ApplicationFailure.invalidPostData));
      });
    },
  );

  group("fromDomainPost", () {
    test("Should return postDto", () {
      //Arrange
      final domainPost = PostDtoConstants.postDto
          .toDomainPost()
          .getOrElse(() => throw Exception("Post Conversion To Domain Error."));
      //Act
      final result = PostDtoDomainConverter.fromDomainPost(post: domainPost);
      //Assert
      expect(result, equals(PostDtoConstants.postDto));
    });
  });
}
