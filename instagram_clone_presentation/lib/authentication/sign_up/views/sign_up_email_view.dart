import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

import '../../../common/navigation/router.dart';
import '../../../common/widgets/form_field_view.dart';
import '../widget_helpers/get_field_icon.dart';

class SignUpEmailView extends StatelessWidget {
  const SignUpEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return FormFieldView<SignUpBloc, SignUpEvent, SignUpState>(
      buildWhen: (previous, current) =>
          previous.emailInput != current.emailInput,
      onFieldValueChanged: (email) {
        context.read<SignUpBloc>().add(SignUpEmailChanged(email: email));
      },
      title: "What's your email address?",
      subtitle:
          "Enter the email address at which you can be contacted. No one will see this on your profile.",
      fieldLabel: "Email Address",
      primaryButtonText: "Next",
      onPrimaryButtonPressed: (state) =>
          _onPrimaryButtonPressed(state, context),
      secondaryButtonText: "Sign Up with Mobile Number",
      onSecondaryButtonPressed: () {},
      getFieldIcon: (state) => getFieldIcon(state.emailInput),
    );
  }

  VoidCallback? _onPrimaryButtonPressed(
    SignUpState state,
    BuildContext context,
  ) {
    return state.emailInput.isValid
        ? () {
            context.read<SignUpBloc>().add(
                  SingUpEmailVerificationRequested(
                    email: state.emailInput.value,
                  ),
                );
            context.go(Routes.signUpVerifyEmailRoute);
          }
        : null;
  }
}
