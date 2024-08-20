import 'package:flutter/material.dart';

import '../../../common/widgets/form_field_view.dart';

class SignUpEmailVerificationView extends StatelessWidget {
  const SignUpEmailVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return FormFieldView(
      title: "Enter the confirmation code",
      subtitle:
          "To confirm your account, enter the 6-digit code that we sent to clementtest@mailinator.com.",
      fieldLabel: "Confirmation code",
      primaryButtonText: "Primary Button Text",
      onPrimaryButtonPressed: () {},
      secondaryButtonText: "I didn't receive the code",
      onSecondaryButtonPressed: () {},
    );
  }
}
