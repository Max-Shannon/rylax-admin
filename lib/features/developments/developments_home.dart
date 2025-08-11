import 'package:flutter/material.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';

class DevelopmentsHome extends StatelessWidget {
  const DevelopmentsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: AppText(textValue: "Developments - WIP", fontSize: 24),
    );
  }
}
