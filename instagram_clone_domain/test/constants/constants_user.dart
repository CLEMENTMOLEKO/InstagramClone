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

  static arrangeUserModelWith({userName = "Bafana"}) => UserModel(
        id: "user-guid-id",
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
}
