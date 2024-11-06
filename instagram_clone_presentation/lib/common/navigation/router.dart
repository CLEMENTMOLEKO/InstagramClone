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

class Routes {
  // child routes string constants
  static const String signUpString = 'signup';
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
  static const String signUp = '$auth/$signUpString';
  static const String login = '$auth/$loginString';

  // Sign Up Flow Routes
  static const String signUpVerifyEmail = '$signUp/$signUpVerifyEmailString';
  static const String signUpPassword = '$signUp/$signUpPasswordString';
  static const String signUpUsername = '$signUp/$signUpUsernameString';
  static const String signUpBirthday = '$signUp/$signUpBirthdayString';
  static const String signUpSaveLoginInfo =
      '$signUp/$signUpSaveLoginInfoString';
}

final router = GoRouter(
  initialLocation: Routes.root,
  routes: [
    GoRoute(
      path: Routes.root,
      builder: (context, state) => const AppPage(),
    ),
    GoRoute(
      path: Routes.auth,
      builder: (context, state) => const AuthenticationPage(),
      redirect: (context, state) =>
          Routes.signUp, // Redirect to sign-up by default
      routes: [
        GoRoute(
          path: Routes.signUpString,
          builder: (context, state) => const SignUpPage(),
          routes: [
            GoRoute(
              path: Routes.signUpVerifyEmailString,
              builder: (context, state) => const SignUpEmailVerificationView(),
            ),
            GoRoute(
              path: Routes.signUpPasswordString,
              builder: (context, state) => const SignUpPasswordView(),
            ),
            GoRoute(
              path: Routes.signUpUsernameString,
              builder: (context, state) => const SignUpUsernameView(),
            ),
            GoRoute(
              path: Routes.signUpBirthdayString,
              builder: (context, state) => const SignUpBirthdayView(),
            ),
            GoRoute(
              path: Routes.signUpSaveLoginInfoString,
              builder: (context, state) => const SignUpSaveLoginInfoView(),
            ),
          ],
        ),
        GoRoute(
          path: Routes.loginString,
          builder: (context, state) =>
              const Placeholder(), // TODO: Add LoginPage
        ),
      ],
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
