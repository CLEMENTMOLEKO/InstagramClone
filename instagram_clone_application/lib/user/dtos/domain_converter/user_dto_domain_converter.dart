part of '../user_dto.dart';

extension UserDtoDomainConverter on UserDto {
  Either<ApplicationFailure, UserModel> toDomainUser() {
    return _createDomainValues();
  }

  Either<ApplicationFailure, UserModel> _createDomainValues() {
    try {
      final userId = UserId.create(value: this.id)
          .getOrElse(() => throw Exception("Invalid UserId"));
      final emailAddress = EmailAddress.create(email: this.emailAddress)
          .getOrElse(() => throw Exception("Invalid Email Address"));
      final createUserResult = UserModel.createUser(
        userId: userId,
        userName: userName,
        emailAddress: emailAddress,
        bio: bio,
        avatarUrl: avatarUrl,
        posts: posts
            .map((postId) => PostId.create(value: postId).getOrElse(
                () => throw Exception("Error Converting Post to domain")))
            .toList(),
        reels: posts
            .map((reelId) => ReelId.create(value: reelId).getOrElse(
                () => throw Exception("Error Converting Reel to domain")))
            .toList(),
        joined: joined,
      );
      final domainUser = createUserResult.getOrElse(
        () => throw Exception("Error get valid user"),
      );
      return right(domainUser);
    } catch (e) {
      return left(ApplicationFailure.invalidUserData);
    }
  }

  static UserDto fromDomainUser({required UserModel user}) {
    return UserDto(
      id: user.id.value,
      userName: user.userName,
      bio: user.bio,
      avatarUrl: user.avatarUrl,
      emailAddress: user.emailAddress.value,
      joined: user.joined,
    );
  }
}
