part of 'constants.dart';

extension UserDtoConstants on Constants {
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

  static EmailAddress arrangeEmailAddress({email = 'test1@example.com'}) {
    return EmailAddress.create(email: email)
        .getOrElse(() => throw Exception('Invalid email $email'));
  }

  static Password arrangePassword({String password = "P@ssword123"}) {
    final passwordResult = Password.create(password: password);
    return passwordResult
        .getOrElse(() => throw Exception("Invalid Password $password"));
  }

  static final userDto = UserDto(
    id: Constants.validUuids.first,
    userName: "Clement Moleko",
    emailAddress: "bafanaskosana6@gmail.com",
    avatarUrl: "https://www.firebase.com/avatars/23044iwoefy8923",
    bio:
        "My name is Clement I'm a software developer, who like to build good stuff.",
    joined: DateTime.now(),
  );

  static UserDto arrangeUserDtoWith({
    required String bio,
    String? id,
    DateTime? joined,
    emailAddress = "bafanaskosana6@gmail.com",
    userName = "Clement Moleko",
  }) {
    return UserDto(
      id: id ?? Constants.validUuids.first,
      userName: userName,
      emailAddress: emailAddress,
      avatarUrl: "https://www.firebase.com/avatars/293847ower238fj",
      bio: bio,
      joined: joined ?? DateTime.now(),
    );
  }
}
