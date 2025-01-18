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

  setUpAll(() {
    registerFallbackValue(SignUpBirthdayChanged(birthday: "1990-01-01"));
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

    testWidgets("Should render subtitle as interactive text",
        (WidgetTester widgetTester) async {
      //Arrange
      await arrangeSignUpBirthdayView(widgetTester);
      //Act
      //Assert
      expect(
        find.byKey(const Key("form_field_view_subtitle_interactive_text")),
        findsOneWidget,
      );
    });

    testWidgets("Should render insta text field",
        (WidgetTester widgetTester) async {
      //Arrange
      await arrangeSignUpBirthdayView(widgetTester);
      //Act
      //Assert
      expect(find.byKey(const Key("form_field_view_field")), findsOneWidget);
    });

    group('Date Picker', () {
      Future<void> showDatePickerSetup(WidgetTester widgetTester) async {
        await arrangeSignUpBirthdayView(widgetTester);
        final textField = find.byKey(const Key("form_field_view_field"));
        //Act
        await widgetTester.tap(textField);
        await widgetTester.pumpAndSettle();
      }

      testWidgets("Should render birthday picker when tapping on the field",
          (WidgetTester widgetTester) async {
        //Arrange
        await showDatePickerSetup(widgetTester);
        //Assert
        expect(find.byKey(const Key("birthday_picker")), findsOneWidget);
      });

      testWidgets("Changing birthday should emit birthday event",
          (WidgetTester widgetTester) async {
        //Arrange
        await showDatePickerSetup(widgetTester);
        //Act
        // Scroll the date picker to change the date
        final datePicker = find.byKey(const Key("birthday_picker"));
        await widgetTester.drag(
            datePicker, const Offset(0, 100)); // Scroll down to increase year
        await widgetTester.pumpAndSettle();
        //Assert
        verify(() =>
                mockSignUpBloc.add(any(that: isA<SignUpBirthdayChanged>())))
            .called(greaterThanOrEqualTo(1));
      });
    });
  });
}
