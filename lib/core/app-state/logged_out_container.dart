import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../features/login/presentation/login_page.dart';
import 'app_state.dart';

class LoggedOutContainer extends StatelessWidget {
  const LoggedOutContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    switch (appState.currentView) {
      case AppView.login:
        return LoginPage();
      default:
        throw Exception();
    }
  }
}
