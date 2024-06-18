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
    const testExample1Email = 'test1@example.com';
    const testExample2Email = 'test2@example.com';
    const invalidEmail = 'testeamil.com@com';

    group("Create", () {
      test("Should return an email address when provided a valid email address",
          () {
        //Arrange
        //Act
        final result = EmailAddress.create(email: testExample2Email);
        //Assert
        expect(result, Right(arrangeEmailAddress(email: testExample2Email)));
      });
      test("Should return failure when provided an invalid email address", () {
        //Arrange
        //Act
        final result = EmailAddress.create(email: invalidEmail);
        //Assert
        expect(result, const Left(Failure.invalidEmail));
      });
    });
    test('should implement ValueObject', () {
      //Arrange
      //Act
      final email = arrangeEmailAddress();
      //Assert
      expect(email, isA<ValueObject>());
    });

    test('should be equal if two EmailAddress instances have the same value',
        () {
      //Arrange
      //Act
      final email1 = arrangeEmailAddress();
      final email2 = arrangeEmailAddress();
      //Assert
      expect(email1, equals(email2));
    });

    test(
        'should not be equal if two EmailAddress instances have different values',
        () {
      //Arrange
      //Act
      final email1 = arrangeEmailAddress(email: testExample1Email);
      final email2 = arrangeEmailAddress(email: testExample2Email);
      //Assert
      expect(email1, isNot(equals(email2)));
    });
  });
}
