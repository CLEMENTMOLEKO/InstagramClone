enum ApplicationFailure {
  invalidPostData,
  invalidReplyData,
  invalidReelData,
  invalidCommentData,
  invalidUserData,
  errorGettingUser,
  permissionDenied,
  networkFailure,
  unexpected,
  errorGettingPost,
  errorCreatingPost,
  errorGettingPosts,
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
