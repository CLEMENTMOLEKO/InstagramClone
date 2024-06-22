part of 'constants.dart';

extension UserConstants on Constants {
  static const validEmails = {
    'test1@example.com',
    "user+mailbox/department=shipping@example.com",
    "customer/department=shipping@example.com",
    "user.name+tag+sorting@example.com",
    "x@example.com",
  };

  static const invalidEmails = {
    "testeamil.com@com",
    "@missinglocalpart.com",
    "username@.com",
    "username@domain..com",
    "username@domain.com."
  };

  static const validPasswords = {
    "P@ssword123",
    "12#%*hsjwweP",
    "Pass()09-+=",
    "_%^Pass123f-23a"
  };

  static const invalidPasswords = {
    "Password1234",
    "testpassword*()",
    "testeloawercaseonly890%()",
    "testNoNumberInPassword*&(@)",
    "TESTNOLOWERCASE*(*&908)"
  };

  static final userId =
      arrangeUserId(userId: '6c84fB90-12c4-11e1-840d-7b25c5ee775a');

  static arrangeUserModelWith({userName = "Bafana"}) => UserModel(
        id: userId,
        userName: userName,
        bio: "I'm a developer",
        imageUrl: "www.firebase.images/oweifjwf8weflwe89235j",
        emailAddress: arrangeEmailAddress(),
      );

  static EmailAddress arrangeEmailAddress({email = 'test1@example.com'}) {
    return EmailAddress.create(email: email)
        .getOrElse(() => throw Exception('Invalid email $email'));
  }

  static Password arrangePassword({required String password}) {
    final passwordResult = Password.create(password: password);
    return passwordResult
        .getOrElse(() => throw Exception("Invalid Password $password"));
  }

  static UserId arrangeUserId({required String userId}) {
    final userIdResults = UserId.create(value: userId);
    return userIdResults
        .getOrElse(() => throw Exception("Invalid User Id $userId"));
  }
}
