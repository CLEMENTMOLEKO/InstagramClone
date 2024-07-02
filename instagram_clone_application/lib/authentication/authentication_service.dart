import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_domain/instagram_clone_domain.dart';

import '../common/common.dart';

abstract class AuthenticationService {
  Stream<User?> get user;
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
    EmailAddress emailAddress,
    Password password,
  );
  Future<Either<AuthFailure, Unit>> loginWithEmailAndPassword(
    EmailAddress emailAddress,
    Password password,
  );
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
  Future<void> signOut();
}
