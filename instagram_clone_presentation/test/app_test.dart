import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/app_page.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockUserRepository extends Mock implements UserRepository {}

class MockConnectionChecker extends Mock implements ConnectionChecker {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

void main() {
  final mockAuthenticationBloc = MockAuthenticationBloc();

  setUp(() {
    when(() => mockAuthenticationBloc.state)
        .thenAnswer((_) => AuthenticationInitial());
  });

  Future<void> pumpAppView(WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider<AuthenticationBloc>.value(
        value: mockAuthenticationBloc,
        child: const MaterialApp(
          home: AppView(),
        ),
      ),
    );
  }

  testWidgets('Should render AppView', (tester) async {
    await pumpAppView(tester);
    expect(find.byType(AppView), findsOneWidget);
  });
}
