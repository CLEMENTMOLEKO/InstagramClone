import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

import '../../../common/navigation/router.dart';
import '../../../common/widgets/form_field_view.dart';
import '../../../common/widgets/interactive_text.dart';
import '../widget_helpers/get_field_icon.dart';

class SignUpBirthdayView extends StatefulWidget {
  const SignUpBirthdayView({super.key});

  @override
  State<SignUpBirthdayView> createState() => _SignUpBirthdayViewState();
}

class _SignUpBirthdayViewState extends State<SignUpBirthdayView> {
  late TextEditingController textFieldController;

  @override
  void initState() {
    super.initState();
    textFieldController = TextEditingController(text: "Birthday(0 year old)");
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormFieldView<SignUpBloc, SignUpEvent, SignUpState>(
      key: const Key("form_field_view"),
      title: "What's your birthday?",
      subTitleTextSpans: [
        const TextSpan(
          text:
              "User your own birthday, even if this account is for a business, a pet or something else. No one will see this unless you choose to share it.",
        ),
        ClickableTextSpan(
          text: "Why do I need to provide my birthday",
          onTap: () => _showDialog(context),
        ),
      ],
      primaryButtonText: "Next",
      onPrimaryButtonPressed: (state) => onPrimaryButtonPressed(context, state),
      fieldLabel: "Birthday",
      textFieldDisabled: true,
      onFieldClick: () => _showDialog(context),
      getFieldIcon: (state) => getFieldIcon(state.birthdayInput),
      subtitleContextButtonText: "Why do I need to provide my birthday",
      textFieldController: textFieldController,
    );
  }

  VoidCallback? onPrimaryButtonPressed(
    BuildContext context,
    SignUpState state,
  ) {
    return state.birthdayInput.isValid
        ? () => context.go(Routes.signUpSaveLoginInfoRoute)
        : null;
  }

  /// [_showDialog] is used to show the date picker in a modal popup. platform specific.
  void _showDialog(BuildContext context) {
    print("show dialog clicked");
    if (Platform.isIOS) {
      _showCupertinoDatePicker(context);
    } else {
      _showMaterialDatePicker(context);
    }
  }

  void _showMaterialDatePicker(BuildContext _context) {
    showDialog(
      context: _context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Spacer(),
            DatePickerWidget(
              key: const Key("birthday_picker"),
              looping: false, // default is not looping
              firstDate: DateTime(1990, 01, 01),
              lastDate: DateTime.now(),
              initialDate: DateTime.now(),
              dateFormat: "dd-MMM-yyyy",
              locale: DatePicker.localeFromString(
                  Localizations.localeOf(context).languageCode),
              onChange: (DateTime newDate, _) =>
                  _onDateChanged(newDate, _context),
              pickerTheme: DateTimePickerTheme(
                backgroundColor: Theme.of(context).dialogBackgroundColor,
                itemTextStyle: Theme.of(context).textTheme.bodyMedium!,
                dividerColor: Theme.of(context).dividerColor,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void _showCupertinoDatePicker(BuildContext _context) {
    final date = DateTime.now();

    showCupertinoModalPopup<void>(
      context: _context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            key: const Key("birthday_picker"),
            initialDateTime: date,
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            showDayOfWeek: true,
            onDateTimeChanged: (DateTime newDate) =>
                _onDateChanged(newDate, _context),
          ),
        ),
      ),
    );
  }

  void _onDateChanged(DateTime newDate, BuildContext context) {
    final age = DateTime.now().year - newDate.year;
    context
        .read<SignUpBloc>()
        .add(SignUpBirthdayChanged(birthday: newDate.toString()));
    textFieldController.text = "Birthday($age year old)";
  }
}
