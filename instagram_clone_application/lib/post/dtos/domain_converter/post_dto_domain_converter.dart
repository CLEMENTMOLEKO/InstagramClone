part of '../post_dto.dart';

extension PostDtoDomainConverter on PostDto {
  Either<ApplicationFailure, Post> toDomainPost() {
    return _createDomainValues();
  }

  Either<ApplicationFailure, Post> _createDomainValues() {
    try {
      print("PostDto Id: ${this.id}");
      final postId = PostId.create(value: this.id)
          .getOrElse(() => throw Exception("Invalid PostId"));
      final userId = UserId.create(value: this.userId)
          .getOrElse(() => throw Exception("Invalid UserId"));
      final likes = this
          .likes
          .map((like) => UserId.create(value: like)
              .getOrElse(() => throw Exception("Invalid Like/UserId $like")))
          .toList();
      final comments = this
          .comments
          .map((commentDto) => commentDto.toDomainComment().getOrElse(() =>
              throw Exception("Invalid Domain Comment conversion $commentDto")))
          .toList();
      final createPostResult = Post.createPost(
        id: postId,
        userId: userId,
        description: description,
        date: date,
        imageUrls: imageUrls,
        likes: likes,
        comments: comments,
      );
      final domainPost = createPostResult
          .getOrElse(() => throw Exception("Error Creating Post"));
      return right(domainPost);
    } catch (e) {
      print("Error in _createDomainValues: $e");
      return left(ApplicationFailure.invalidPostData);
    }
  }

  static PostDto fromDomainPost({required Post post}) {
    return PostDto(
      id: post.id.value,
      userId: post.userId.value,
      description: post.description,
      imageUrls: post.imageUrls,
      date: post.date,
      likes: post.likes.map((like) => like.value).toList(),
      comments: post.comments
          .map((domainComment) =>
              CommentDomainConverter.fromDomainComment(comment: domainComment))
          .toList(),
    );
  }
}
