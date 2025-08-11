import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rylax_admin/features/dashboard/dashboard_home.dart';

import 'app_state.dart';

class LoggedInContainer extends StatelessWidget {
  const LoggedInContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    switch (appState.currentView) {
      case AppView.dashboardHome:
        return DashboardHome();
      default:
        throw Exception();
    }
  }
}
