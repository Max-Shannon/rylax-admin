import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import '../styles/app_text_styles.dart';
import '../utils/font_size_utils.dart';

class AppLinkedText extends StatelessWidget {
  final String preText;
  final String linkText;
  final Function linkTappedFunction;

  const AppLinkedText({super.key, required this.linkTappedFunction, required this.preText, required this.linkText});

  @override
  Widget build(BuildContext context) {
    double headingSize = FontSizeUtils.determineHeadingSize(context);
    return RichText(
      text: TextSpan(
        text: preText,
        style: AppTextStyles.defaultFontStyle(headingSize),
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = () => linkTappedFunction(context),
            text: linkText,
            style: AppTextStyles.defaultUnderlinedFont(headingSize),
          ),
        ],
      ),
    );
  }
}
