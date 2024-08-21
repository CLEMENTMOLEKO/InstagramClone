import 'package:flutter/material.dart';

class InstaTextField extends StatelessWidget {
  final String labelText;
  final void Function(String) onChanged;
  final String? errorText;
  final Icon? icon;

  const InstaTextField({
    super.key,
    required this.labelText,
    required this.onChanged,
    this.icon,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        labelText: labelText,
        errorText: errorText,
        suffixIcon: icon,
      ),
      onChanged: onChanged,
    );
  }
}
