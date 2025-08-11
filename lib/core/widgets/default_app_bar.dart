import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../utils/font_size_utils.dart';
import '../utils/screen_size_utils.dart';
import 'app_text.dart';

class DefaultAppBar extends StatelessWidget {
  final Function toggleSettingsPanel;

  const DefaultAppBar({super.key, required this.toggleSettingsPanel});

  @override
  Widget build(BuildContext context) {
    return renderAppBarWidgetBasedOnScreenSize(context);
  }

  renderAppBarWidgetBasedOnScreenSize(BuildContext context) {
    double headingSize = FontSizeUtils.determineHeadingSize(context);
    if (ScreenSizeUtils.isMobileWidth(context)) {
      return mobileAppBar(context, headingSize);
    } else {
      return webAppBar(context, headingSize);
    }
  }

  mobileAppBar(BuildContext context, double headingSize) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mainWhite,
        boxShadow: [BoxShadow(color: AppColors.headingColorLight, blurRadius: 2.5, offset: Offset(0, 1))],
      ),
      child: Row(
        children: [
          SizedBox(height: 200, child: Image.asset('resources/rylax_logo.png')),
          AppText(textValue: "New Home Buyers Portal", fontSize: headingSize, fontWeight: FontWeight.bold),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(Icons.settings, size: 32, color: AppColors.headingColor),
              onPressed: () => toggleSettingsPanel(context),
            ),
          ),
        ],
      ),
    );
  }

  webAppBar(BuildContext context, double headingSize) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mainWhite,
        boxShadow: [BoxShadow(color: AppColors.headingColorLight, blurRadius: 2.5, offset: Offset(0, 1))],
      ),
      child: Row(
        children: [
          SizedBox(height: 200, child: Image.asset('resources/rylax_logo.png')),
          AppText(textValue: "New Home Buyers Portal", fontSize: headingSize, fontWeight: FontWeight.bold),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(Icons.settings, size: 32, color: AppColors.headingColor),
              onPressed: () => toggleSettingsPanel(context),
            ),
          ),
        ],
      ),
    );
  }
}
