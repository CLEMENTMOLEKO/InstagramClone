enum ApplicationFailure {
  invalidPostData,
  invalidReplyData,
  invalidReelData,
  invalidCommentData,
  invalidUserData,
  errorGettingUser,
  permissionDenied,
  networkFailure,
  unexpected
}

enum AuthFailure {
  invalidPasswordAndEmailCombination,
  invalidCredentials,
  userCancelledLogin,
  accountLocked,
  unexpectedError,
  invalidEmail,
  emailAlreadyInUse,
  weakPassword
}
