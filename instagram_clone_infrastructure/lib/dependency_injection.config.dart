// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:instagram_clone_application/common/common.dart' as _i14;
import 'package:instagram_clone_application/instagram_clone_application.dart'
    as _i876;
import 'package:instagram_clone_application/user/user_repository.dart' as _i953;
import 'package:instagram_clone_infrastructure/authentication/firebase_authentication_service.dart'
    as _i9;
import 'package:instagram_clone_infrastructure/network/connection_checker.dart'
    as _i397;
import 'package:instagram_clone_infrastructure/user/firebase_user_repository.dart'
    as _i754;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i876.AuthenticationService>(
        () => _i9.FirebaseAuthenticationService(
              firebaseAuth: gh<_i59.FirebaseAuth>(),
              googleSignIn: gh<_i116.GoogleSignIn>(),
            ));
    gh.factory<_i953.UserRepository>(() => _i754.FirebaseUserRepository(
        firebaseFirestore: gh<_i974.FirebaseFirestore>()));
    gh.factory<_i14.ConnectionChecker>(() => _i397.ConnectionCheckerImpl(
        internetConnectionChecker: gh<_i973.InternetConnectionChecker>()));
    return this;
  }
}