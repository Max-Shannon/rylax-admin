import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  static TextStyle defaultWhiteFontStyle() {
    return GoogleFonts.lexend(textStyle: TextStyle(color: AppColors.mainWhite));
  }

  static TextStyle hintStyle() {
    return GoogleFonts.lexend(textStyle: TextStyle(color: AppColors.headingColorLight));
  }

  static TextStyle defaultFontStyle(double fontSize) {
    return GoogleFonts.lexend(
      textStyle: TextStyle(fontSize: fontSize, color: AppColors.headingColor),
    );
  }

  static TextStyle defaultUnderlinedFont(double fontSize) {
    return GoogleFonts.lexend(
      textStyle: TextStyle(
        decoration: TextDecoration.underline,
        color: AppColors.headingColor,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
