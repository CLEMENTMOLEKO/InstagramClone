import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/app.dart';
import 'package:instagram_clone_presentation/instagram_clone_presentation.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

import '../test_utils/setup.dart';

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

    setupDependencyInjection(
      mockSignUpBloc,
      mockAuthenticationService,
      mockUserRepository,
      mockConnectionChecker,
      mockEmailService,
      mockAuthenticationBloc,
    );

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
    when(() => mockEmailService.generateVerificationCode()).thenReturn(123456);
    when(() => mockEmailService.sendVerificationCodeToEmail(
          email: any(named: "email"),
          code: any(named: "code"),
        )).thenAnswer((_) async => right(unit));
    when(() => mockAuthenticationService.userWithUsernameExists(
          username: any(named: "username"),
        )).thenAnswer((_) async => right(false));
  });

  tearDown(() {
    tearDownDependencyInjection();
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

    //TODO: Make tests more readable by extracting steps into functions
    testWidgets(
        "Should sign up with email and password successfully when data is valid",
        (widgetTester) async {
      // Arrange
      const formFieldViewFieldKey = Key("form_field_view_field");
      const formFieldViewPrimaryButtonKey =
          Key("form_field_view_primary_button");
      await pumpApp(widgetTester);
      await widgetTester.pumpAndSettle();

      // Act
      // fill in email and submit
      final emailField = find.byKey(formFieldViewFieldKey);
      final emailViewPrimaryButton = find.byKey(formFieldViewPrimaryButtonKey);
      await widgetTester.enterText(emailField, emailAddress.value);
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(emailViewPrimaryButton);
      await widgetTester.pumpAndSettle();

      expect(find.byType(SignUpEmailVerificationView), findsOneWidget);
      // fill in verification code and submit
      final verifyEmailField = find.byKey(formFieldViewFieldKey);
      final verifyEmailViewPrimaryButton =
          find.byKey(formFieldViewPrimaryButtonKey);
      await widgetTester.enterText(verifyEmailField, "123456");
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(verifyEmailViewPrimaryButton);
      await widgetTester.pumpAndSettle();

      expect(find.byType(SignUpPasswordView), findsOneWidget);
      // fill in password and submit
      final passwordField = find.byKey(formFieldViewFieldKey);
      final passwordViewPrimaryButton =
          find.byKey(formFieldViewPrimaryButtonKey);
      await widgetTester.enterText(passwordField, password.value);
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(passwordViewPrimaryButton);
      await widgetTester.pumpAndSettle();

      expect(find.byType(SignUpUsernameView), findsOneWidget);
      // fill in username and submit
      final usernameField = find.byKey(formFieldViewFieldKey);
      final usernameViewPrimaryButton =
          find.byKey(formFieldViewPrimaryButtonKey);
      await widgetTester.enterText(usernameField, "john.doe");
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(usernameViewPrimaryButton);
      await widgetTester.pumpAndSettle();

      // Birthday View
      expect(find.byType(SignUpBirthdayView), findsOneWidget);
      final birthdayField = find.byKey(formFieldViewFieldKey);
      final birthdayViewPrimaryButton =
          find.byKey(formFieldViewPrimaryButtonKey);

      // Open the date picker
      await widgetTester.tap(birthdayField);
      await widgetTester.pumpAndSettle();

      // Find the CupertinoDatePicker
      final datePicker = find.byKey(const Key("birthday_picker"));
      expect(datePicker, findsOneWidget);

      // Target the year picker specifically (it's the rightmost column)
      // The offset needs to be on the right side of the picker where the year column is
      final Offset pickerCenter = widgetTester.getCenter(datePicker);
      final yearPickerOffset = Offset(
        pickerCenter.dx + 100, // Move to the right side where year picker is
        pickerCenter.dy,
      );

      // Simulate scrolling the year picker
      for (int i = 0; i < 5; i++) {
        await widgetTester.dragFrom(
          yearPickerOffset,
          const Offset(0, 300), // Positive offset scrolls to older dates
          touchSlopY: 0,
        );
        await widgetTester.pumpAndSettle();
      }

      // Tap outside the picker to close it
      await widgetTester.tapAt(const Offset(0, 0)); // Tap at top-left corner
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(birthdayViewPrimaryButton);
      await widgetTester.pumpAndSettle();

      expect(find.byType(SignUpSaveLoginInfoView), findsOneWidget);
    });
  });
}
