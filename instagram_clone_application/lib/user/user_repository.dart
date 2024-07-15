import 'package:dartz/dartz.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

abstract class UserRepository {
  /// [getUser] returns Either an [ApplicationFailure] or [UserModel],
  /// returns [ApplicationFailure] if get user was unsuccessful and
  /// returns [UserModel] after getting user from database.
  Future<Either<ApplicationFailure, UserModel>> getUser(String userId);

  /// [addUser] returns Either an [ApplicationFailure] or [Unit],
  /// returns [ApplicationFailure] if add user was unsuccessful and
  /// returns [Unit] after adding user to database.
  Future<Either<ApplicationFailure, UserModel>> addUser(UserModel userId);
}
