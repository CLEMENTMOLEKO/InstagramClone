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
  userCancelledLogin,
  accountLocked,
  unexpectedError,
  invalidEmail,
  emailAlreadyInUse,
  weakPassword
}
