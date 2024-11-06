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
  // Base Routes
  static const String root = '/';
  static const String home = '/home';
  static const String auth = '/auth';

  // Auth Routes
  static const String signUp = '$auth/signup';
  static const String login = '$auth/login';

  // Sign Up Flow Routes
  static const String signUpVerifyEmail = '$signUp/verify-email';
  static const String signUpPassword = '$signUp/password';
  static const String signUpUsername = '$signUp/username';
  static const String signUpBirthday = '$signUp/birthday';
  static const String signUpSaveLoginInfo = '$signUp/save-login-info';
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
          path: 'signup',
          builder: (context, state) => const SignUpPage(),
          routes: [
            GoRoute(
              path: 'verify-email',
              builder: (context, state) => const SignUpEmailVerificationView(),
            ),
            GoRoute(
              path: 'password',
              builder: (context, state) => const SignUpPasswordView(),
            ),
            GoRoute(
              path: 'username',
              builder: (context, state) => const SignUpUsernameView(),
            ),
            GoRoute(
              path: 'birthday',
              builder: (context, state) => const SignUpBirthdayView(),
            ),
            GoRoute(
              path: 'save-login-info',
              builder: (context, state) => const SignUpSaveLoginInfoView(),
            ),
          ],
        ),
        GoRoute(
          path: 'login',
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
