import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:rylax_admin/core/network/models/development_dto.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/utils/screen_size_utils.dart';
import 'package:rylax_admin/core/widgets/app_button_with_icon.dart';
import 'package:rylax_admin/features/buyers/buyers_home.dart';
import 'package:rylax_admin/features/dashboard/presentation/dashboard_data.dart';
import 'package:rylax_admin/features/developments/presentation/developments_home.dart';
import 'package:rylax_admin/features/settings/settings.dart';

import '../../../core/app-state/app_state.dart';
import '../../commercial/commercial_properties.dart';
import '../../developments/presentation/development_view.dart';
import '../../valuation/valuation_tool.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  Widget selectedWidget = DashboardData();

  void openDashboard(BuildContext context) {
    setState(() {
      selectedWidget = DashboardData();
    });
  }

  void openDevelopments(BuildContext context) {
    setState(() {
      context.read<AppState>().setView(AppView.developmentsView);

      selectedWidget = DevelopmentsHome(openDevelopmentView: openDevelopmentView);
    });
  }

  void openBuyers(BuildContext context) {
    setState(() {
      selectedWidget = BuyersHome();
    });
  }

  void openCommercial(BuildContext context) {
    setState(() {
      selectedWidget = CommercialProperties();
    });
  }

  void openValuationTool(BuildContext context) {
    setState(() {
      selectedWidget = ValuationTool();
    });
  }

  void openSettings(BuildContext context) {
    setState(() {
      selectedWidget = Settings();
    });
  }

  // Possible refactor this later to make the development-view make a http call.
  void openDevelopmentView(BuildContext context, DevelopmentDTO developmentDTO) {
    setState(() {
      context.read<AppState>().setView(AppView.developmentView);
      selectedWidget = DevelopmentView(developmentDTO: developmentDTO);
    });
  }

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
                AppButtonWithIcon(buttonText: "Dashboard", onPressed: () => openDashboard(context), icon: Icons.dashboard),
                SizedBox(height: 10),
                AppButtonWithIcon(buttonText: "Developments", onPressed: () => openDevelopments(context), icon: Icons.house),
                SizedBox(height: 10),
                AppButtonWithIcon(buttonText: "Commercial", onPressed: () => openCommercial(context), icon: Icons.house_siding),
                SizedBox(height: 10),
                AppButtonWithIcon(buttonText: "Valuation Tool", onPressed: () => openValuationTool(context), icon: Icons.attach_money),
                SizedBox(height: 10),
                AppButtonWithIcon(buttonText: "Buyers", onPressed: () => openBuyers(context), icon: Icons.people),
                SizedBox(height: 10),
                Spacer(),
                AppButtonWithIcon(buttonText: "Settings", onPressed: () => openSettings(context), icon: Icons.settings),
                SizedBox(height: 10),
              ],
            ),
          ),
          Container(
            width: ScreenSizeUtils.calculatePercentageWidth(context, 80),
            height: ScreenSizeUtils.calculatePercentageHeight(context, 100),
            color: AppColors.backgroundColor,
            child: selectedWidget,
          ),
        ],
      ),
    );
  }
}
