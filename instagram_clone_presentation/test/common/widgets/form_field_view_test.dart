import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/common/widgets/form_field_view.dart';
import 'package:instagram_clone_presentation/common/widgets/gradient_view.dart';
import 'package:instagram_clone_presentation/common/widgets/insta_text_field.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockUserRepository extends Mock implements UserRepository {}

class MockConnectionChecker extends Mock implements ConnectionChecker {}

class MockEmailService extends Mock implements EmailService {}

void main() {
  late SignUpBloc bloc;
  late AuthenticationService mockAuthenticationService;
  late UserRepository mockUserRepository;
  late ConnectionChecker mockConnectionChecker;
  late EmailService mockEmailService;

  setUp(() {
    mockAuthenticationService = MockAuthenticationService();
    mockUserRepository = MockUserRepository();
    mockConnectionChecker = MockConnectionChecker();
    mockEmailService = MockEmailService();
    bloc = SignUpBloc(
      emailService: mockEmailService,
      authenticationService: mockAuthenticationService,
      userRepository: mockUserRepository,
      connectionChecker: mockConnectionChecker,
    );
  });

  Future<void> pumpFormFieldView({
    required WidgetTester widgetTester,
    required SignUpBloc bloc,
    bool showTextField = true,
    String? secondaryButtonText,
  }) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: BlocProvider.value(
        value: bloc,
        child: FormFieldView<SignUpBloc, SignUpEvent, SignUpState>(
          title: "Title",
          subtitle: "Subtitle",
          fieldLabel: "Field Label",
          primaryButtonText: "Primary Button Text",
          onPrimaryButtonPressed: (_) => null,
          buildWhen: (_, __) => true,
          onFieldValueChanged: (_) {},
          getErrorText: (_) => null,
          showTextField: showTextField,
          secondaryButtonText: secondaryButtonText,
        ),
      ),
    ));
  }

  testWidgets("Should render instatextfield with Email Address label",
      (widgetTester) async {
    //Arrange
    await pumpFormFieldView(widgetTester: widgetTester, bloc: bloc);
    final instaTextFieldFinder = find.byType(InstaTextField);
    final instaTextField =
        widgetTester.widget(instaTextFieldFinder) as InstaTextField;
    //Act
    //Assert
    expect(instaTextFieldFinder, findsOneWidget);
    expect(instaTextField.labelText, "Field Label");
  });

  testWidgets("Should render GradientView as its body", (widgetTester) async {
    //Arrange
    await pumpFormFieldView(widgetTester: widgetTester, bloc: bloc);
    final gradientViewFinder = find.byType(GradientView);
    //Act
    //Assert
    expect(gradientViewFinder, findsOneWidget);
  });

  testWidgets("Should render text label", (widgetTester) async {
    //Arrange
    await pumpFormFieldView(widgetTester: widgetTester, bloc: bloc);
    final textFinder = find.text("Title");
    //Act
    //Assert
    expect(textFinder, findsOneWidget);
  });

  testWidgets("Should render text label Subtitle", (widgetTester) async {
    //Arrange
    await pumpFormFieldView(widgetTester: widgetTester, bloc: bloc);
    final textFinder = find.text("Subtitle");
    //Act
    //Assert
    expect(textFinder, findsOneWidget);
  });

  testWidgets("Should render I already have an account button",
      (widgetTester) async {
    //Arrange
    await pumpFormFieldView(widgetTester: widgetTester, bloc: bloc);
    final textFinder =
        find.byKey(const Key("form_field_view_already_have_account_button"));
    //Act
    //Assert
    expect(textFinder, findsOneWidget);
  });

  testWidgets("Should not render InstaTextField when showTextField is false",
      (widgetTester) async {
    //Arrange
    await pumpFormFieldView(
      widgetTester: widgetTester,
      bloc: bloc,
      showTextField: false,
    );
    final instaTextFieldFinder = find.byKey(const Key("form_field_view_field"));
    //Act
    //Assert
    expect(instaTextFieldFinder, findsNothing);
  });

  testWidgets(
      "Should not render subtitle context column when subtitleContextButtonText is null",
      (widgetTester) async {
    //Arrange
    await pumpFormFieldView(widgetTester: widgetTester, bloc: bloc);
    final subtitleContextButtonFinder =
        find.byKey(const Key("form_field_view_subtitle_context_button_column"));
    //Act
    //Assert
    expect(subtitleContextButtonFinder, findsNothing);
  });

  testWidgets(
      "Should not render secondary button when secondaryButtonText is null",
      (widgetTester) async {
    //Arrange
    await pumpFormFieldView(widgetTester: widgetTester, bloc: bloc);
    final secondaryButtonFinder =
        find.byKey(const Key("form_field_view_secondary_button"));
    //Act
    //Assert
    expect(secondaryButtonFinder, findsNothing);
  });

  testWidgets(
      "Should render secondary button when secondaryButtonText is not null",
      (widgetTester) async {
    //Arrange
    await pumpFormFieldView(
      widgetTester: widgetTester,
      bloc: bloc,
      secondaryButtonText: "Secondary Button Text",
    );
    final secondaryButtonFinder =
        find.byKey(const Key("form_field_view_secondary_button"));
    //Act
    //Assert
    expect(secondaryButtonFinder, findsOneWidget);
  });
}
