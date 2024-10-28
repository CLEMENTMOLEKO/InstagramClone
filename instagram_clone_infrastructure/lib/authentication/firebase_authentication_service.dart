import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

@Injectable(as: AuthenticationService)
final class FirebaseAuthenticationService implements AuthenticationService {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  FirebaseAuthenticationService({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  @override
  Stream<User?> get user => firebaseAuth.authStateChanges();

  @override
  Future<Either<AuthFailure, Unit>> loginWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: emailAddress.value,
        password: password.value,
      );
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(_handleErrorCodes(code: e.code));
    }
  }

  @override
  Future<Either<AuthFailure, String>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    try {
      final registerResults = await firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress.value,
        password: password.value,
      );
      return right(registerResults.user!.uid);
    } on FirebaseAuthException catch (e) {
      return left(_handleErrorCodes(code: e.code));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount == null) return left(AuthFailure.userCancelledLogin);

    try {
      final googleAuth = await googleAccount.authentication;
      final ouAuthCredentials = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      await firebaseAuth.signInWithCredential(ouAuthCredentials);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(_handleErrorCodes(code: e.code));
    } on PlatformException {
      return left(AuthFailure.unexpectedError);
    }
  }

  // TODO: write tests.
  @override
  Future<Either<AuthFailure, bool>> userWithUsernameExists({
    required String username,
  }) {
    // TODO: user the database to check user collection if user with username exists
    return Future.value(right(false));
  }

  @override
  Future<void> signOut() async => await firebaseAuth.signOut();

  AuthFailure _handleErrorCodes({required String code}) {
    switch (code) {
      case "invalid-email":
      case "wrong-password":
      case "user-not-found":
        return AuthFailure.invalidPasswordAndEmailCombination;
      case "user-disabled":
        return AuthFailure.accountLocked;
      case "email-already-in-use":
        return AuthFailure.emailAlreadyInUse;
      case "weak-password":
        return AuthFailure.weakPassword;
      case "invalid-credential":
        return AuthFailure.invalidCredentials;
      default:
        return AuthFailure.unexpectedError;
    }
  }
}

/* TODO: SIGNINWITHGOOGLE
e.code = account-exists-with-different-credential:
Thrown if there already exists an account with the email address asserted by the credential.
Resolve this by calling [fetchSignInMethodsForEmail] and then asking the user to sign in using one of the returned providers.
Once the user is signed in, the original credential can be linked to the user with [linkWithCredential].
*/
