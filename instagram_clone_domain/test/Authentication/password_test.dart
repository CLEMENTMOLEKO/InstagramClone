import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_domain/Authentication/Errors/failure.dart';
import 'package:instagram_clone_domain/Authentication/password.dart';
import 'package:instagram_clone_domain/Models/value_object.dart';

void main() {
  Password getPassword({required String password}) {
    final passwordResult = Password.create(password: password);
    return passwordResult
        .getOrElse(() => throw Exception("Invalid Password $password"));
  }

  group("Password", () {
    const validPasswords = {
      "P@ssword123",
      "12#%*hsjwweP",
      "Pass()09-+=",
      "_%^Pass123f-23a"
    };
    const invalidPasswords = {
      "Password1234",
      "testpassword*()",
      "testeloawercaseonly890%()",
      "testNoNumberInPassword*&(@)",
      "TESTNOLOWERCASE*(*&908)"
    };
    group("Create", () {
      for (var validPassword in validPasswords) {
        test("Should return Password when given valid password", () {
          //Arrange
          final password = getPassword(password: validPassword);
          //Act
          final result = Password.create(password: validPassword);
          //Assert
          expect(result, right(password));
        });
      }

      for (var invalidPassword in invalidPasswords) {
        test("Should return Failure when given invalid password", () {
          //Arrange
          //Act
          final result = Password.create(password: invalidPassword);
          //Assert
          expect(result, left(Failure.invalidPassword));
        });
      }
    });

    test('Should implement ValueObject', () {
      //Arrange
      //Act
      final email = getPassword(password: validPasswords.elementAt(2));
      //Assert
      expect(email, isA<ValueObject>());
    });

    test('Should be equal if two EmailAddress instances have the same value',
        () {
      //Arrange
      //Act
      final password3 = getPassword(password: validPasswords.elementAt(3));
      final password2 = getPassword(password: validPasswords.elementAt(3));
      //Assert
      expect(password3, equals(password2));
    });

    test(
        'Should not be equal if two EmailAddress instances have different values',
        () {
      //Arrange
      //Act
      final password1 = getPassword(password: validPasswords.elementAt(1));
      final passwrod2 = getPassword(password: validPasswords.elementAt(2));
      //Assert
      expect(password1, isNot(equals(passwrod2)));
    });
  });
}
