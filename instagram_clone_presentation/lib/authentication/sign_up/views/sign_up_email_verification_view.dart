import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

import '../../../common/navigation/router.gr.dart';
import '../../../common/widgets/form_field_view.dart';

@RoutePage()
class SignUpEmailVerificationView extends StatefulWidget {
  const SignUpEmailVerificationView({super.key});

  @override
  State<SignUpEmailVerificationView> createState() =>
      _SignUpEmailVerificationViewState();
}

class _SignUpEmailVerificationViewState
    extends State<SignUpEmailVerificationView> {
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.isEmailVerified) {
          context.router.pushNamed(SignUpPasswordView.name);
        }
      },
      child: FormFieldView<SignUpBloc, SignUpEvent, SignUpState>(
        title: "Enter the confirmation code",
        subtitle:
            "To confirm your account, enter the 6-digit code that we sent to ${context.read<SignUpBloc>().state.emailInput.value}.",
        fieldLabel: "Confirmation code",
        secondaryButtonText: "I didn't receive the code",
        primaryButtonText: "Next",
        onFieldValueChanged: (value) => _codeController.text = value,
        onPrimaryButtonPressed: (_) => _onPrimaryButtonPressed(context),
        onSecondaryButtonPressed: () {},
      ),
    );
  }

  VoidCallback _onPrimaryButtonPressed(BuildContext context) {
    return () => context
        .read<SignUpBloc>()
        .add(VerifySignUpCodeRequested(code: _codeController.text));
  }
}
