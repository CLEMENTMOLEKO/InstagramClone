// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/cupertino.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:instagram_clone_application/instagram_clone_application.dart'
    as _i14;
import 'package:instagram_clone_presentation/app.dart' as _i1;
import 'package:instagram_clone_presentation/authentication/authentication_page.dart'
    as _i2;
import 'package:instagram_clone_presentation/authentication/sign_up/sign_up_page.dart'
    as _i7;
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_birthday_view.dart'
    as _i4;
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_email_verification_view.dart'
    as _i5;
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_email_view.dart'
    as _i6;
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_password_view.dart'
    as _i8;
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_save_login_info_view.dart'
    as _i9;
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_username_view.dart'
    as _i10;
import 'package:instagram_clone_presentation/home/home_page.dart' as _i3;

/// generated route for
/// [_i1.AppView]
class AppView extends _i11.PageRouteInfo<void> {
  const AppView({List<_i11.PageRouteInfo>? children})
      : super(
          AppView.name,
          initialChildren: children,
        );

  static const String name = 'AppView';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i1.AppView();
    },
  );
}

/// generated route for
/// [_i2.AuthenticationPage]
class AuthenticationRoute extends _i11.PageRouteInfo<void> {
  const AuthenticationRoute({List<_i11.PageRouteInfo>? children})
      : super(
          AuthenticationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i2.AuthenticationPage();
    },
  );
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomePage();
    },
  );
}

/// generated route for
/// [_i4.SignUpBirthdayView]
class SignUpBirthdayView extends _i11.PageRouteInfo<SignUpBirthdayViewArgs> {
  SignUpBirthdayView({
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          SignUpBirthdayView.name,
          args: SignUpBirthdayViewArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignUpBirthdayView';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignUpBirthdayViewArgs>(
          orElse: () => const SignUpBirthdayViewArgs());
      return _i4.SignUpBirthdayView(key: args.key);
    },
  );
}

class SignUpBirthdayViewArgs {
  const SignUpBirthdayViewArgs({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return 'SignUpBirthdayViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.SignUpEmailVerificationView]
class SignUpEmailVerificationView extends _i11.PageRouteInfo<void> {
  const SignUpEmailVerificationView({List<_i11.PageRouteInfo>? children})
      : super(
          SignUpEmailVerificationView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpEmailVerificationView';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i5.SignUpEmailVerificationView();
    },
  );
}

/// generated route for
/// [_i6.SignUpEmailView]
class SignUpEmailView extends _i11.PageRouteInfo<void> {
  const SignUpEmailView({List<_i11.PageRouteInfo>? children})
      : super(
          SignUpEmailView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpEmailView';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i6.SignUpEmailView();
    },
  );
}

/// generated route for
/// [_i7.SignUpPage]
class SignUpRoute extends _i11.PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    _i13.Key? key,
    _i14.AuthenticationService? authenticationService,
    _i14.UserRepository? userRepository,
    _i14.ConnectionChecker? connectionChecker,
    _i14.EmailService? emailService,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          SignUpRoute.name,
          args: SignUpRouteArgs(
            key: key,
            authenticationService: authenticationService,
            userRepository: userRepository,
            connectionChecker: connectionChecker,
            emailService: emailService,
          ),
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SignUpRouteArgs>(orElse: () => const SignUpRouteArgs());
      return _i7.SignUpPage(
        key: args.key,
        authenticationService: args.authenticationService,
        userRepository: args.userRepository,
        connectionChecker: args.connectionChecker,
        emailService: args.emailService,
      );
    },
  );
}

class SignUpRouteArgs {
  const SignUpRouteArgs({
    this.key,
    this.authenticationService,
    this.userRepository,
    this.connectionChecker,
    this.emailService,
  });

  final _i13.Key? key;

  final _i14.AuthenticationService? authenticationService;

  final _i14.UserRepository? userRepository;

  final _i14.ConnectionChecker? connectionChecker;

  final _i14.EmailService? emailService;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key, authenticationService: $authenticationService, userRepository: $userRepository, connectionChecker: $connectionChecker, emailService: $emailService}';
  }
}

/// generated route for
/// [_i8.SignUpPasswordView]
class SignUpPasswordView extends _i11.PageRouteInfo<void> {
  const SignUpPasswordView({List<_i11.PageRouteInfo>? children})
      : super(
          SignUpPasswordView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpPasswordView';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i8.SignUpPasswordView();
    },
  );
}

/// generated route for
/// [_i9.SignUpSaveLoginInfoView]
class SignUpSaveLoginInfoView extends _i11.PageRouteInfo<void> {
  const SignUpSaveLoginInfoView({List<_i11.PageRouteInfo>? children})
      : super(
          SignUpSaveLoginInfoView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpSaveLoginInfoView';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.SignUpSaveLoginInfoView();
    },
  );
}

/// generated route for
/// [_i10.SignUpUsernameView]
class SignUpUsernameView extends _i11.PageRouteInfo<void> {
  const SignUpUsernameView({List<_i11.PageRouteInfo>? children})
      : super(
          SignUpUsernameView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpUsernameView';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.SignUpUsernameView();
    },
  );
}
