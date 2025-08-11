import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/utils/screen_size_utils.dart';
import '../../../../core/widgets/app_text.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSizeUtils.calculatePercentageWidth(context, 49),
      height: ScreenSizeUtils.calculatePercentageHeight(context, 100),
      decoration: BoxDecoration(
        color: AppColors.mainWhite,
        boxShadow: [
          BoxShadow(
            color: AppColors.headingColor,
            offset: Offset(4, 0), // Right side shadow
            blurRadius: 0.1,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: ScreenSizeUtils.calculatePercentageHeight(context, 15)),
            child: Center(
              child: Stack(
                children: [
                  Image(
                    height: ScreenSizeUtils.calculatePercentageHeight(context, 50),
                    width: ScreenSizeUtils.calculatePercentageWidth(context, 50),
                    image: AssetImage('resources/rylax_logo.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenSizeUtils.calculatePercentageHeight(context, 35)),
                    child: Center(child: AppText(textValue: "Admin", fontSize: 42)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
