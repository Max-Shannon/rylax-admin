import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/app_colors.dart';

class AppText extends StatelessWidget {
  final String textValue;
  final double fontSize;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextStyle? textStyle;

  const AppText({
    super.key,
    required this.textValue,
    required this.fontSize,
    this.fontColor,
    this.fontWeight,
    this.textAlign,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: GoogleFonts.lexend(
        textStyle:
            textStyle ??
            TextStyle(fontSize: fontSize, fontWeight: fontWeight ?? FontWeight.bold, color: fontColor ?? AppColors.headingColor),
      ),
      child: Text(textValue, textAlign: textAlign ?? TextAlign.center),
    );
  }
}
