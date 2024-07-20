import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_shared/instagram_clone_shared.dart';

void main() {
  test(
    "Should be equal when two [Authenticated] states are compared",
    () {
      //Arrange
      final userDto = UserDtoConstants.userDto;
      final userModel = userDto
          .toDomainUser()
          .getOrElse(() => throw Exception("Error Converting To Domain User"));
      //Act
      //Assert
      expect(Authenticated(user: userModel), Authenticated(user: userModel));
    },
  );

  test(
    "Should be equal when two [UnkownAuthentication] states are compared",
    () {
      //Arrange
      //Act
      //Assert
      expect(UnkownAuthentication(), UnkownAuthentication());
    },
  );

  test(
    "Should be equal when two [AuthenticationFailed] states are compared",
    () {
      //Arrange
      //Act
      //Assert
      expect(
        AuthenticationFailed(failure: ApplicationFailure.errorGettingUser),
        AuthenticationFailed(failure: ApplicationFailure.errorGettingUser),
      );
    },
  );

  test(
    "Should be equal when two [UnAuthenticated] states are compared",
    () {
      //Arrange
      //Act
      //Assert
      expect(UnAuthenticated(), UnAuthenticated());
    },
  );

  test(
    "Should not be equal when two different states are compared",
    () {
      //Arrange
      final userDto = UserDtoConstants.userDto;
      final userModel = userDto
          .toDomainUser()
          .getOrElse(() => throw Exception("Error Converting To Domain User"));
      //Act
      //Assert
      expect(Authenticated(user: userModel), isNot(equals(UnAuthenticated())));
    },
  );
}
