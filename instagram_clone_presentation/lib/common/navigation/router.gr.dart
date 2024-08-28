// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:instagram_clone_application/instagram_clone_application.dart'
    as _i6;
import 'package:instagram_clone_presentation/authentication/sign_up/sign_up_page.dart'
    as _i3;
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_email_verification_view.dart'
    as _i1;
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_email_view.dart'
    as _i2;

/// generated route for
/// [_i1.SignUpEmailVerificationView]
class SignUpEmailVerificationView extends _i4.PageRouteInfo<void> {
  const SignUpEmailVerificationView({List<_i4.PageRouteInfo>? children})
      : super(
          SignUpEmailVerificationView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpEmailVerificationView';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.SignUpEmailVerificationView();
    },
  );
}

/// generated route for
/// [_i2.SignUpEmailView]
class SignUpEmailView extends _i4.PageRouteInfo<void> {
  const SignUpEmailView({List<_i4.PageRouteInfo>? children})
      : super(
          SignUpEmailView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpEmailView';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.SignUpEmailView();
    },
  );
}

/// generated route for
/// [_i3.SignUpPage]
class SignUpRoute extends _i4.PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    _i5.Key? key,
    _i6.AuthenticationService? authenticationService,
    _i6.UserRepository? userRepository,
    _i6.ConnectionChecker? connectionChecker,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          SignUpRoute.name,
          args: SignUpRouteArgs(
            key: key,
            authenticationService: authenticationService,
            userRepository: userRepository,
            connectionChecker: connectionChecker,
          ),
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SignUpRouteArgs>(orElse: () => const SignUpRouteArgs());
      return _i3.SignUpPage(
        key: args.key,
        authenticationService: args.authenticationService,
        userRepository: args.userRepository,
        connectionChecker: args.connectionChecker,
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
  });

  final _i5.Key? key;

  final _i6.AuthenticationService? authenticationService;

  final _i6.UserRepository? userRepository;

  final _i6.ConnectionChecker? connectionChecker;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key, authenticationService: $authenticationService, userRepository: $userRepository, connectionChecker: $connectionChecker}';
  }
}
