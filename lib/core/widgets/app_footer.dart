import 'package:flutter/material.dart';

import '../utils/screen_size_utils.dart';
import 'app_text.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: ScreenSizeUtils.calculatePercentageWidth(context, 100),
      height: ScreenSizeUtils.calculatePercentageHeight(context, 10),
      child: AppText(textValue: "Footer", fontSize: 32),
    );
  }
}
