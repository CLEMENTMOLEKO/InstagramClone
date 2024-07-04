import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

final class FirebaseAuthenticationService implements AuthenticationService {
  @override
  // TODO: implement user
  Stream<User?> get user => throw UnimplementedError();

  @override
  Future<Either<AuthFailure, Unit>> loginWithEmailAndPassword(
      EmailAddress emailAddress, Password password) {
    // TODO: implement loginWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      EmailAddress emailAddress, Password password) {
    // TODO: implement registerWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
