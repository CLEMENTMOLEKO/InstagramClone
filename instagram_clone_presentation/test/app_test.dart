import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/app_page.dart';
import 'package:instagram_clone_presentation/common/navigation/router.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockUserRepository extends Mock implements UserRepository {}

class MockConnectionChecker extends Mock implements ConnectionChecker {}

class MockUser extends Mock implements User {}

class MockGoRouter extends Mock implements GoRouter {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

void main() {
  late MockAuthenticationBloc mockAuthenticationBloc;
  late MockGoRouter mockGoRouter;

  setUp(() {
    mockAuthenticationBloc = MockAuthenticationBloc();
    mockGoRouter = MockGoRouter();

    registerFallbackValue(Routes.auth);
    when(() => mockGoRouter.go(any())).thenReturn(null);
  });

  Future<void> pumpAppView(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: InheritedGoRouter(
          goRouter: mockGoRouter,
          child: BlocProvider<AuthenticationBloc>.value(
            value: mockAuthenticationBloc,
            child: const Appview(),
          ),
        ),
      ),
    );
  }

  group('AppView', () {
    testWidgets('Should render loading indicator on initial state',
        (tester) async {
      when(() => mockAuthenticationBloc.state)
          .thenReturn(AuthenticationInitial());
      await pumpAppView(tester);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Should navigate to auth page on unauthenticated state',
        (tester) async {
      // Arrange
      whenListen(
        mockAuthenticationBloc,
        Stream.fromIterable([
          AuthenticationInitial(),
          Unauthenticated(),
        ]),
        initialState: AuthenticationInitial(),
      );

      // Act
      await pumpAppView(tester);
      await tester.pump();

      // Assert
      verify(() => mockGoRouter.go(Routes.signUpEmailPath)).called(1);
    });

    testWidgets('Should navigate to home page on authenticated state',
        (tester) async {
      // Arrange
      final user = UserModel.createUser(
        userId: UserId.createUnique(),
        userName: 'userName',
        bio: 'bio',
        avatarUrl: 'avatarUrl',
        emailAddress: EmailAddress.create(email: 'email@email.com')
            .getOrElse(() => throw Exception('Error creating email address')),
        joined: DateTime.now(),
      ).getOrElse(() => throw Exception('Error creating user'));

      whenListen(
        mockAuthenticationBloc,
        Stream.fromIterable([
          AuthenticationInitial(),
          Authenticated(user: user),
        ]),
        initialState: AuthenticationInitial(),
      );

      // Act
      await pumpAppView(tester);
      await tester.pump();

      // Assert
      verify(() => mockGoRouter.go(Routes.home)).called(1);
    });
  });
}
