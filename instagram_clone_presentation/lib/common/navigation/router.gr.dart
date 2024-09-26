// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:instagram_clone_application/instagram_clone_application.dart'
    as _i9;
import 'package:instagram_clone_presentation/authentication/sign_up/sign_up_page.dart'
    as _i3;
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_email_verification_view.dart'
    as _i1;
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_email_view.dart'
    as _i2;
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_password_view.dart'
    as _i4;
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_save_login_info_view.dart'
    as _i5;
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_username_view.dart'
    as _i6;

/// generated route for
/// [_i1.SignUpEmailVerificationView]
class SignUpEmailVerificationView extends _i7.PageRouteInfo<void> {
  const SignUpEmailVerificationView({List<_i7.PageRouteInfo>? children})
      : super(
          SignUpEmailVerificationView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpEmailVerificationView';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.SignUpEmailVerificationView();
    },
  );
}

/// generated route for
/// [_i2.SignUpEmailView]
class SignUpEmailView extends _i7.PageRouteInfo<void> {
  const SignUpEmailView({List<_i7.PageRouteInfo>? children})
      : super(
          SignUpEmailView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpEmailView';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.SignUpEmailView();
    },
  );
}

/// generated route for
/// [_i3.SignUpPage]
class SignUpRoute extends _i7.PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    _i8.Key? key,
    _i9.AuthenticationService? authenticationService,
    _i9.UserRepository? userRepository,
    _i9.ConnectionChecker? connectionChecker,
    _i9.EmailService? emailService,
    List<_i7.PageRouteInfo>? children,
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

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SignUpRouteArgs>(orElse: () => const SignUpRouteArgs());
      return _i3.SignUpPage(
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

  final _i8.Key? key;

  final _i9.AuthenticationService? authenticationService;

  final _i9.UserRepository? userRepository;

  final _i9.ConnectionChecker? connectionChecker;

  final _i9.EmailService? emailService;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key, authenticationService: $authenticationService, userRepository: $userRepository, connectionChecker: $connectionChecker, emailService: $emailService}';
  }
}

/// generated route for
/// [_i4.SignUpPasswordView]
class SignUpPasswordView extends _i7.PageRouteInfo<void> {
  const SignUpPasswordView({List<_i7.PageRouteInfo>? children})
      : super(
          SignUpPasswordView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpPasswordView';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.SignUpPasswordView();
    },
  );
}

/// generated route for
/// [_i5.SignUpSaveLoginInfoView]
class SignUpSaveLoginInfoView extends _i7.PageRouteInfo<void> {
  const SignUpSaveLoginInfoView({List<_i7.PageRouteInfo>? children})
      : super(
          SignUpSaveLoginInfoView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpSaveLoginInfoView';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.SignUpSaveLoginInfoView();
    },
  );
}

/// generated route for
/// [_i6.SignUpUsernameView]
class SignUpUsernameView extends _i7.PageRouteInfo<void> {
  const SignUpUsernameView({List<_i7.PageRouteInfo>? children})
      : super(
          SignUpUsernameView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpUsernameView';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.SignUpUsernameView();
    },
  );
}
