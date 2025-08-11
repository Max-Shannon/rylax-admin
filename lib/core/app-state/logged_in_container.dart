import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';

class LoggedInContainer extends StatelessWidget {
  const LoggedInContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    switch (appState.currentView) {
      default:
        throw Exception();
    }
  }
}
