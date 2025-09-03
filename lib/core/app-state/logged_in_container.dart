import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rylax_admin/features/dashboard/presentation/dashboard_home.dart';
import 'package:rylax_admin/features/developments/presentation/development_view.dart';
import 'package:rylax_admin/features/developments/presentation/developments_home.dart';
import 'package:rylax_admin/features/valuation/valuation_tool.dart';

import 'app_state.dart';

class LoggedInContainer extends StatelessWidget {
  const LoggedInContainer({super.key});

  void doNothing() {}

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    var currentView = appState.currentView;

    print("LoggedInContainer - appState.view: $currentView");

    switch (appState.currentView) {
      case AppView.dashboardHome:
        return DashboardHome();

      // First problem, we need to have a method to open each development.
      case AppView.developmentsView:
        return DashboardHome(defaultWidget: DevelopmentsHome());

      case AppView.developmentView:
        var developmentId = appState.selectedDevelopmentID;
        print("LoggedInContainner - developmentView - developmentId: $developmentId");
        return DashboardHome(defaultWidget: DevelopmentView(developmentId: developmentId));

      case AppView.valuationTool:
        return DashboardHome(defaultWidget: ValuationTool());

      default:
        throw Exception();
    }
  }
}
