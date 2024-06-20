enum Failure {
  invalidEmail,
  invalidPassword,
}

extension FailureDescription on Failure {
  String description() {
    switch (this) {
      case Failure.invalidEmail:
        return "Invalid Email Address";
      case Failure.invalidPassword:
        return "Invalid Password";
    }
  }
}
