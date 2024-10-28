import 'package:auto_route/auto_route.dart';
import 'package:instagram_clone_presentation/common/navigation/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final _routes = [
    AutoRoute(
      path: "/",
      page: AppView.page,
      children: [
        AutoRoute(
          path: HomeRoute.name,
          page: HomeRoute.page,
        ),
        AutoRoute(
          path: AuthenticationRoute.name,
          page: AuthenticationRoute.page,
          children: [
            AutoRoute(
              path: "",
              page: SignUpRoute.page,
              children: [
                AutoRoute(path: '', page: SignUpEmailView.page),
                AutoRoute(
                  path: SignUpEmailVerificationView.name,
                  page: SignUpEmailVerificationView.page,
                ),
                AutoRoute(
                  path: SignUpPasswordView.name,
                  page: SignUpPasswordView.page,
                ),
                AutoRoute(
                  path: SignUpUsernameView.name,
                  page: SignUpUsernameView.page,
                ),
                AutoRoute(
                  path: SignUpSaveLoginInfoView.name,
                  page: SignUpSaveLoginInfoView.page,
                ),
                AutoRoute(
                  path: SignUpBirthdayView.name,
                  page: SignUpBirthdayView.page,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ];

  @override
  List<AutoRoute> get routes => _routes;
}
