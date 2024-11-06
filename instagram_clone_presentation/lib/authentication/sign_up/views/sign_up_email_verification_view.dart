import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/widgets/confirmation_code_sheet.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

import '../../../common/widgets/form_field_view.dart';

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
          context.go('/auth/signup/password');
        }
      },
      listenWhen: (previous, current) =>
          previous.isEmailVerified != current.isEmailVerified,
      child: CupertinoStackedTransition(
        cornerRadius: Tween(begin: 0.0, end: 16.0),
        child: Platform.isAndroid
            ? Scaffold(
                body: getFormFieldView(context),
              )
            : ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                child: CupertinoPageScaffold(
                  child: getFormFieldView(context),
                ),
              ),
      ),
    );
  }

  Widget getFormFieldView(BuildContext context) {
    return FormFieldView<SignUpBloc, SignUpEvent, SignUpState>(
      title: "Enter the confirmation code",
      subtitle:
          "To confirm your account, enter the 6-digit code that we sent to ${context.read<SignUpBloc>().state.emailInput.value}.",
      fieldLabel: "Confirmation code",
      secondaryButtonText: "I didn't receive the code",
      primaryButtonText: "Next",
      onFieldValueChanged: (value) => _codeController.text = value,
      onPrimaryButtonPressed: (_) => _onPrimaryButtonPressed(context),
      onSecondaryButtonPressed: () => _showModalSheet(context),
    );
  }

  VoidCallback? _onPrimaryButtonPressed(BuildContext context) {
    //TODO: handle case where email is not verified, show a toast or alert after clicking next to say code verification failed or passed.
    return () => context
        .read<SignUpBloc>()
        .add(VerifySignUpCodeRequested(code: _codeController.text));
  }

  void _showModalSheet(BuildContext context) {
    // Use `CupertinoModalSheetRoute` to show an ios 15 style modal sheet.
    // For declarative navigation (Navigator 2.0), use `CupertinoModalSheetPage` instead.
    final modalRoute = CupertinoModalSheetRoute(
      // Enable the swipe-to-dismiss behavior.
      swipeDismissible: true,
      // Use `SwipeDismissSensitivity` to tweak the sensitivity of the swipe-to-dismiss behavior.
      swipeDismissSensitivity: const SwipeDismissSensitivity(
        minFlingVelocityRatio: 2.0,
        minDragDistance: 300.0,
      ),
      builder: (context) => const DraggableSheet(
        initialExtent: Extent.proportional(0.5),
        minExtent: Extent.proportional(0.5),
        physics: BouncingSheetPhysics(
          parent: SnappingSheetPhysics(),
        ),
        child: ConfirmationCodeSheet(),
      ),
    );

    Navigator.push(context, modalRoute);
  }
}
