import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/common/common.dart';
import 'package:instagram_clone_application/user/user.dart';
import 'package:instagram_clone_domain/instagram_clone_domain.dart';
import 'package:instagram_clone_shared/instagram_clone_shared.dart';

void main() {
  late UserDto sut;

  setUp(() {
    sut = UserDtoConstants.userDto;
  });

  group(
    "toDomainUser",
    () {
      test("Should return valid domain post when it has valid values", () {
        //Arrange
        //Act
        final result = sut.toDomainUser().getOrElse(
              () => throw Exception("Error converting to domain post"),
            );
        //Assert
        expect(result, isA<UserModel>());
      });

      test("Should return failure when it has invalid values", () {
        //Arrange
        final userDto = UserDtoConstants.arrangeUserDtoWith(
          bio: "Test failure when invalid values",
          emailAddress: UserDtoConstants.invalidEmails.first,
          id: Constants.invalidUuids.first,
        );
        //Act
        final result = userDto.toDomainUser();
        //Assert
        expect(result, left(ApplicationFailure.invalidUserData));
      });
    },
  );

  group("fromDomainUser", () {
    test("Should return userDto", () {
      //Arrange
      final domainUser = UserDtoConstants.userDto.toDomainUser().getOrElse(
          () => throw Exception("UserModel Conversion To Domain Error."));
      //Act
      final result = UserDtoDomainConverter.fromDomainUser(user: domainUser);
      //Assert
      expect(result, equals(UserDtoConstants.userDto));
    });
  });
}
