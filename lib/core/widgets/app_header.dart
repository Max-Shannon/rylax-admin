import 'package:flutter/cupertino.dart';

import '../styles/app_colors.dart';
import '../utils/screen_size_utils.dart';
import 'app_text.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainWhite,
      width: ScreenSizeUtils.calculatePercentageWidth(context, 100),
      height: ScreenSizeUtils.calculatePercentageHeight(context, 10),
      child: AppText(textValue: "Header", fontSize: 32),
    );
  }
}
