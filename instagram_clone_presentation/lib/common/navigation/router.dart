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
import '../../search/search_page.dart';
import '../widgets/scaffold_with_nested_navigation.dart';

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
  static const String profileString = 'profile';
  static const String mediaString = 'media';
  static const String cameraString = 'camera';

  // Base Routes
  static const String root = '/';
  static const String home = '/home';
  static const String auth = '/auth';
  static const String search = '/search';
  static const String addMedia = '/add-media';
  static const String reels = '/reels';
  static const String profile = '/profile';

  // Auth Routes
  static const String loginPath = '$auth/$loginString';

  // Search Routes
  static const String searchMediaPath = '$search/media';

  // Add Media Routes

  // Reels Routes
  static const String reelsCameraPath = '$reels/camera';

  // Home Routes
  static const String accountProfilePath = '$home/profile';

  // Profile Routes
  static const String profileMediaViewPath = '$profile/media';

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
final _appNavigatorKey = GlobalKey<NavigatorState>();
final _authenticationNavigatorKey = GlobalKey<NavigatorState>();
final _signUpNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>();
final _shellNavigatorSearchKey = GlobalKey<NavigatorState>();
final _shellNavigatorReelsKey = GlobalKey<NavigatorState>();
final _shellNavigatorProfileKey = GlobalKey<NavigatorState>();
final _shellNavigatorAddMediaKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.root,
  routes: [
    ShellRoute(
      parentNavigatorKey: _rootNavigatorKey,
      navigatorKey: _appNavigatorKey,
      builder: (context, state, child) => AppPage(child: child),
      routes: [
        GoRoute(
          parentNavigatorKey: _appNavigatorKey,
          path: Routes.root,
          builder: (context, state) => const AppView(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            // the UI shell
            return ScaffoldWithNestedNavigation(
                navigationShell: navigationShell);
          },
          branches: [
            // Home branch
            StatefulShellBranch(
              navigatorKey: _shellNavigatorHomeKey,
              routes: [
                // top route inside branch
                GoRoute(
                  path: Routes.home,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: HomePage(),
                  ),
                  routes: [
                    // child route
                    GoRoute(
                      path: Routes.profileString,
                      builder: (context, state) => const Scaffold(
                        body: Center(
                          child: Text("User Profile"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Search branch
            StatefulShellBranch(
              navigatorKey: _shellNavigatorSearchKey,
              routes: [
                // top route inside branch
                GoRoute(
                  path: Routes.search,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: SearchPage(),
                  ),
                  routes: [
                    // child route
                    GoRoute(
                      path: Routes.mediaString,
                      builder: (context, state) => const Scaffold(
                        body: Center(
                          child: Text("Media View"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Reels branch
            StatefulShellBranch(
              navigatorKey: _shellNavigatorAddMediaKey,
              routes: [
                // top route inside branch
                GoRoute(
                  path: Routes.addMedia,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: SearchPage(),
                  ),
                  routes: [
                    // child route
                    // GoRoute(
                    //   path: Routes.searchMediaPath,
                    //   builder: (context, state) => const Scaffold(
                    //     body: Center(
                    //       child: Text("Media View"),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
            // Reels branch
            StatefulShellBranch(
              navigatorKey: _shellNavigatorReelsKey,
              routes: [
                // top route inside branch
                GoRoute(
                  path: Routes.reels,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: SearchPage(),
                  ),
                  routes: [
                    // child route
                    GoRoute(
                      path: Routes.cameraString,
                      builder: (context, state) => const Scaffold(
                        body: Center(
                          child: Text("Reels Camera"),
                        ),
                      ),
                    ), //
                  ],
                ),
              ],
            ),
            // Profile branch
            StatefulShellBranch(
              navigatorKey: _shellNavigatorProfileKey,
              routes: [
                // top route inside branch
                GoRoute(
                  path: Routes.profile,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: SearchPage(),
                  ),
                  routes: [
                    // child route
                    GoRoute(
                      path: Routes.mediaString,
                      builder: (context, state) => const Scaffold(
                        body: Center(
                          child: Text("Profile Media View"),
                        ),
                      ),
                    ), //
                  ],
                ),
              ],
            ),
          ],
        ),
        ShellRoute(
          parentNavigatorKey: _appNavigatorKey,
          navigatorKey: _authenticationNavigatorKey,
          builder: (context, state, child) => AuthenticationPage(child: child),
          routes: [
            ShellRoute(
              parentNavigatorKey: _authenticationNavigatorKey,
              navigatorKey: _signUpNavigatorKey,
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
                  builder: (context, state) =>
                      const SignUpEmailVerificationView(),
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
    ),
  ],
);
