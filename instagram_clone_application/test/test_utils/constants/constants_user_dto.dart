part of 'constants.dart';

extension UserDtoConstants on Constants {
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
    DateTime? joined,
    emailAddress = "bafanaskosana6@gmail.com",
    userName = "Clement Moleko",
  }) {
    return UserDto(
      id: Constants.validUuids.first,
      userName: userName,
      emailAddress: emailAddress,
      avatarUrl: "https://www.firebase.com/avatars/293847ower238fj",
      bio: bio,
      joined: joined ?? DateTime.now(),
    );
  }
}
