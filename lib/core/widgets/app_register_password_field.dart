import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import '../utils/font_size_utils.dart';
import '../utils/validation_failure_messages.dart';
import 'app_text.dart';

class AppRegisterPasswordField extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool inputFailedValidation;
  final void Function(String)? onChanged;

  const AppRegisterPasswordField({super.key, this.onChanged, required this.textEditingController, required this.inputFailedValidation});

  @override
  State<AppRegisterPasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<AppRegisterPasswordField> {
  bool _obscureText = true;
  String _password = '';

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String _getPasswordStrength(String password) {
    if (password.isEmpty) return '';
    if (password.length < 6) return 'Weak';
    if (password.length < 10) return 'Medium';
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^A-Za-z0-9])');
    if (regex.hasMatch(password)) return 'Strong';
    return 'Medium';
  }

  Color _getStrengthColor(String strength) {
    switch (strength) {
      case 'Weak':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Strong':
        return AppColors.mainGreen;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    double headingSize = FontSizeUtils.determineHeadingSize(context);
    final strength = _getPasswordStrength(_password);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppText(textValue: "Password", fontSize: headingSize),
        ),
        TextFormField(
          controller: widget.textEditingController,
          cursorColor: AppColors.mainGreen,
          style: AppTextStyles.defaultFontStyle(18),
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
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: AppColors.mainGreen,
              ),
              onPressed: _toggleVisibility,
            ),

          ),
        ),
        const SizedBox(height: 8),
        showValidationFailureMessageIfApplicable(),
        getOptionalStrengthRow(strength),
      ],
    );
  }

  Widget getOptionalStrengthRow(String? strength) {
    if (strength == null || strength.isEmpty) {
      return const SizedBox.shrink(); // returns an invisible zero-size widget
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppText(textValue: "Strength: ", fontSize: 14, fontWeight: FontWeight.w500),
            Text(
              strength,
              style: TextStyle(color: _getStrengthColor(strength), fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 10),
        AppText(textValue: "At least 6 characters", fontSize: 14, fontWeight: FontWeight.w300),
        AppText(textValue: "At least 1 capital letter", fontSize: 14, fontWeight: FontWeight.w300),
        AppText(textValue: "At least 1 symbol", fontSize: 14, fontWeight: FontWeight.w300),
        AppText(textValue: "At least 1 number", fontSize: 14, fontWeight: FontWeight.w300),
      ],
    );
  }

  Widget showValidationFailureMessageIfApplicable() {
    if (widget.inputFailedValidation) {
      return Align(
        alignment: Alignment.centerLeft,
        child: AppText(textValue: ValidationFailureMessages.password(), fontSize: 14, fontWeight: FontWeight.w300, fontColor: Colors.red),
      );
    }

    return SizedBox.shrink();
  }
}
