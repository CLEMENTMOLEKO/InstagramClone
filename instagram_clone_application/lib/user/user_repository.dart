import 'package:dartz/dartz.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_domain/instagram_clone_domain.dart';

abstract class UserRepository {
  Future<Either<ApplicationFailure, UserModel>> getUser(String userId);
}
