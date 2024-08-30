import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_infrastructure/email/local_email_service.dart';
import 'package:instagram_clone_shared/instagram_clone_shared.dart';

void main() {
  late LocalEmailService sut;

  setUp(() {
    sut = LocalEmailService();
  });

  group('LocalEmailService', () {
    test('sendVerificationCodeToEmail should send email successfully',
        () async {
      await expectLater(
        sut.sendVerificationCodeToEmail(
          email: UserDtoConstants.validEmails.first,
          code: 123456,
        ),
        completes,
      );
    });

    test('sendVerificationCodeToEmail should throw for invalid email',
        () async {
      expect(
        () => sut.sendVerificationCodeToEmail(
          email: UserDtoConstants.invalidEmails.first,
          code: 123456,
        ),
        throwsA(isA<Exception>()),
      );
    },
        skip:
            true); //TODO: Find a wayt to mock smtp server otherwise this case can't be tested.

    test('generateVerificationCode should return a 6-digit code', () {
      final code = sut.generateVerificationCode();
      expect(code, greaterThanOrEqualTo(100000));
      expect(code, lessThanOrEqualTo(999999));
    });

    test('generateVerificationCode should return different codes', () {
      final code1 = sut.generateVerificationCode();
      final code2 = sut.generateVerificationCode();
      expect(code1, isNot(equals(code2)));
    });
  });
}
