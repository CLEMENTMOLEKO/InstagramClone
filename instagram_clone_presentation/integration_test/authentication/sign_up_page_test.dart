import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/app.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/sign_up_page.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockUserRepository extends Mock implements UserRepository {}

class MockConnectionChecker extends Mock implements ConnectionChecker {}

class MockEmailService extends Mock implements EmailService {}

class MockGoRouter extends Mock implements GoRouter {}

class MockFirebaseUser extends Mock implements User {}

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

void main() {
  late MockAuthenticationService mockAuthenticationService;
  late MockUserRepository mockUserRepository;
  late MockConnectionChecker mockConnectionChecker;
  late MockEmailService mockEmailService;
  late MockSignUpBloc mockSignUpBloc;
  late MockAuthenticationBloc mockAuthenticationBloc;
  late MockFirebaseUser mockFirebaseUser;
  final emailAddress = EmailAddress.create(email: "john.doe@example.com")
      .getOrElse(() => throw Exception("Email address is invalid"));

  final password = Password.create(password: "P@ssword123").getOrElse(
    () => throw Exception("Password is invalid"),
  );

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(emailAddress);
    registerFallbackValue(password);
  });

  setUp(() {
    mockAuthenticationService = MockAuthenticationService();
    mockUserRepository = MockUserRepository();
    mockConnectionChecker = MockConnectionChecker();
    mockEmailService = MockEmailService();
    mockSignUpBloc = MockSignUpBloc();
    mockAuthenticationBloc = MockAuthenticationBloc();
    mockFirebaseUser = MockFirebaseUser();
    final userModel = UserModel.createUser(
      userId: UserId.create(
        value: "123e4567-e89b-12d3-a456-426614174000",
      ).getOrElse(() => throw Exception("User ID is invalid")),
      userName: "John Doe",
      bio: "I am a test user",
      avatarUrl: "https://www.firebase.com/avatar/1234567890",
      emailAddress: emailAddress,
      joined: DateTime.now(),
    ).getOrElse(() => throw Exception("User model is invalid"));

    final dependencyInjection = GetIt.instance;
    dependencyInjection.registerFactory<SignUpBloc>(() => mockSignUpBloc);
    dependencyInjection.registerFactory<AuthenticationService>(
        () => mockAuthenticationService);
    dependencyInjection
        .registerFactory<UserRepository>(() => mockUserRepository);
    dependencyInjection
        .registerFactory<ConnectionChecker>(() => mockConnectionChecker);
    dependencyInjection.registerFactory<EmailService>(() => mockEmailService);
    dependencyInjection
        .registerFactory<AuthenticationBloc>(() => mockAuthenticationBloc);

    when(() => mockSignUpBloc.state).thenReturn(const SignUpState());
    when(() => mockAuthenticationBloc.state).thenReturn(
      Unauthenticated(),
    );

    when(
      () => mockAuthenticationService.registerWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
      ),
    ).thenAnswer((_) async => right("123e4567-e89b-12d3-a456-426614174000"));
    when(() => mockAuthenticationService.user)
        .thenAnswer((_) => Stream.value(null));
    when(() => mockConnectionChecker.hasConnection)
        .thenAnswer((_) async => true);
    when(() => mockUserRepository.getUser(userId: any(named: 'userId')))
        .thenAnswer((_) async => right(userModel));
    when(() => mockFirebaseUser.uid)
        .thenReturn("123e4567-e89b-12d3-a456-426614174000");
  });

  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(
      const App(),
    );
  }

  group("SignUpPage", () {
    testWidgets("Should render AppPage", (widgetTester) async {
      await pumpApp(widgetTester);
      await widgetTester.pumpAndSettle();
      expect(find.byType(SignUpPage), findsOneWidget);
    });
  });
}
