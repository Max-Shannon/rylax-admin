import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../utils/font_size_utils.dart';
import '../utils/screen_size_utils.dart';
import 'app_text.dart';

class AppFormSubmitButton extends StatelessWidget {
  final String label;
  final Function function;

  const AppFormSubmitButton({super.key, required this.label, required this.function});

  @override
  Widget build(BuildContext context) {
    double headingSize = FontSizeUtils.determineHeadingSize(context);
    return SizedBox(
      width: ScreenSizeUtils.calculatePercentageWidth(context, 70),
      height: 50,
      child: ElevatedButton(
        onPressed: () => function(),
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2), // try 4–8 for subtle rounding
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.hovered)) {
              return AppColors.mainGreenHoovered;
            }
            return AppColors.mainGreen; // default
          }),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
        ),
        child: AppText(textValue: label, fontSize: headingSize, fontColor: AppColors.mainWhite),
      ),
    );
  }
}
