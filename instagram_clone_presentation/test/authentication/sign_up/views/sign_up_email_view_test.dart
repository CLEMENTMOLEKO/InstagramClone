import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_email_view.dart';
import 'package:instagram_clone_presentation/common/widgets/gradient_view.dart';
import 'package:instagram_clone_presentation/common/widgets/insta_text_field.dart';

void main() {
  Future<void> pumpSignUpEmailView(WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: SignUpEmailView(),
    ));
  }

  testWidgets("Should render instatextfield with Email Address label",
      (widgetTester) async {
    //Arrange
    await pumpSignUpEmailView(widgetTester);
    final instaTextFieldFinder = find.byType(InstaTextField);
    final instaTextField =
        widgetTester.widget(instaTextFieldFinder) as InstaTextField;
    //Act
    //Assert
    expect(instaTextFieldFinder, findsOneWidget);
    expect(instaTextField.labelText, "Email Address");
  });

  testWidgets("Should render GradientView as its body", (widgetTester) async {
    //Arrange
    await pumpSignUpEmailView(widgetTester);
    final scaffoldFinder = find.byType(Scaffold);
    final scaffold = widgetTester.widget(scaffoldFinder) as Scaffold;
    //Act
    //Assert
    expect(scaffoldFinder, findsOneWidget);
    expect(scaffold.body, isA<GradientView>());
  });
}
