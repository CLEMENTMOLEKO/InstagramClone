import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/authentication/validators/username_input_validator.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_username_view.dart';
import 'package:instagram_clone_presentation/common/widgets/insta_text_field.dart';
import 'package:mocktail/mocktail.dart';

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

class MockUsernameInput extends Mock implements UsernameInput {}

void main() {
  late SignUpUsernameView sut;
  late MockSignUpBloc mockSignUpBloc;
  late MockUsernameInput mockUsernameInput;

  setUp(() {
    sut = const SignUpUsernameView();
    mockSignUpBloc = MockSignUpBloc();
    mockUsernameInput = MockUsernameInput();
    when(
      () => mockSignUpBloc.state,
    ).thenReturn(const SignUpState());
  });

  void setupStateWith({
    bool isUsernameValid = true,
    bool isUsernamePure = false,
  }) {
    when(
      () => mockUsernameInput.isPure,
    ).thenReturn(isUsernamePure);
    when(() => mockSignUpBloc.state).thenReturn(SignUpState(
      isUsernameValid: isUsernameValid,
      usernameInput: mockUsernameInput,
    ));
  }

  Future<void> renderSignUpUsernameView(WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: BlocProvider<SignUpBloc>.value(
          value: mockSignUpBloc,
          child: sut,
        ),
      ),
    );
  }

  (Finder, InstaTextField) setupPasswordTextField(
    WidgetTester widgetTester,
  ) {
    final usernameFieldFinder = find.byKey(const Key("form_field_view_field"));
    final usernameField =
        widgetTester.widget(usernameFieldFinder) as InstaTextField;
    return (usernameFieldFinder, usernameField);
  }

  group("SignUpUsernameView", () {
    group("Render Widgets", () {
      testWidgets("Should render title", (WidgetTester widgetTester) async {
        //Arrange
        await renderSignUpUsernameView(widgetTester);
        //Act
        final titleFinder = find.byKey(const Key("form_field_view_title"));
        final titleWidget = widgetTester.widget<Text>(titleFinder);
        //Assert
        expect(titleFinder, findsOneWidget);
        expect(titleWidget.data, "Create a username");
      });

      testWidgets("Should render subtitle with appropriate text",
          (WidgetTester widgetTester) async {
        //Arrange
        const appropriateString =
            "Add a username or use our suggestion. You can change this at any time";
        await renderSignUpUsernameView(widgetTester);
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
        await renderSignUpUsernameView(widgetTester);
        //Act
        final primaryButonFinder =
            find.byKey(const Key("form_field_view_primary_button"));
        final primaryButtonWidget =
            widgetTester.widget<ElevatedButton>(primaryButonFinder);
        //Assert
        expect(primaryButonFinder, findsOneWidget);
        expect((primaryButtonWidget.child as Text).data, "Next");
      });

      testWidgets("Should render text field with appropriate label",
          (WidgetTester widgetTester) async {
        //Arrange
        const filedLabel = "Username";
        await renderSignUpUsernameView(widgetTester);
        final (passwordFiedFinder, passwordFieldWidget) =
            setupPasswordTextField(widgetTester);
        //Act
        //Assert
        expect(passwordFiedFinder, findsOneWidget);
        expect(passwordFieldWidget.labelText, filedLabel);
      });
    });

    group("UsernameTextField", () {
      testWidgets("Should raise [UserNameChanged] event when value changes",
          (WidgetTester widgetTester) async {
        //Arrange
        const username = "testuseranme";
        await renderSignUpUsernameView(widgetTester);
        final (textFieldFinder, _) = setupPasswordTextField(widgetTester);
        //Act
        await widgetTester.enterText(textFieldFinder, username);
        //Assert
        verify(
          () => mockSignUpBloc.add(UserNameChanged(username: username)),
        );
      });

      testWidgets("Should not show icon when username is pure",
          (WidgetTester widgetTester) async {
        // Arrange
        setupStateWith(isUsernamePure: true);
        await renderSignUpUsernameView(widgetTester);

        // Act
        final (_, usernameField) = setupPasswordTextField(widgetTester);
        // Assert
        expect(usernameField.icon, isNull);
      });

      testWidgets("Should show error icon when username is invalid",
          (WidgetTester widgetTester) async {
        // Arrange
        setupStateWith(isUsernameValid: false);
        await renderSignUpUsernameView(widgetTester);

        // Act
        final (_, usernameField) = setupPasswordTextField(widgetTester);
        // Assert
        expect(usernameField.icon, isNotNull);
        expect(usernameField.icon!.icon, Icons.error);
        expect(usernameField.icon!.color, Colors.red);
      });

      testWidgets("Should show check icon when username is valid",
          (WidgetTester widgetTester) async {
        // Arrange
        setupStateWith(isUsernameValid: true);
        await renderSignUpUsernameView(widgetTester);
        // Act
        final (_, usernameField) = setupPasswordTextField(widgetTester);
        // Assert
        expect(usernameField.icon, isNotNull);
        expect(usernameField.icon!.icon, Icons.check_circle);
        expect(usernameField.icon!.color, Colors.green);
      });
    });
  });
}
