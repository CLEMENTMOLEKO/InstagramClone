import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_domain/instagram_clone_domain.dart';

import '../common/common.dart';

abstract class AuthenticationService {
  /// [AuthenticationService.user] Returns a stream to listen to of user as authentication states changes
  /// stream returns user if authenitcation or null if not.
  Stream<User?> get user;

  /// [registerWithEmailAndPassword] returns either an [AuthFailure] or [String] (Uid)
  /// returns [String] (Uid) if registration was successful and [AuthFailure] if not.
  Future<Either<AuthFailure, String>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  /// [loginWithEmailAndPassword] returns either an [AuthFailure] or [Unit]
  /// returns [Unit] if login was successful and [AuthFailure] if not.
  Future<Either<AuthFailure, Unit>> loginWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  /// [signInWithGoogle] returns either an [AuthFailure] or [Unit]
  /// returns [Unit] if login was successful and [AuthFailure] if not.
  Future<Either<AuthFailure, Unit>> signInWithGoogle();

  /// [userWithUsernameExists] returns either a [bool] if successfully checked for existing user with [username]
  /// or [AuthFailure] if there was an error checking for user with [username]
  Future<Either<AuthFailure, bool>> userWithUsernameExists({
    required String username,
  });

  Future<void> signOut();
}
