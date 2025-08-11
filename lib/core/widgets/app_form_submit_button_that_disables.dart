import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import 'app_text.dart';

class AppFormSubmitButtonThatDisables extends StatefulWidget {
  final String label;
  final Future<void> Function() function;

  const AppFormSubmitButtonThatDisables({super.key, required this.label, required this.function});

  @override
  State<AppFormSubmitButtonThatDisables> createState() => _AppFormSubmitButtonState();
}

class _AppFormSubmitButtonState extends State<AppFormSubmitButtonThatDisables> {
  bool _isDisabled = false;

  void _handlePress() async {
    setState(() {
      _isDisabled = true;
    });

    await widget.function();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 50,
      child: ElevatedButton(
        onPressed: _isDisabled ? null : _handlePress,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (_isDisabled) {
              return AppColors.mainGreen.withOpacity(0.5);
            }
            if (states.contains(WidgetState.hovered)) {
              return AppColors.mainGreenHoovered;
            }
            return AppColors.mainGreen;
          }),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
        ),
        child: AppText(textValue: widget.label, fontSize: 22, fontColor: AppColors.mainWhite),
      ),
    );
  }
}
