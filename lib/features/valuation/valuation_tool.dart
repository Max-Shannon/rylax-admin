import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';

class ValuationTool extends StatelessWidget {
  const ValuationTool({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: AppText(textValue: "Valuation Tool", fontSize: 24),
      ),
    );
  }
}
