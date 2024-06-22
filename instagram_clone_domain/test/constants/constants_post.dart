part of "constants.dart";

extension PostConstants on Constants {
  static arrangePostWith({
    description = "This is my first social media post",
  }) =>
      Post(
        id: "post-guid-id",
        userId: UserConstants.userId,
        description: description,
        imageUrls: const [
          "www.firebase.images/oweifjwf8weflwe89235j",
          "www.firebase.images/2oweifjwf8weflwe89235j",
        ],
        likes: Constants.likes,
      );

  static final postId =
      arrangePostId(userId: '6c84fB90-12c4-11e1-840d-7b25c5ee775a');

  static PostId arrangePostId({required String userId}) {
    final postIdResults = PostId.create(value: userId);
    return postIdResults
        .getOrElse(() => throw Exception("Invalid User Id $userId"));
  }
}
