import 'package:flutter/material.dart';

import '../../../core/styles/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class DashboardData extends StatelessWidget {
  const DashboardData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: AppText(textValue: "Dashboard Data - WIP", fontSize: 24),
    );
  }
}
