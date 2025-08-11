import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import '../utils/font_size_utils.dart';
import 'app_text.dart';

class AppPasswordField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String validationFailedMessage;
  final bool inputFailedValidation;
  final String? title;
  final void Function(String)? onChanged;

  const AppPasswordField({
    super.key,
    this.onChanged,
    required this.textEditingController,
    required this.validationFailedMessage,
    this.title,
    bool? inputFailedValidation,
  }) : inputFailedValidation = inputFailedValidation ?? false;

  @override
  State<AppPasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<AppPasswordField> {
  bool _obscureText = true;
  String _password = '';

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    double headingSize = FontSizeUtils.determineHeadingSize(context);
    double subtitleSize = FontSizeUtils.determineSubtitleSize(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppText(textValue: widget.title ?? "Password", fontSize: headingSize),
        ),
        TextFormField(
          controller: widget.textEditingController,
          cursorColor: AppColors.mainGreen,
          style: AppTextStyles.defaultFontStyle(subtitleSize),
          obscureText: _obscureText,
          onChanged: (value) {
            setState(() {
              _password = value;
            });
            widget.onChanged?.call(value);
          },
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.headingColor)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.headingColor)),
            suffixIcon: IconButton(
              icon: Icon(color: AppColors.mainGreen, _obscureText ? Icons.visibility_off : Icons.visibility),
              onPressed: _toggleVisibility,
            ),
          ),
        ),
        const SizedBox(height: 8),
        showValidationFailureMessageIfApplicable(),
      ],
    );
  }

  Widget showValidationFailureMessageIfApplicable() {
    if (widget.inputFailedValidation) {
      return Align(
        alignment: Alignment.centerLeft,
        child: AppText(textValue: widget.validationFailedMessage, fontSize: 14, fontWeight: FontWeight.w300, fontColor: Colors.red),
      );
    }

    return SizedBox.shrink();
  }
}
