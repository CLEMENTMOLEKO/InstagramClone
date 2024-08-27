import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

import '../../../common/navigation/route_names.dart';
import '../../../common/widgets/form_field_view.dart';

class SignUpEmailVerificationView extends StatelessWidget {
  const SignUpEmailVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return FormFieldView<SignUpBloc, SignUpEvent, SignUpState>(
      buildWhen: (previous, current) =>
          previous.emailInput != current.emailInput,
      onFieldValueChanged: (email) {
        //context.read<SignUpBloc>().add(SignUpEmailChanged(email: email));
      },
      title: "Enter the confirmation code",
      subtitle:
          "To confirm your account, enter the 6-digit code that we sent to ${context.read<SignUpBloc>().state.emailInput.value}.",
      fieldLabel: "Confirmation code",
      primaryButtonText: "Primary Button Text",
      onPrimaryButtonPressed: (state) =>
          _onPrimaryButtonPressed(state, context),
      secondaryButtonText: "I didn't receive the code",
      onSecondaryButtonPressed: () {},
    );
  }
}

VoidCallback? _onPrimaryButtonPressed(SignUpState state, BuildContext context) {
  return () {
    Navigator.pushNamed(context, RouteNames.signUpEmailVerification);
  };
}
