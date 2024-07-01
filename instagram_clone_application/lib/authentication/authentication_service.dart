import 'package:dartz/dartz.dart';
import 'package:instagram_clone_domain/instagram_clone_domain.dart';

import '../common/common.dart';

abstract class AuthenticationService {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
    EmailAddress emailAddress,
    Password password,
  );
  Future<Either<AuthFailure, Unit>> loginWithEmailAndPassword(
    EmailAddress emailAddress,
    Password password,
  );
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
}
