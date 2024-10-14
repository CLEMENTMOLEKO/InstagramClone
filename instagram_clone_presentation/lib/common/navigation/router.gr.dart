// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/cupertino.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:instagram_clone_application/instagram_clone_application.dart'
    as _i11;
import 'package:instagram_clone_presentation/authentication/sign_up/sign_up_page.dart'
    as _i4;
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_birthday_view.dart'
    as _i1;
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_email_verification_view.dart'
    as _i2;
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_email_view.dart'
    as _i3;
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_password_view.dart'
    as _i5;
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_save_login_info_view.dart'
    as _i6;
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_username_view.dart'
    as _i7;

/// generated route for
/// [_i1.SignUpBirthdayView]
class SignUpBirthdayView extends _i8.PageRouteInfo<SignUpBirthdayViewArgs> {
  SignUpBirthdayView({
    _i9.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          SignUpBirthdayView.name,
          args: SignUpBirthdayViewArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignUpBirthdayView';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignUpBirthdayViewArgs>(
          orElse: () => const SignUpBirthdayViewArgs());
      return _i1.SignUpBirthdayView(key: args.key);
    },
  );
}

class SignUpBirthdayViewArgs {
  const SignUpBirthdayViewArgs({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return 'SignUpBirthdayViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.SignUpEmailVerificationView]
class SignUpEmailVerificationView extends _i8.PageRouteInfo<void> {
  const SignUpEmailVerificationView({List<_i8.PageRouteInfo>? children})
      : super(
          SignUpEmailVerificationView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpEmailVerificationView';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.SignUpEmailVerificationView();
    },
  );
}

/// generated route for
/// [_i3.SignUpEmailView]
class SignUpEmailView extends _i8.PageRouteInfo<void> {
  const SignUpEmailView({List<_i8.PageRouteInfo>? children})
      : super(
          SignUpEmailView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpEmailView';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.SignUpEmailView();
    },
  );
}

/// generated route for
/// [_i4.SignUpPage]
class SignUpRoute extends _i8.PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    _i10.Key? key,
    _i11.AuthenticationService? authenticationService,
    _i11.UserRepository? userRepository,
    _i11.ConnectionChecker? connectionChecker,
    _i11.EmailService? emailService,
    List<_i8.PageRouteInfo>? children,
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

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SignUpRouteArgs>(orElse: () => const SignUpRouteArgs());
      return _i4.SignUpPage(
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

  final _i10.Key? key;

  final _i11.AuthenticationService? authenticationService;

  final _i11.UserRepository? userRepository;

  final _i11.ConnectionChecker? connectionChecker;

  final _i11.EmailService? emailService;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key, authenticationService: $authenticationService, userRepository: $userRepository, connectionChecker: $connectionChecker, emailService: $emailService}';
  }
}

/// generated route for
/// [_i5.SignUpPasswordView]
class SignUpPasswordView extends _i8.PageRouteInfo<void> {
  const SignUpPasswordView({List<_i8.PageRouteInfo>? children})
      : super(
          SignUpPasswordView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpPasswordView';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i5.SignUpPasswordView();
    },
  );
}

/// generated route for
/// [_i6.SignUpSaveLoginInfoView]
class SignUpSaveLoginInfoView extends _i8.PageRouteInfo<void> {
  const SignUpSaveLoginInfoView({List<_i8.PageRouteInfo>? children})
      : super(
          SignUpSaveLoginInfoView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpSaveLoginInfoView';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.SignUpSaveLoginInfoView();
    },
  );
}

/// generated route for
/// [_i7.SignUpUsernameView]
class SignUpUsernameView extends _i8.PageRouteInfo<void> {
  const SignUpUsernameView({List<_i8.PageRouteInfo>? children})
      : super(
          SignUpUsernameView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpUsernameView';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.SignUpUsernameView();
    },
  );
}
