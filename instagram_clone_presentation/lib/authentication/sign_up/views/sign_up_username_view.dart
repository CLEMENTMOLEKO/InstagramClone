import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/common/widgets/form_field_view.dart';

@RoutePage()
class SignUpUsernameView extends StatelessWidget {
  const SignUpUsernameView({super.key});

  @override
  Widget build(BuildContext context) {
    return FormFieldView<SignUpBloc, SignUpEvent, SignUpState>(
      title: "Create a username",
      subtitle:
          "Add a username or use our suggestion. You can change theis at any time",
      fieldLabel: "Username",
      primaryButtonText: "Next",
      onPrimaryButtonPressed: (_) => () {},
    );
  }
}
