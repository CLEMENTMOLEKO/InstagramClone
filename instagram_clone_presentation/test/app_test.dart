import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/app_page.dart';
import 'package:instagram_clone_presentation/authentication/authentication_page.dart';
import 'package:instagram_clone_presentation/common/navigation/router.gr.dart';
import 'package:instagram_clone_presentation/home/home_page.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockUserRepository extends Mock implements UserRepository {}

class MockConnectionChecker extends Mock implements ConnectionChecker {}

class MockRouter extends Mock implements StackRouter {}

class FakePageRouteInfo extends Fake implements PageRouteInfo {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

void main() {
  late MockAuthenticationBloc mockAuthenticationBloc;
  late MockRouter mockRouter;

  setUp(() {
    mockAuthenticationBloc = MockAuthenticationBloc();
    mockRouter = MockRouter();

    when(() => mockAuthenticationBloc.state).thenReturn(
      AuthenticationInitial(),
    );
    when(() => mockRouter.replace(any())).thenAnswer((_) async => false);
  });

  setUpAll(() {
    registerFallbackValue(FakePageRouteInfo());
  });

  Future<void> pumpAppView(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: StackRouterScope(
          controller: mockRouter,
          stateHash: 0,
          child: BlocProvider<AuthenticationBloc>.value(
            value: mockAuthenticationBloc..add(AuthenticationEvents.checkAuth),
            child: const AppView(),
          ),
        ),
      ),
    );
  }

  testWidgets('Should render loading indicator on initial state',
      (tester) async {
    //Arrange
    await pumpAppView(tester);
    //Act
    //Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      skip: true, 'Should render AuthenticationPage on unauthenticated state',
      (tester) async {
    //Arrange
    when(() => mockAuthenticationBloc.state).thenReturn(
      Unauthenticated(),
    );
    await pumpAppView(tester);
    //Act
    //Assert
    expect(find.byType(AuthenticationPage), findsOneWidget);
  });

  testWidgets(skip: true, 'Should render HomePage on authenticated state',
      (tester) async {
    when(() => mockAuthenticationBloc.state).thenReturn(
      Authenticated(
        user: UserModel.createUser(
          userId: UserId.createUnique(),
          userName: 'userName',
          bio: 'bio',
          avatarUrl: 'avatarUrl',
          emailAddress: EmailAddress.create(email: 'email@email.com')
              .getOrElse(() => throw Exception('Error creating email address')),
          joined: DateTime.now(),
        ).getOrElse(() => throw Exception('Error creating user')),
      ),
    );
    await pumpAppView(tester);
    //Act
    //Assert
    expect(find.byType(HomePage), findsOneWidget);
  });
}
