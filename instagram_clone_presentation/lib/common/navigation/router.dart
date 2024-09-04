import 'package:auto_route/auto_route.dart';
import 'package:instagram_clone_presentation/common/navigation/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final _routes = [
    AutoRoute(
      path: SignUpRoute.name,
      page: SignUpRoute.page,
      children: [
        AutoRoute(path: '', page: SignUpEmailView.page),
        AutoRoute(
          path: SignUpEmailVerificationView.name,
          page: SignUpEmailVerificationView.page,
        ),
      ],
    ),
  ];

  @override
  List<AutoRoute> get routes => _routes;
}
