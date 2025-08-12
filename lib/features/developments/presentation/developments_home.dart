import 'package:flutter/material.dart';
import 'package:rylax_admin/core/services/rylax_api_service.dart';

import 'development_card.dart';

class DevelopmentsHome extends StatelessWidget {
  final RylaxAPIService rylaxAPIService = RylaxAPIService();
  final Function openDevelopmentView;

  final int hardCodedBranchId = 101;

  DevelopmentsHome({super.key, required this.openDevelopmentView});

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

        final developments = snapshot.data?.developments;

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 4 / 3, // adjust to taste
          ),
          itemCount: developments?.length,
          itemBuilder: (context, index) {
            final dev = developments?[index];
            return DevelopmentCard(
              dev: dev,
              onTap: () {
                // TODO: navigate to development detail / properties list
                // Navigator.push(...);
                openDevelopmentView(context, dev);
              },
            );
          },
        );
      },
    );
  }
}
