import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_domain/reel/reel.dart';

import '../constants/constants.dart';

void main() {
  late Reel sut;

  setUp(() {
    sut = ReelConstants.arrangeReelWith();
  });

  group("Reel", () {
    test("Should extend equatable", () {
      //Arrange
      //Act
      //Assert
      expect(sut, isA<Equatable>());
    });

    test("Should be equal when two posts with same value are compared", () {
      //Arrange
      final reelModel = ReelConstants.arrangeReelWith();
      final reelModel2 = ReelConstants.arrangeReelWith();
      //Act
      //Assert
      expect(reelModel, equals(reelModel2));
    });

    test(
        "Should not be equal when two posts with different values are compared",
        () {
      //Arrange
      final reelModel = ReelConstants.arrangeReelWith();
      final reelModel2 = ReelConstants.arrangeReelWith(
          description: "this is a different description than default.`");
      //Act
      //Assert
      expect(reelModel, isNot(equals(reelModel2)));
    });

    group("CreateReel", () {
      test("Should return Reel when given valid reel values", () {
        //Arrange
        //Act
        final createReelResult = Reel.createReel(
          id: ReelConstants.reelId,
          userId: UserConstants.userId,
          description: "Test post is returning correct values",
          date: DateTime(2024, 12, 12),
          likes: Constants.likes,
          videoUrl: "www.firebase.com/videos/w80943508fh",
          thumbnailUrl: "www.firebase.com/thumbnails/woefhwioi3",
          comments: List.generate(
            4,
            (index) => CommentConstants.arrangePostCommentWith(
                description: "This is a test comment $index"),
          ),
        );
        final result = createReelResult
            .getOrElse(() => throw Exception("Error creating post"));
        //Assert
        expect(result, isA<Reel>());
      });
    });
  });
}
