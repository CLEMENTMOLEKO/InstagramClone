import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/sign_up_page.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockUserRepository extends Mock implements UserRepository {}

class MockConnectionChecker extends Mock implements ConnectionChecker {}

class MockEmailService extends Mock implements EmailService {}

class MockGoRouter extends Mock implements GoRouter {}

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

void main() {
  late MockAuthenticationService mockAuthenticationService;
  late MockUserRepository mockUserRepository;
  late MockConnectionChecker mockConnectionChecker;
  late MockEmailService mockEmailService;
  late MockGoRouter mockGoRouter;
  late MockSignUpBloc mockSignUpBloc;

  setUp(() {
    mockAuthenticationService = MockAuthenticationService();
    mockUserRepository = MockUserRepository();
    mockConnectionChecker = MockConnectionChecker();
    mockEmailService = MockEmailService();
    mockGoRouter = MockGoRouter();
    mockSignUpBloc = MockSignUpBloc();

    when(() => mockGoRouter.go(any())).thenReturn(null);
  });

  Future<void> pumpSignUpPage(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: InheritedGoRouter(
          goRouter: mockGoRouter,
          child: BlocProvider<SignUpBloc>.value(
            value: mockSignUpBloc,
            child: SignUpPage(
              authenticationService: mockAuthenticationService,
              userRepository: mockUserRepository,
              connectionChecker: mockConnectionChecker,
              emailService: mockEmailService,
              child: const Center(key: Key("test"), child: Text("Test")),
            ),
          ),
        ),
      ),
    );
  }

  group("SignUpPage", () {
    testWidgets("Should render passed in child", (widgetTester) async {
      await pumpSignUpPage(widgetTester);
      await widgetTester.pumpAndSettle();
      expect(find.text("Test"), findsOneWidget);
    });
  });
}
