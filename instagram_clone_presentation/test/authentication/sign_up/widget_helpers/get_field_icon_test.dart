import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/widget_helpers/get_field_icon.dart';
import 'package:mocktail/mocktail.dart';

class MockFormzInput extends Mock implements FormzInput {}

void main() {
  late Function(FormzInput) sut;
  late MockFormzInput mockFormzInput;

  setUp(() {
    sut = getFieldIcon;
    mockFormzInput = MockFormzInput();
  });

  void arrangeFormzInput({bool isPure = false, bool isNotValid = false}) {
    when(
      () => mockFormzInput.isPure,
    ).thenReturn(isPure);
    when(
      () => mockFormzInput.isNotValid,
    ).thenReturn(isNotValid);
  }

  group("getFieldIcon", () {
    test("Should return null when [FormzInput] is pure", () {
      //Arrange
      arrangeFormzInput(isPure: true);
      //Act
      final result = sut(mockFormzInput);
      //Assert
      expect(result, null);
    });

    group("Formz input is not pure", () {
      test(
          "Should return Icon.error when [FormzInput] is not pure and not valid",
          () {
        //Arrange
        arrangeFormzInput(isNotValid: true);
        //Act
        final result = sut(mockFormzInput);
        //Assert
        expect((result as Icon).icon, Icons.error);
      });

      test(
          "Should return Icon.check_circle when [FormzInput] is not pure and valid",
          () {
        //Arrange
        arrangeFormzInput();
        //Act
        final result = sut(mockFormzInput);
        //Assert
        expect((result as Icon).icon, Icons.check_circle);
      });
    });
  });
}
