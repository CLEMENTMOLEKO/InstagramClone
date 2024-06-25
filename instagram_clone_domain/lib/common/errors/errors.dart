enum DomainFailure {
  invalidEmail,
  invalidPassword,
  invalidUserId,
  invalidPostId,
  invalidReelId,
  invalidReplyId,
  invalidCommentId,
  invalidCommentData,
}

extension FailureDescription on DomainFailure {
  String get description {
    switch (this) {
      case DomainFailure.invalidEmail:
        return "Invalid Email Address";
      case DomainFailure.invalidPassword:
        return "Invalid Password";
      case DomainFailure.invalidUserId:
        return "Invalid user id";
      case DomainFailure.invalidPostId:
        return "Invalid post id";
      case DomainFailure.invalidReelId:
        return "Invalid reel id";
      case DomainFailure.invalidCommentId:
        return "Invalid comment id";
      case DomainFailure.invalidCommentData:
        return "Invalid Comment Data";
      case DomainFailure.invalidReplyId:
        return "Invalid Reply Id";
    }
  }
}
