import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

Icon? getFieldIcon(FormzInput formzInput) {
  if (formzInput.isPure) return null;

  return formzInput.isNotValid
      ? const Icon(Icons.error, color: Colors.red)
      : const Icon(Icons.check_circle, color: Colors.green);
}
