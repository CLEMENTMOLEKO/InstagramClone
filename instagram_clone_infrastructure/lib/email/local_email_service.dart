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
    final smtpServer = gmail('africantradingmarkets@gmail.com', '@Bafana5');

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
    final uuid = Uuid();
    final uuidString = uuid.v4();
    var numbers = uuidString.replaceAll(RegExp(r'[^0-9]'), '');
    if (numbers.length < 6) numbers += "0";
    return int.parse(numbers.substring(0, 6));
  }
}
