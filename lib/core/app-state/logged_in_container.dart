import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rylax_admin/core/network/models/development_dto.dart';
import 'package:rylax_admin/features/dashboard/presentation/dashboard_home.dart';
import 'package:rylax_admin/features/developments/presentation/development_view.dart';
import 'package:rylax_admin/features/developments/presentation/developments_home.dart';

import 'app_state.dart';

class LoggedInContainer extends StatelessWidget {
  const LoggedInContainer({super.key});

  void doNothing() {}

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    print("loggedInContainer");
    switch (appState.currentView) {
      case AppView.dashboardHome:
        return DashboardHome();
      case AppView.developmentsView:
        return DevelopmentsHome(openDevelopmentView: doNothing);
      case AppView.developmentView:
        return DevelopmentView(developmentDTO: DevelopmentDTO());
      default:
        throw Exception();
    }
  }
}
