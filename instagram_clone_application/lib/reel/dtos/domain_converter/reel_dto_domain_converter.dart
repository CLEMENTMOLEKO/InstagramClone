part of '../reel_dto.dart';

extension ReelDtoDomainConverter on ReelDto {
  Either<ApplicationFailure, Reel> toDomainReel() {
    return _createDomainValues();
  }

  Either<ApplicationFailure, Reel> _createDomainValues() {
    try {
      final reelId = ReelId.create(value: this.id)
          .getOrElse(() => throw Exception("Invalid ReelId"));
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
      final createReelResult = Reel.createReel(
        id: reelId,
        userId: userId,
        description: description,
        date: date,
        videoUrl: videoUrl,
        thumbnailUrl: thumbnailUrl,
        likes: likes,
        comments: comments,
      );
      final domainReel = createReelResult
          .getOrElse(() => throw Exception("Error Creating Reel"));
      return right(domainReel);
    } catch (e) {
      return left(ApplicationFailure.invalidReelData);
    }
  }

  static ReelDto fromDomainReel({required Reel reel}) {
    return ReelDto(
      id: reel.id.value,
      userId: reel.userId.value,
      description: reel.description,
      videoUrl: reel.videoUrl,
      thumbnailUrl: reel.thumbnailUrl,
      date: reel.date,
      likes: reel.likes.map((like) => like.value).toList(),
      comments: reel.comments
          .map((domainComment) =>
              CommentDomainConverter.fromDomainComment(comment: domainComment))
          .toList(),
    );
  }
}
