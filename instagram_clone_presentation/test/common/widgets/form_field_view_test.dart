import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone_presentation/common/widgets/form_field_view.dart';
import 'package:instagram_clone_presentation/common/widgets/gradient_view.dart';
import 'package:instagram_clone_presentation/common/widgets/insta_text_field.dart';

void main() {
  Future<void> pumpFormFieldView(WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: FormFieldView(
        title: "Title",
        subtitle: "Subtitle",
        fieldLabel: "Field Label",
        primaryButtonText: "Primary Button Text",
        onPrimaryButtonPressed: () {},
        secondaryButtonText: "Secondary Button Text",
        onSecondaryButtonPressed: () {},
      ),
    ));
  }

  testWidgets("Should render instatextfield with Email Address label",
      (widgetTester) async {
    //Arrange
    await pumpFormFieldView(widgetTester);
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
    await pumpFormFieldView(widgetTester);
    final scaffoldFinder = find.byType(Scaffold);
    final scaffold = widgetTester.widget(scaffoldFinder) as Scaffold;
    //Act
    //Assert
    expect(scaffoldFinder, findsOneWidget);
    expect(scaffold.body, isA<GradientView>());
  });

  testWidgets("Should render text label", (widgetTester) async {
    //Arrange
    await pumpFormFieldView(widgetTester);
    final textFinder = find.text("Title");
    //Act
    //Assert
    expect(textFinder, findsOneWidget);
  });

  testWidgets("Should render text label Subtitle", (widgetTester) async {
    //Arrange
    await pumpFormFieldView(widgetTester);
    final textFinder = find.text("Subtitle");
    //Act
    //Assert
    expect(textFinder, findsOneWidget);
  });

  testWidgets("Should have a gab between every widget in the column",
      (widgetTester) async {
    //Arrange
    await pumpFormFieldView(widgetTester);
    final columnFinder = find.byType(Column);
    final column = widgetTester.widget(columnFinder) as Column;
    //Act
    //Assert
    expect(columnFinder, findsOneWidget);
    for (int i = 1; i < column.children.length; i += 2) {
      expect(column.children[i], isA<Gap>());
    }
  });
}
