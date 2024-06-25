part of 'constants.dart';

extension PostDtoConstants on Constants {
  static final postDto = PostDto(
    id: Constants.validUuids.first,
    userId: Constants.validUuids.first,
    imageUrls: List.generate(
      3,
      (index) => "https://www.firebase.com/23044$index",
    ),
    likes: Constants.validUuids.toList(),
    description: "This is the first application comment.",
    date: DateTime.now(),
  );

  static PostDto arrangePostDtoWith({
    required String description,
    DateTime? date,
    int length = 3,
  }) {
    return PostDto(
      id: Constants.validUuids.first,
      userId: Constants.validUuids.first,
      imageUrls: List.generate(
        3,
        (index) => "https://www.firebase.com/images/293847$index",
      ),
      likes: Constants.validUuids.toList(),
      description: description,
      date: date ?? DateTime.now(),
    );
  }
}
