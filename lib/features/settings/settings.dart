import 'package:flutter/material.dart';
import 'package:rylax_admin/core/services/auth_service.dart';
import 'package:rylax_admin/core/widgets/app_form_submit_button.dart';

import '../../core/styles/app_colors.dart';
import '../../core/widgets/app_text.dart';

class Settings extends StatelessWidget {
  final AuthService authService = AuthService();

  Settings({super.key});

  void signOut(BuildContext context) {
    authService.signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          AppText(textValue: "Settings - WIP", fontSize: 24),
          AppFormSubmitButton(label: "Sign out", function: () => signOut(context)),
        ],
      ),
    );
  }
}
