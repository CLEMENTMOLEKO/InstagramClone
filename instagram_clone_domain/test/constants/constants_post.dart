part of "constants.dart";

extension PostConstants on Constants {
  static arrangePostWith({
    description = "This is my first social media post",
  }) =>
      Post(
        id: "post-guid-id",
        description: description,
        imageUrls: const [
          "www.firebase.images/oweifjwf8weflwe89235j",
          "www.firebase.images/2oweifjwf8weflwe89235j",
        ],
      );
}
