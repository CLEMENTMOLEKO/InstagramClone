part of "constants.dart";

extension ReelConstants on Constants {
  static arrangeReelWith({
    String? description = "This is my first social media post",
  }) =>
      Reel.createReel(
        id: arrangeReelId(reelId: Constants.validUuids.first),
        userId: UserConstants.userId,
        videoUrl: "https://www.firebase.com/videos/93fghwefg8h",
        thumbnailUrl: "https://www.firebase.com/videos/93fghwefg8h",
        likes: Constants.likes,
        description: description!,
        date: DateTime(2024, 12, 12),
      ).getOrElse(() => throw Exception("Error creating Reel"));

  static final reelId =
      arrangeReelId(reelId: '6c84fB90-12c4-11e1-840d-7b25c5ee775a');

  static ReelId arrangeReelId({required String reelId}) {
    final reelIdResults = ReelId.create(value: reelId);
    return reelIdResults
        .getOrElse(() => throw Exception("Invalid User Id $reelId"));
  }
}
