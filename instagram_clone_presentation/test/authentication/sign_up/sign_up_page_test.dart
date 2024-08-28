import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/sign_up_page.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_email_view.dart';
import 'package:instagram_clone_presentation/common/navigation/router.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockUserRepository extends Mock implements UserRepository {}

class MockConnectionChecker extends Mock implements ConnectionChecker {}

class MockStackRouter extends Mock implements StackRouter {}

void main() {
  late MockAuthenticationService mockAuthenticationService;
  late MockUserRepository mockUserRepository;
  late MockConnectionChecker mockConnectionChecker;

  setUp(() {
    mockAuthenticationService = MockAuthenticationService();
    mockUserRepository = MockUserRepository();
    mockConnectionChecker = MockConnectionChecker();
  });

  Future<void> pumpSignUpPage(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: AppRouter().config(),
        builder: (context, child) => SignUpPage(
          authenticationService: mockAuthenticationService,
          userRepository: mockUserRepository,
          connectionChecker: mockConnectionChecker,
        ),
      ),
    );
  }

  group("SignUpPage", () {
    testWidgets("Should render AutoRouter", (widgetTester) async {
      await pumpSignUpPage(widgetTester);
      await widgetTester.pumpAndSettle();
      expect(find.byType(SignUpEmailView), findsOneWidget);
    }, skip: true); // TODO: Fix this test, error caused by auto_route
  });
}
