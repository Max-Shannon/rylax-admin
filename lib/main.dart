import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rylax_admin/firebase_options.dart';

import 'core/app-state/app_state.dart';
import 'core/app-state/auth_gate.dart';
import 'core/styles/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final appState = AppState();
  await appState.restoreView();
  await appState.restoreSelectedDevelopmentId();

  runApp(RylaxAdmin(appState: appState));
}

class RylaxAdmin extends StatelessWidget {
  final AppState appState;

  const RylaxAdmin({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: appState,
      child: MaterialApp(
        title: 'Rylax Admin',
        theme: ThemeData(
          useMaterial3: true,
          bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
          textSelectionTheme: TextSelectionThemeData(selectionColor: AppColors.mainGreen, selectionHandleColor: AppColors.mainGreen),
        ),
        home: AuthGate(),
      ),
    );
  }
}
