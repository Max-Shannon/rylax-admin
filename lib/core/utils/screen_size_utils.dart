import 'package:flutter/cupertino.dart';

class ScreenSizeUtils {
  static double calculatePercentageHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height / 100 * percentage;
  }

  static double calculatePercentageWidth(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width / 100 * percentage;
  }

  static bool isMobileWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 600; // <600px considered mobile width
  }

  static bool isTabletWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1024; // Typical tablet range
  }

  static bool isSmallScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 1024 && width < 1440;
  }
}
