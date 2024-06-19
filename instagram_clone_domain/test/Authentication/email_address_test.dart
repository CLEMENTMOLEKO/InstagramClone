import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_domain/Authentication/Errors/failure.dart';
import 'package:instagram_clone_domain/Authentication/email_address.dart';
import 'package:instagram_clone_domain/Models/value_object.dart';

void main() {
  EmailAddress arrangeEmailAddress({email = 'test1@example.com'}) {
    return EmailAddress.create(email: email)
        .getOrElse(() => throw Exception('Invalid email $email'));
  }

  group('EmailAddress', () {
    const validEmails = {
      'test1@example.com',
      "user+mailbox/department=shipping@example.com",
      "customer/department=shipping@example.com",
      "user.name+tag+sorting@example.com",
      "x@example.com",
    };

    const invalidEmails = {
      "testeamil.com@com",
      "@missinglocalpart.com",
      "username@.com",
      "username@domain..com",
      "username@domain.com."
    };

    group("Create", () {
      for (var validEmail in validEmails) {
        test(
            "Should return an email address when provided a valid email address",
            () {
          //Arrange
          final email = arrangeEmailAddress(email: validEmail);
          //Act
          final result = EmailAddress.create(email: validEmail);
          //Assert
          expect(result, Right(email));
        });
      }

      for (var invalidEmail in invalidEmails) {
        test("Should return failure when provided an invalid email address",
            () {
          //Arrange
          //Act
          final result = EmailAddress.create(email: invalidEmail);
          //Assert
          expect(result, const Left(Failure.invalidEmail));
        });
      }
    });
    test('Should implement ValueObject', () {
      //Arrange
      //Act
      final email = arrangeEmailAddress();
      //Assert
      expect(email, isA<ValueObject>());
    });

    test('Should be equal if two EmailAddress instances have the same value',
        () {
      //Arrange
      //Act
      final email1 = arrangeEmailAddress(email: validEmails.last);
      final email2 = arrangeEmailAddress(email: validEmails.last);
      //Assert
      expect(email1, equals(email2));
    });

    test(
        'Should not be equal if two EmailAddress instances have different values',
        () {
      //Arrange
      //Act
      final email1 = arrangeEmailAddress(email: validEmails.first);
      final email2 = arrangeEmailAddress(email: validEmails.elementAt(3));
      //Assert
      expect(email1, isNot(equals(email2)));
    });
  });
}
