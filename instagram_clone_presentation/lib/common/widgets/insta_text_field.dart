import 'package:flutter/material.dart';

class InstaTextField extends StatelessWidget {
  final String labelText;
  const InstaTextField({super.key, required this.labelText});

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
      ),
    );
  }
}
