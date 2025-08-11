import 'package:flutter/material.dart';
import 'package:rylax_admin/core/services/rylax_api_service.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';

class DevelopmentsHome extends StatelessWidget {
  final RylaxAPIService rylaxAPIService = RylaxAPIService();

  final int hardCodedBranchId = 101;

  DevelopmentsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: rylaxAPIService.getDevelopmentsForAgent(hardCodedBranchId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          print(snapshot.error);
          return Scaffold(body: Center(child: Text('Error loading developments')));
        }

        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: AppText(textValue: snapshot.data!.developments.toString(), fontSize: 24),
        );
      },
    );
  }
}
