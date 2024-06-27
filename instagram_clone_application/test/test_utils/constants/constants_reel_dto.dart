part of 'constants.dart';

extension ReelDtoConstants on Constants {
  static final reelDto = ReelDto(
    id: Constants.validUuids.first,
    userId: Constants.validUuids.first,
    videoUrl: "https://www.firebase.com/2304434",
    likes: Constants.validUuids.toList(),
    description: "This is the first application comment.",
    date: DateTime.now(),
    thumbnailUrl: "https://www.firebase.com/thumbnails/23428943",
  );

  static ReelDto arrangeReelDtoWith({
    required String description,
    DateTime? date,
    int length = 3,
    String? reelId,
    String? userId,
  }) {
    return ReelDto(
      id: reelId ?? Constants.validUuids.first,
      userId: userId ?? Constants.validUuids.first,
      videoUrl: "https://www.firebase.com/images/2938472390",
      likes: Constants.validUuids.toList(),
      description: description,
      date: date ?? DateTime.now(),
      thumbnailUrl: "https://www.firebase.com/thumbnails/29384yehjrw89342",
    );
  }
}
