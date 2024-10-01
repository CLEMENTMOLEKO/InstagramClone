import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone_presentation/common/widgets/insta_text_field.dart';

import 'gradient_view.dart';

class FormFieldView<Tbloc extends Bloc<TEvent, TState>, TEvent, TState>
    extends StatelessWidget {
  final String title;
  final String subtitle;

  /// [fieldLabel] is required if [showTextField] is true,
  /// by default [showTextField] is true
  final String fieldLabel;
  final String primaryButtonText;
  final VoidCallback? Function(TState) onPrimaryButtonPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryButtonPressed;
  final bool Function(TState, TState)? buildWhen;
  final void Function(String)? onFieldValueChanged;
  final String? Function(TState)? getErrorText;
  final Icon? Function(TState)? getFieldIcon;
  final VoidCallback? onAlreadyHaveAccountPressed;
  final String? subtitleContextButtonText;
  final VoidCallback? onSubtitleButtonPressed;

  /// [showTextField] defaults to true and [fieldLabel] is required if [showTextField] is true
  final bool showTextField;

  const FormFieldView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.primaryButtonText,
    required this.onPrimaryButtonPressed,
    this.buildWhen,
    this.secondaryButtonText,
    this.onSecondaryButtonPressed,
    this.onFieldValueChanged,
    this.getErrorText,
    this.getFieldIcon,
    this.onAlreadyHaveAccountPressed,
    this.subtitleContextButtonText,
    this.fieldLabel = "",
    this.showTextField = true,
    this.onSubtitleButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GradientView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  key: const Key("form_field_view_title"),
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const Gap(10),
                Text(
                  key: const Key("form_field_view_subtitle"),
                  subtitle,
                ),
                if (subtitleContextButtonText != null)
                  Column(
                    key: const Key(
                        "form_field_view_subtitle_context_button_column"),
                    children: [
                      const Gap(2),
                      GestureDetector(
                        onTap: onSubtitleButtonPressed,
                        child: Text(subtitleContextButtonText!),
                      ),
                    ],
                  ),
                const Gap(30),
                BlocBuilder<Tbloc, TState>(
                  buildWhen: buildWhen,
                  builder: (context, state) {
                    return Column(
                      key: const Key("form_field_view_root_column"),
                      children: [
                        if (showTextField)
                          InstaTextField(
                            key: const Key("form_field_view_field"),
                            labelText: fieldLabel,
                            onChanged: onFieldValueChanged,
                            errorText: getErrorText != null
                                ? getErrorText!(state)
                                : null,
                            icon: getFieldIcon != null
                                ? getFieldIcon!(state)
                                : null,
                          ),
                        const Gap(20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            key: const Key("form_field_view_primary_button"),
                            onPressed: onPrimaryButtonPressed(state),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CupertinoColors.activeBlue,
                            ),
                            child: Text(
                              primaryButtonText,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
                if (secondaryButtonText != null) const Gap(10),
                if (secondaryButtonText != null)
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      key: const Key("form_field_view_secondary_button"),
                      onPressed: onSecondaryButtonPressed,
                      style: TextButton.styleFrom(
                        side: BorderSide(color: Theme.of(context).dividerColor),
                      ),
                      child: Text(secondaryButtonText!),
                    ),
                  ),
                const Spacer(),
                TextButton(
                  key: const Key("form_field_view_already_have_account_button"),
                  onPressed: () {},
                  child: const Text("I already have an account"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
