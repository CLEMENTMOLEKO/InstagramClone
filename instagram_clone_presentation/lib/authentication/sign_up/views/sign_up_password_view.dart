import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_presentation/common/widgets/form_field_view.dart';

@RoutePage()
class SignUpPasswordView extends StatelessWidget {
  const SignUpPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return FormFieldView(
      title: "Create a password",
      subtitle:
          "Create a password with at least 6 letters or numbers, It should be something others can't guess",
      fieldLabel: "Password",
      primaryButtonText: "Next",
      onPrimaryButtonPressed: (_) => () {},
    );
  }
}
