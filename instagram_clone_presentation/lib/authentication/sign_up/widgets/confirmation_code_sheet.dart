import 'package:flutter/material.dart';
import 'package:instagram_clone_presentation/common/widgets/gradient_view.dart';

class ConfirmationCodeSheet extends StatelessWidget {
  const ConfirmationCodeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: GradientView(
        child: Center(
          child: Text("Confirmation code sheet."),
        ),
      ),
    );
  }
}
