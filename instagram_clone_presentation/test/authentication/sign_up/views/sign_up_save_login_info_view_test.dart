import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_save_login_info_view.dart';
import 'package:instagram_clone_presentation/common/widgets/form_field_view.dart';
import 'package:mocktail/mocktail.dart';

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

void main() {
  late SignUpSaveLoginInfoView sut;
  late MockSignUpBloc mockSignUpBloc;

  setUp(() {
    mockSignUpBloc = MockSignUpBloc();
    sut = const SignUpSaveLoginInfoView();
    when(() => mockSignUpBloc.state).thenReturn(const SignUpState());
  });

  Future<void> arrangeSignUpSaveLoginInfoView(WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: BlocProvider<SignUpBloc>.value(
          value: mockSignUpBloc,
          child: sut,
        ),
      ),
    );
  }

  group("SignUpSaveLoginInfor", () {
    testWidgets("Should render FormFieldView",
        (WidgetTester widgetTester) async {
      // Arrange
      // Act
      await arrangeSignUpSaveLoginInfoView(widgetTester);
      // Assert
      expect(find.byKey(const Key("form_field_view")), findsOneWidget);
    });

    testWidgets("Should render title", (WidgetTester widgetTester) async {
      // Arrange
      await arrangeSignUpSaveLoginInfoView(widgetTester);
      // Act
      // Assert
      expect(find.byKey(const Key("form_field_view_title")), findsOneWidget);
    });

    testWidgets("Should render subtitle", (WidgetTester widgetTester) async {
      // Arrange
      await arrangeSignUpSaveLoginInfoView(widgetTester);
      // Act
      // Assert
      expect(find.byKey(const Key("form_field_view_subtitle")), findsOneWidget);
    });

    testWidgets("Should render primary button",
        (WidgetTester widgetTester) async {
      // Arrange
      await arrangeSignUpSaveLoginInfoView(widgetTester);
      // Act
      // Assert
      expect(find.byKey(const Key("form_field_view_primary_button")),
          findsOneWidget);
    });

    testWidgets("Should render secondary button",
        (WidgetTester widgetTester) async {
      // Arrange
      await arrangeSignUpSaveLoginInfoView(widgetTester);
      // Act
      // Assert
      expect(find.byKey(const Key("form_field_view_secondary_button")),
          findsOneWidget);
    });

    testWidgets("Should not render text field",
        (WidgetTester widgetTester) async {
      // Arrange
      await arrangeSignUpSaveLoginInfoView(widgetTester);
      // Act
      // Assert
      expect(find.byKey(const Key("form_field_view_field")), findsNothing);
    });
  });
}
