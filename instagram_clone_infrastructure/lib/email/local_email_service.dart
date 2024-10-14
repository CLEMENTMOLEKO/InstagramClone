import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:uuid/uuid.dart';

import 'package:instagram_clone_application/instagram_clone_application.dart';

@LazySingleton(as: EmailService)
class LocalEmailService implements EmailService {
  @override
  Future<void> sendVerificationCodeToEmail({
    required int code,
    required String email,
  }) async {
    final smtpServer = gmail(
        'africantradingmarkets@gmail.com', '@123456'); // no longer compatible

    final message = Message()
      ..from =
          const Address('africantradingmarkets@gmail.com', 'Instagram Clone')
      ..recipients.add(email)
      ..subject = 'Email Verification Code'
      ..text = 'Your verification code is: $code';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. \n' + e.toString());
    }
  }

  @override
  int generateVerificationCode() {
    // this is not secure, but it is only for local testing
    final random = Random();
    final code = random.nextInt(900000) + 100000;
    return code;
  }
}
