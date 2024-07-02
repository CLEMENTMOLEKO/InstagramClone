import 'package:dartz/dartz.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

abstract class UserRepository {
  Future<Either<ApplicationFailure, UserDto>> getUser(String userId);
}
