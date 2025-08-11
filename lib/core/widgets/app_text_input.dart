import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class AppTextInput extends StatelessWidget {
  final String? hint;

  final TextEditingController textEditingController;

  const AppTextInput({super.key, required this.textEditingController, this.hint});

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    return TextFormField(
      focusNode: focusNode,
      controller: textEditingController,
      cursorColor: AppColors.mainGreen,
      style: AppTextStyles.defaultFontStyle(18),
      inputFormatters: [
        // LengthLimitingTextInputFormatter(characterCountLimit)
      ],
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.hintStyle(),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.headingColor)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.headingColor)),
      ),
    );
  }
}
