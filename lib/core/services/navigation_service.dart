import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rylax_admin/features/dashboard/dashboard_home.dart';

import '../../features/login/presentation/forgot_password.dart';
import '../../features/login/presentation/login_page.dart';
import '../app-state/app_state.dart';
import '../app-state/auth_gate.dart';

class NavigationService {
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
}
