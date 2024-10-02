import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

import '../../../common/widgets/form_field_view.dart';
import '../../../common/widgets/interactive_text.dart';

@RoutePage()
class SignUpBirthdayView extends StatelessWidget {
  const SignUpBirthdayView({super.key});

  @override
  Widget build(BuildContext context) {
    return FormFieldView<SignUpBloc, SignUpEvent, SignUpState>(
      key: const Key("form_field_view"),
      title: "What's your birthday?",
      textSpans: [
        const TextSpan(
          text:
              "User your own birthday, even if this account is for a business, a pet or something else. No one will see this unless you choose to share it.",
        ),
        ClickableTextSpan(
          text: "Why do I need to provide my birthday",
          onTap: () => {},
        ),
      ],
      primaryButtonText: "Next",
      onPrimaryButtonPressed: (_) => onPrimaryButtonPressed(context),
      fieldLabel:
          "Birthday(0 year old)", //TODO: Use bloc or cubit to get age from birthday.
      subtitleContextButtonText: "Why do I need to provide my birthday",
    );
  }

  VoidCallback? onPrimaryButtonPressed(BuildContext context) {
    //TODO: handle primary button pressed
    // return context.read<SignUpBloc>().add(SignUpBirthdayChanged(birthday: ""));
    return () => 1 + 1;
  }
}
