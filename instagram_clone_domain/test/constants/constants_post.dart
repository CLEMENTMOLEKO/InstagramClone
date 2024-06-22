part of "constants.dart";

extension PostConstants on Constants {
  static arrangePostWith({
    description = "This is my first social media post",
  }) =>
      Post(
        id: arrangePostId(postId: Constants.validUuids.first),
        userId: UserConstants.userId,
        description: description,
        imageUrls: const [
          "www.firebase.images/oweifjwf8weflwe89235j",
          "www.firebase.images/2oweifjwf8weflwe89235j",
        ],
        likes: Constants.likes,
      );

  static final postId =
      arrangePostId(postId: '6c84fB90-12c4-11e1-840d-7b25c5ee775a');

  static PostId arrangePostId({required String postId}) {
    final postIdResults = PostId.create(value: postId);
    return postIdResults
        .getOrElse(() => throw Exception("Invalid User Id $postId"));
  }
}
