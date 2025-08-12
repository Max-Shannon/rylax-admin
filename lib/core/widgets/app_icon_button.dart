import 'package:flutter/material.dart';
import 'package:rylax_admin/core/styles/app_text_styles.dart';

import '../styles/app_colors.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onPressed;

  /// Tweakables (optional)
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color foregroundColor;

  const AppIconButton({
    super.key,
    required this.icon,
    required this.label,
    this.borderRadius = 2, // "slightly rounded"
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.backgroundColor = AppColors.mainGreen,
    this.foregroundColor = AppColors.mainWhite,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: TextButton.icon(
        onPressed: () => onPressed(),
        icon: Icon(icon), // <-- change me
        label: Text(label), // <-- and me
        style: TextButton.styleFrom(
          textStyle: AppTextStyles.defaultFontStyle(18),
          foregroundColor: foregroundColor, // icon & text color
          backgroundColor: backgroundColor, // button fill
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius), // "slightly rounded"
          ),
        ),
      ),
    );
  }
}
