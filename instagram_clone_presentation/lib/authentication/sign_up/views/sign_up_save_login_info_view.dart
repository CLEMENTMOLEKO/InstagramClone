import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/common/widgets/form_field_view.dart';

@RoutePage()
class SignUpSaveLoginInfoView extends StatelessWidget {
  const SignUpSaveLoginInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return FormFieldView<SignUpBloc, SignUpEvent, SignUpState>(
      key: const Key("form_field_view"),
      title: "Save your login info?",
      subtitle:
          "We'll save the login info for your new account, so you won't need to enter it next time you log in.",
      primaryButtonText: "Save",
      onPrimaryButtonPressed: (_) => onPrimaryButtonPressed(),
      fieldLabel: "",
      showTextField: false,
      secondaryButtonText: "Not now",
      onSecondaryButtonPressed: () {
        //TODO: handle not saving login info
      },
    );
  }

  onPrimaryButtonPressed() {
    //TODO: handle saving login info
  }
}
