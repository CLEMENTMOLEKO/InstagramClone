import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_application/user/user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  /// [_firebaseFirestore] is the firebase DB
  final FirebaseFirestore _firebaseFirestore;
  final String userDb = "users";

  FirebaseUserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  /// Adds the [UserModel] into the database
  @override
  Future<Either<ApplicationFailure, Unit>> addUser({
    required UserModel userModel,
  }) async {
    //TODO: let's use a package to check for network connections before we do these requests.
    try {
      await _firebaseFirestore
          .collection(userDb)
          .doc(userModel.id.value)
          .set(UserDtoDomainConverter.fromDomainUser(user: userModel).toJson());
      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return left(ApplicationFailure.permissionDenied);
      } else if (e.code == 'unavailable') {
        return left(ApplicationFailure.networkFailure);
      } else {
        return left(ApplicationFailure.unexpected);
      }
    } catch (e) {
      return left(ApplicationFailure.unexpected);
    }
  }

  @override
  Future<Either<ApplicationFailure, UserModel>> getUser({
    required String userId,
  }) async {
    final userDocumentSnapShot =
        await _firebaseFirestore.collection(userDb).doc(userId).get();
    if (userDocumentSnapShot.exists) {
      final userDtoResults = UserDto.fromJson(userDocumentSnapShot.data()!);
      return userDtoResults.fold(
          (applicationFailure) => left(applicationFailure),
          (userDto) => userDto.toDomainUser());
    }

    return left(ApplicationFailure.errorGettingUser);
  }
}
