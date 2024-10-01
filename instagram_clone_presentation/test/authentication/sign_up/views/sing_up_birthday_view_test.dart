import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/authentication/sign_up/bloc/sign_up_bloc.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_birthday_view.dart';
import 'package:mocktail/mocktail.dart';

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

void main() {
  late SignUpBirthdayView sut;
  late MockSignUpBloc mockSignUpBloc;

  setUp(() {
    mockSignUpBloc = MockSignUpBloc();
    sut = const SignUpBirthdayView();

    when(() => mockSignUpBloc.state).thenReturn(const SignUpState());
  });

  Future<void> arrangeSignUpBirthdayView(WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: BlocProvider<SignUpBloc>.value(
          value: mockSignUpBloc,
          child: sut,
        ),
      ),
    );
  }

  group("SignUpBirthdayView", () {
    testWidgets("Should render FormFieldView",
        (WidgetTester widgetTester) async {
      //Arrange
      await arrangeSignUpBirthdayView(widgetTester);
      //Act
      //Assert
      expect(find.byKey(const Key("form_field_view")), findsOneWidget);
    });

    testWidgets("Should render title", (WidgetTester widgetTester) async {
      //Arrange
      await arrangeSignUpBirthdayView(widgetTester);
      //Act
      //Assert
      expect(find.text("What's your birthday?"), findsOneWidget);
    });

    testWidgets("Should render subtitle", (WidgetTester widgetTester) async {
      //Arrange
      await arrangeSignUpBirthdayView(widgetTester);
      //Act
      //Assert
      expect(
        find.text(
          "User your own birthday, even if this account is for a business, a pet or something else. No one will see this unless you choose to share it.",
        ),
        findsOneWidget,
      );
    });

    testWidgets("Should render primary button",
        (WidgetTester widgetTester) async {
      //Arrange
      await arrangeSignUpBirthdayView(widgetTester);
      //Act
      //Assert
      expect(
        find.byKey(const Key("form_field_view_primary_button")),
        findsOneWidget,
      );
    });

    testWidgets("Should render subtitle column with subtitle context button",
        (WidgetTester widgetTester) async {
      //Arrange
      await arrangeSignUpBirthdayView(widgetTester);
      //Act
      //Assert
      expect(
        find.byKey(const Key("form_field_view_subtitle_context_button_column")),
        findsOneWidget,
      );
    });

    testWidgets("Should not render insta text field",
        (WidgetTester widgetTester) async {
      //Arrange
      await arrangeSignUpBirthdayView(widgetTester);
      //Act
      //Assert
      expect(find.byKey(const Key("form_field_view_field")), findsNothing);
    });
  });
}
