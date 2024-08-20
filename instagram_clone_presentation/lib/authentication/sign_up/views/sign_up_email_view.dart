import 'package:flutter/material.dart';

import '../../../common/navigation/route_names.dart';
import '../../../common/widgets/form_field_view.dart';

class SignUpEmailView extends StatelessWidget {
  const SignUpEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return FormFieldView(
      title: "What's your email address?",
      subtitle:
          "Enter the email address at which you can be contacted. No one will see this on your profile.",
      fieldLabel: "Email Address",
      primaryButtonText: "Next",
      onPrimaryButtonPressed: () {
        Navigator.pushNamed(context, RouteNames.signUpEmailVerification);
      },
      secondaryButtonText: "Sign Up with Mobile Number",
      onSecondaryButtonPressed: () {},
    );
  }
}
