import 'package:flutter/material.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';

class CommercialProperties extends StatefulWidget {
  const CommercialProperties({super.key});

  @override
  State<CommercialProperties> createState() => _CommercialPropertiesState();
}

class _CommercialPropertiesState extends State<CommercialProperties> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: AppText(textValue: "Commercial Properties", fontSize: 24),
      ),
    );
  }
}
