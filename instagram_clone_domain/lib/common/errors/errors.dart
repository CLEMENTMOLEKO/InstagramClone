enum Failure {
  invalidEmail,
  invalidPassword,
  invalidUserId,
  invalidPostId,
}

extension FailureDescription on Failure {
  String get description {
    switch (this) {
      case Failure.invalidEmail:
        return "Invalid Email Address";
      case Failure.invalidPassword:
        return "Invalid Password";
      case Failure.invalidUserId:
        return "Invalid user id";
      case Failure.invalidPostId:
        return "Invalid post id";
    }
  }
}
