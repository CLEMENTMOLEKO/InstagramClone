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
  final String fieldLabel;
  final String primaryButtonText;
  final VoidCallback? Function(TState) onPrimaryButtonPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryButtonPressed;
  final bool Function(TState, TState) buildWhen;
  final void Function(String) onFieldValueChanged;
  final String? Function(TState) getErrorText;
  final Icon? Function(TState)? getFieldIcon;

  const FormFieldView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.fieldLabel,
    required this.primaryButtonText,
    required this.onPrimaryButtonPressed,
    this.secondaryButtonText,
    this.onSecondaryButtonPressed,
    required this.buildWhen,
    required this.onFieldValueChanged,
    required this.getErrorText,
    this.getFieldIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const Gap(10),
                Text(subtitle),
                const Gap(30),
                BlocBuilder<Tbloc, TState>(
                  buildWhen: buildWhen,
                  builder: (context, state) {
                    return Column(
                      key: const Key("form_field_view_root_column"),
                      children: [
                        InstaTextField(
                          key: const Key("form_field_view_field"),
                          labelText: fieldLabel,
                          onChanged: onFieldValueChanged,
                          errorText: getErrorText(state),
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
                            child: Text(primaryButtonText),
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
                        side: const BorderSide(color: Colors.grey),
                      ),
                      child: Text(secondaryButtonText!),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
