import 'package:flutter/material.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/styles/app_text_styles.dart';
import 'package:rylax_admin/core/utils/font_size_utils.dart';

import 'app_text.dart';

class AppButtonWithIcon extends StatelessWidget {
  final String buttonText;
  final IconData icon;
  final VoidCallback onPressed;

  const AppButtonWithIcon({super.key, required this.buttonText, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    double headingSize = FontSizeUtils.determineHeadingSize(context);
    return SizedBox(
      width: 400, // sidebar width
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: AppColors.mainGreen),
        label: AppText(textValue: buttonText, fontSize: 18),
        style: ButtonStyle(
          alignment: Alignment.centerLeft,
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
          shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.zero, side: BorderSide.none)),
          elevation: WidgetStateProperty.all(0),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
          overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.pressed)) {
              return AppColors.mainGreen.withValues(alpha: 0.2);
            }
            if (states.contains(WidgetState.hovered)) {
              return Colors.white.withValues(alpha: 0.1);
            }
            return Colors.transparent;
          }),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.hovered)) {
              return Colors.white.withValues(alpha: 0.25);
            }
            return AppColors.mainWhite;
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.hovered)) {
              return AppColors.mainWhite;
            }
            return Colors.white;
          }),
          textStyle: WidgetStateProperty.all(AppTextStyles.defaultFontStyle2(headingSize)),
        ),
      ),
    );
  }
}
