import 'package:flutter/cupertino.dart';
import 'package:rylax_admin/core/utils/screen_size_utils.dart';

class FontSizeUtils {
  static double calculateFontSize(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width / 100 * percentage;
  }

  static double fixedHeadingSize(BuildContext context) {
    return MediaQuery.of(context).size.width / 100 * 3.5;
  }

  static double determineHeadingSize(BuildContext context) {
    if (ScreenSizeUtils.isMobileWidth(context)) {
      return mobileHeadingSize();
    }

    return webHeadingSize();
  }

  static double determineSubtitleSize(BuildContext context) {
    if (ScreenSizeUtils.isMobileWidth(context)) {
      return mobileSubtitleSize();
    }

    return webSubtitleSize();
  }

  static double determineNoteSize(BuildContext context) {
    if (ScreenSizeUtils.isMobileWidth(context)) {
      return mobileNoteSize();
    }

    return webNoteSize();
  }

  static double webHeadingSize() {
    return 22;
  }

  static double mobileHeadingSize() {
    return 18;
  }

  static double webSubtitleSize() {
    return 18;
  }

  static double mobileSubtitleSize() {
    return 16;
  }

  static double webNoteSize() {
    return 14;
  }

  static double mobileNoteSize() {
    return 12;
  }
}
