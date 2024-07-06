enum ApplicationFailure {
  invalidPostData,
  invalidReplyData,
  invalidReelData,
  invalidCommentData,
  invalidUserData,
  errorGettingUser
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
