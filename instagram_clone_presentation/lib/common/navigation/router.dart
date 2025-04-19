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
import 'package:instagram_clone_presentation/home/views/notifications_view.dart';

import '../../add_media/add_media_page.dart';
import '../../authentication/sign_up/views/sign_up_email_view.dart';
import '../../home/views/share_view.dart';
import '../../profile/profile_page.dart';
import '../../reels/reels_page.dart';
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
  static const String shareString = 'share';
  static const String mediaString = 'media';
  static const String notificationsString = 'notifications';
  static const String cameraString = 'camera';

  // Base Routes
  static const String rootRoute = '/';
  static const String homeRoute = '/home';
  static const String authRoute = '/auth';
  static const String searchRoute = '/search';
  static const String addMediaRoute = '/add-media';
  static const String reelsRoute = '/reels';
  static const String profileRoute = '/profile';

  // Auth Routes
  static const String loginRoute = '$authRoute/$loginString';

  // Search Routes
  static const String searchMediaRoute = '$searchRoute/media';

  // Add Media Routes

  // Reels Routes
  static const String reelsCameraRoute = '$reelsRoute/camera';

  // Home Routes
  static const String accountProfileRoute = '$homeRoute/$profileString';
  static const String notificationsRoute = '$homeRoute/$notificationsString';
  static const String shareRoute = '$homeRoute/$shareString';
  // Profile Routes
  static const String profileMediaViewRoute = '$profileRoute/media';

  // Sign Up Flow Routes
  static const String signUpEmailRoute = '$authRoute/$signUpEmailString';
  static const String signUpVerifyEmailRoute =
      '$authRoute/$signUpVerifyEmailString';
  static const String signUpPasswordRoute = '$authRoute/$signUpPasswordString';
  static const String signUpUsernameRoute = '$authRoute/$signUpUsernameString';
  static const String signUpBirthdayRoute = '$authRoute/$signUpBirthdayString';
  static const String signUpSaveLoginInfoRoute =
      '$authRoute/$signUpSaveLoginInfoString';
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
  initialLocation: Routes.rootRoute,
  routes: [
    ShellRoute(
      parentNavigatorKey: _rootNavigatorKey,
      navigatorKey: _appNavigatorKey,
      builder: (context, state, child) => AppPage(child: child),
      routes: [
        GoRoute(
          parentNavigatorKey: _appNavigatorKey,
          path: Routes.rootRoute,
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
                  path: Routes.homeRoute,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: HomePage(),
                  ),
                  routes: [
                    // home child routes
                    GoRoute(
                      path: Routes.shareString,
                      builder: (context, state) => const ShareView(),
                    ),
                    GoRoute(
                      path: Routes.notificationsString,
                      builder: (context, state) => const NotificationsView(),
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
                  path: Routes.searchRoute,
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
                  path: Routes.addMediaRoute,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: AddMediaPage(),
                  ),
                  routes: [
                    // child route
                    // GoRoute(
                    //   path: Routes.searchMediaRoute,
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
                  path: Routes.reelsRoute,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: ReelsPage(),
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
                  path: Routes.profileRoute,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: ProfilePage(),
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
                  path: Routes.signUpEmailRoute,
                  parentNavigatorKey: _signUpNavigatorKey,
                  builder: (context, state) => const SignUpEmailView(),
                ),
                GoRoute(
                  path: Routes.signUpVerifyEmailRoute,
                  parentNavigatorKey: _signUpNavigatorKey,
                  builder: (context, state) =>
                      const SignUpEmailVerificationView(),
                ),
                GoRoute(
                  path: Routes.signUpPasswordRoute,
                  parentNavigatorKey: _signUpNavigatorKey,
                  builder: (context, state) => const SignUpPasswordView(),
                ),
                GoRoute(
                  path: Routes.signUpUsernameRoute,
                  parentNavigatorKey: _signUpNavigatorKey,
                  builder: (context, state) => const SignUpUsernameView(),
                ),
                GoRoute(
                  path: Routes.signUpBirthdayRoute,
                  parentNavigatorKey: _signUpNavigatorKey,
                  builder: (context, state) => const SignUpBirthdayView(),
                ),
                GoRoute(
                  path: Routes.signUpSaveLoginInfoRoute,
                  parentNavigatorKey: _signUpNavigatorKey,
                  builder: (context, state) => const SignUpSaveLoginInfoView(),
                ),
              ],
            ),
            GoRoute(
              path: Routes.loginRoute,
              builder: (context, state) =>
                  const Placeholder(), // TODO: Add LoginPage
            ),
          ],
        ),
      ],
    ),
  ],
);
