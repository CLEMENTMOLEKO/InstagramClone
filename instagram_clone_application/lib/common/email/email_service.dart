abstract class EmailService {
  /// Generates a random verification [code].
  int generateVerificationCode();

  /// Sends a verification code to the provided [email] address.
  /// Generates a random [code] and sends it to the [email] address.
  Future<void> sendVerificationCodeToEmail({
    required String email,
    required int code,
  });

  /// Verifies the provided [code] for the given [email] address.
  /// Returns `true` if the code is valid, `false` otherwise.
  Future<bool> verifyEmailWithCode({
    required String email,
    required int code,
  });
}
