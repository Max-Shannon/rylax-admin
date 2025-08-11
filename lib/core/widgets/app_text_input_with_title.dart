import 'package:flutter/material.dart';

import '../utils/font_size_utils.dart';
import 'app_text.dart';
import 'app_text_input.dart';

class AppTextInputWithTitle extends StatelessWidget {
  final TextEditingController textEditingController;
  final String title;
  final String? hint;
  final String validationFailedMessage;
  final bool inputFailedValidation;

  const AppTextInputWithTitle({
    super.key,
    required this.textEditingController,
    required this.validationFailedMessage,
    required this.title,
    this.hint,
    bool? inputFailedValidation,
  }) : inputFailedValidation = inputFailedValidation ?? false;

  @override
  Widget build(BuildContext context) {
    double headingSize = FontSizeUtils.determineHeadingSize(context);
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppText(textValue: title, fontSize: headingSize),
        ),
        AppTextInput(textEditingController: textEditingController, hint: hint),
        const SizedBox(height: 8),
        showValidationFailureMessageIfApplicable(),
      ],
    );
  }

  Widget showValidationFailureMessageIfApplicable() {
    if (inputFailedValidation) {
      return Align(
        alignment: Alignment.centerLeft,
        child: AppText(textValue: validationFailedMessage, fontSize: 14, fontWeight: FontWeight.w300, fontColor: Colors.red),
      );
    }

    return SizedBox.shrink();
  }
}
