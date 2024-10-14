import 'package:flutter/material.dart';

class InstaTextField extends StatelessWidget {
  final String labelText;
  final void Function(String)? onChanged;
  final String? errorText;
  final Icon? icon;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextEditingController? controller;

  const InstaTextField({
    super.key,
    required this.labelText,
    required this.onChanged,
    this.icon,
    this.errorText,
    this.readOnly = false,
    this.onTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTap: onTap,
      readOnly: readOnly,
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
