import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rylax_admin/core/app-state/logged_in_container.dart';

import '../services/auth_service.dart';
import '../services/rylax_api_service.dart';
import 'app_state.dart';
import 'logged_out_container.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final RylaxAPIService rylaxAPIService = RylaxAPIService();

  @override
  void initState() {
    super.initState();
  }

  Widget determineWidget() {
    var loggedInUser = AuthService().getLoggedInUser();
    if (loggedInUser != null) {
      var userId = loggedInUser.uid;
      var displayName = loggedInUser.displayName;
      var email = loggedInUser.email;

      print("AuthGate - User is Logged in - Using LoggedInAuthenticationContainer");
      return LoggedInContainer();
    }

    return LoggedOutContainer();
  }

  @override
  Widget build(BuildContext context) {
    return determineWidget();
  }

  void setStepContext(BuildContext context) {
    context.read<AppState>().setView(AppView.dashboardHome);
  }
}
