import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_presentation/app_page.dart';
import 'package:instagram_clone_presentation/authentication/authentication_page.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/sign_up_page.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_birthday_view.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_email_verification_view.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_password_view.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_save_login_info_view.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_username_view.dart';
import 'package:instagram_clone_presentation/home/home_page.dart';

import '../../authentication/sign_up/views/sign_up_email_view.dart';

class Routes {
  // child routes string constants
  static const String signUpString = 'signup';
  static const String signUpEmailString = 'email';
  static const String signUpVerifyEmailString = 'verify-email';
  static const String signUpPasswordString = 'password';
  static const String signUpUsernameString = 'username';
  static const String signUpBirthdayString = 'birthday';
  static const String signUpSaveLoginInfoString = 'save-login-info';
  static const String loginString = 'login';

  // Base Routes
  static const String root = '/';
  static const String home = '/home';
  static const String auth = '/auth';

  // Auth Routes
  static const String loginPath = '$auth/$loginString';

  // Sign Up Flow Routes
  static const String signUpEmailPath = '$auth/$signUpEmailString';
  static const String signUpVerifyEmailPath = '$auth/$signUpVerifyEmailString';
  static const String signUpPasswordPath = '$auth/$signUpPasswordString';
  static const String signUpUsernamePath = '$auth/$signUpUsernameString';
  static const String signUpBirthdayPath = '$auth/$signUpBirthdayString';
  static const String signUpSaveLoginInfoPath =
      '$auth/$signUpSaveLoginInfoString';
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _authenticationNavigatorKey = GlobalKey<NavigatorState>();
final _signUpNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.root,
  routes: [
    GoRoute(
      path: Routes.root,
      builder: (context, state) => const AppPage(),
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomePage(),
    ),
    ShellRoute(
      navigatorKey: _authenticationNavigatorKey,
      builder: (context, state, child) => AuthenticationPage(child: child),
      routes: [
        ShellRoute(
          navigatorKey: _signUpNavigatorKey,
          parentNavigatorKey: _authenticationNavigatorKey,
          builder: (context, state, child) => SignUpPage(child: child),
          routes: [
            GoRoute(
              path: Routes.signUpEmailPath,
              parentNavigatorKey: _signUpNavigatorKey,
              builder: (context, state) => const SignUpEmailView(),
            ),
            GoRoute(
              path: Routes.signUpVerifyEmailPath,
              parentNavigatorKey: _signUpNavigatorKey,
              builder: (context, state) => const SignUpEmailVerificationView(),
            ),
            GoRoute(
              path: Routes.signUpPasswordPath,
              parentNavigatorKey: _signUpNavigatorKey,
              builder: (context, state) => const SignUpPasswordView(),
            ),
            GoRoute(
              path: Routes.signUpUsernamePath,
              parentNavigatorKey: _signUpNavigatorKey,
              builder: (context, state) => const SignUpUsernameView(),
            ),
            GoRoute(
              path: Routes.signUpBirthdayPath,
              parentNavigatorKey: _signUpNavigatorKey,
              builder: (context, state) => const SignUpBirthdayView(),
            ),
            GoRoute(
              path: Routes.signUpSaveLoginInfoPath,
              parentNavigatorKey: _signUpNavigatorKey,
              builder: (context, state) => const SignUpSaveLoginInfoView(),
            ),
          ],
        ),
        GoRoute(
          path: Routes.loginPath,
          builder: (context, state) =>
              const Placeholder(), // TODO: Add LoginPage
        ),
      ],
    ),
  ],
);
