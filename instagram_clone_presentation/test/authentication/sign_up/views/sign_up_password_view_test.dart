import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_password_view.dart';
import 'package:instagram_clone_presentation/common/widgets/insta_text_field.dart';
import 'package:mocktail/mocktail.dart';

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

void main() {
  late SignUpPasswordView sut;
  late MockSignUpBloc mockSignUpBloc;

  setUp(() {
    sut = const SignUpPasswordView();
    mockSignUpBloc = MockSignUpBloc();
    when(
      () => mockSignUpBloc.state,
    ).thenReturn(const SignUpState());
  });

  void setupValidState() {
    when(() => mockSignUpBloc.state).thenReturn(const SignUpState(
      passwordInput: PasswordInput.dirty(value: "P@ssword123"),
    ));
  }

  void setupInvalidState() {
    when(() => mockSignUpBloc.state).thenReturn(const SignUpState(
      passwordInput: PasswordInput.dirty(value: "Password123"),
    ));
  }

  Future<void> renderSignUpPasswordView(WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: BlocProvider<SignUpBloc>.value(
        value: mockSignUpBloc,
        child: sut,
      ),
    ));
  }

  group("SingUpPasswordView", () {
    testWidgets("Should render title with text Create password",
        (WidgetTester widgetTester) async {
      //Arrange
      await renderSignUpPasswordView(widgetTester);
      //Act
      final titleFinder = find.byKey(const Key("form_field_view_title"));
      final titleWidget = widgetTester.widget<Text>(titleFinder);
      //Assert
      expect(titleFinder, findsOneWidget);
      expect(titleWidget.data, "Create a password");
    });

    testWidgets("Should render subtitle with appropriate text",
        (WidgetTester widgetTester) async {
      //Arrange
      const appropriateString =
          "Create a password with at least 6 letters or numbers, It should be something others can't guess";
      await renderSignUpPasswordView(widgetTester);
      //Act
      final titleFinder = find.byKey(const Key("form_field_view_subtitle"));
      final subtitleWidget = widgetTester.widget<Text>(titleFinder);
      //Assert
      expect(titleFinder, findsOneWidget);
      expect(subtitleWidget.data, appropriateString);
    });

    testWidgets("Should render primary button with appropriate label",
        (WidgetTester widgetTester) async {
      //Arrange
      await renderSignUpPasswordView(widgetTester);
      //Act
      final primaryButonFinder =
          find.byKey(const Key("form_field_view_primary_button"));
      final primaryButtonWidget =
          widgetTester.widget<ElevatedButton>(primaryButonFinder);
      //Assert
      expect(primaryButonFinder, findsOneWidget);
      expect((primaryButtonWidget.child as Text).data, "Next");
    });

    group("PasswordTextField", () {
      (Finder, InstaTextField) setupPasswordTextField(
        WidgetTester widgetTester,
      ) {
        final passwordFieldFinder =
            find.byKey(const Key("form_field_view_field"));
        final passwordFinder =
            widgetTester.widget(passwordFieldFinder) as InstaTextField;
        return (passwordFieldFinder, passwordFinder);
      }

      testWidgets("Should render text field with appropriate label",
          (WidgetTester widgetTester) async {
        //Arrange
        const filedLabel = "Password";
        await renderSignUpPasswordView(widgetTester);
        final (passwordFiedFinder, passwordFieldWidget) =
            setupPasswordTextField(widgetTester);
        //Act
        //Assert
        expect(passwordFiedFinder, findsOneWidget);
        expect(passwordFieldWidget.labelText, filedLabel);
      });

      testWidgets(
          "Should raise [SignUpPasswordChanged] event when value changes",
          (WidgetTester widgetTester) async {
        //Arrange
        const password = "passwordtest";
        await renderSignUpPasswordView(widgetTester);
        final (textFieldFinder, _) = setupPasswordTextField(widgetTester);
        //Act
        await widgetTester.enterText(textFieldFinder, password);
        //Assert
        verify(
          () => mockSignUpBloc.add(SignUpPasswordChanged(password: password)),
        );
      });

      testWidgets("Should show error icon when email is invalid",
          (WidgetTester widgetTester) async {
        // Arrange
        setupInvalidState();
        await renderSignUpPasswordView(widgetTester);

        // Act
        final (_, passwordField) = setupPasswordTextField(widgetTester);
        // Assert
        expect(passwordField.icon, isNotNull);
        expect(passwordField.icon!.icon, Icons.error);
        expect(passwordField.icon!.color, Colors.red);
      });

      testWidgets("Should show check icon when email is valid",
          (WidgetTester widgetTester) async {
        // Arrange
        setupValidState();
        await renderSignUpPasswordView(widgetTester);
        // Act
        final (_, passwordField) = setupPasswordTextField(widgetTester);
        // Assert
        expect(passwordField.icon, isNotNull);
        expect(passwordField.icon!.icon, Icons.check_circle);
        expect(passwordField.icon!.color, Colors.green);
      });
    });
  });
}
