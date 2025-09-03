import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rylax_admin/core/network/models/development_dto.dart';
import 'package:rylax_admin/core/network/models/valuation/res/rylax_valuation_response.dart';
import 'package:rylax_admin/features/dashboard/presentation/dashboard_home.dart';
import 'package:rylax_admin/features/developments/presentation/development_view.dart';
import 'package:rylax_admin/features/valuation/valuation_view.dart';

import '../../features/login/presentation/forgot_password.dart';
import '../../features/login/presentation/login_page.dart';
import '../app-state/app_state.dart';
import '../app-state/auth_gate.dart';

class NavigationService {
  void navigateToValuationView(BuildContext context, Future<RylaxValuationResponse> valuationResponse) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ValuationView(valuationResponse: valuationResponse)));
  }

  void navigateToAuthGate(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthGate()));
  }

  void navigateToForgotPassword(BuildContext context) {
    context.read<AppState>().setView(AppView.forgotPassword);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ForgotPassword()));
  }

  void navigateToLoginView(BuildContext context) {
    context.read<AppState>().setView(AppView.login);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void navigateToDashboardHome(BuildContext context) {
    context.read<AppState>().setView(AppView.dashboardHome);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashboardHome()));
  }

  void navigateToDevelopmentView(BuildContext context, DevelopmentDTO developmentDTO) {
    context.read<AppState>().setView(AppView.developmentView);
    context.read<AppState>().setSelectedDevelopmentId(developmentDTO.id);
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => DashboardHome(defaultWidget: DevelopmentView(developmentId: developmentDTO.id)),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        transitionsBuilder: (_, __, ___, child) => child, // no animation
      ),
    );
  }
}
