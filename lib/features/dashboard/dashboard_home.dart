import 'package:flutter/material.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/utils/screen_size_utils.dart';
import 'package:rylax_admin/core/widgets/app_button_with_icon.dart';

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  void doNothing() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Row(
        children: [
          Container(
            width: ScreenSizeUtils.calculatePercentageWidth(context, 20),
            height: ScreenSizeUtils.calculatePercentageHeight(context, 100),
            color: AppColors.mainWhite,
            child: Column(
              children: [
                Image(
                  height: ScreenSizeUtils.calculatePercentageHeight(context, 10),
                  width: ScreenSizeUtils.calculatePercentageWidth(context, 10),
                  image: AssetImage('resources/rylax_logo.png'),
                ),
                SizedBox(height: 10),
                AppButtonWithIcon(buttonText: "Dashboard", onPressed: doNothing, icon: Icons.dashboard),
                SizedBox(height: 10),
                AppButtonWithIcon(buttonText: "Developments", onPressed: doNothing, icon: Icons.house),
                SizedBox(height: 10),
                AppButtonWithIcon(buttonText: "Buyers", onPressed: doNothing, icon: Icons.people),
                SizedBox(height: 10),
                Spacer(),
                AppButtonWithIcon(buttonText: "Settings", onPressed: doNothing, icon: Icons.settings),
                SizedBox(height: 10),
              ],
            ),
          ),
          Container(
            width: ScreenSizeUtils.calculatePercentageWidth(context, 80),
            height: ScreenSizeUtils.calculatePercentageHeight(context, 100),
            color: AppColors.backgroundColor,
          ),
        ],
      ),
    );
  }
}
