import 'package:flutter/material.dart';

import '../../core/styles/app_colors.dart';
import '../../core/widgets/app_text.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: AppText(textValue: "Settings - WIP", fontSize: 24),
    );
  }

}