import 'package:flutter/material.dart';
import 'package:rylax_admin/core/network/models/development_dto.dart';
import 'package:rylax_admin/core/network/models/property_dto.dart';
import 'package:rylax_admin/core/utils/font_size_utils.dart';
import 'package:rylax_admin/core/widgets/app_icon_button.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';

import '../../../core/styles/app_colors.dart';

class DevelopmentView extends StatelessWidget {
  final DevelopmentDTO developmentDTO;

  const DevelopmentView({super.key, required this.developmentDTO});

  void doNothing() {}

  @override
  Widget build(BuildContext context) {
    double headingSize = FontSizeUtils.determineHeadingSize(context);
    double subtitleSize = FontSizeUtils.determineSubtitleSize(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: AppText(textValue: developmentDTO.developmentName, fontSize: headingSize),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                AppText(textValue: "Properties: 20", fontSize: subtitleSize),
                SizedBox(width: 20),
                AppText(textValue: "Buyers: 14", fontSize: subtitleSize),
                SizedBox(width: 20),
                AppText(textValue: "Verified Buyers: 9", fontSize: subtitleSize),
                SizedBox(width: 20),
                AppText(textValue: "Status: Active", fontSize: subtitleSize),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                AppIconButton(icon: Icons.add, label: "Add Property"),
                SizedBox(width: 20),
                AppIconButton(
                  icon: Icons.add_chart,
                  label: "View Snags",
                  foregroundColor: AppColors.mainGreen,
                  backgroundColor: AppColors.mainWhite,
                ),
                SizedBox(width: 20),
                AppIconButton(
                  icon: Icons.upload,
                  label: "Upload File",
                  foregroundColor: AppColors.mainGreen,
                  backgroundColor: AppColors.mainWhite,
                ),
                SizedBox(width: 20),
              ],
            ),
            Column(children: extractRowTextWidgets(developmentDTO)),
          ],
        ),
      ),
    );
  }

  List<Widget> extractRowTextWidgets(DevelopmentDTO developmentDTO) {
    List<Widget> textWidgets = [];
    var developmentPhases = developmentDTO.developmentPhases;

    for (var developmentPhase in developmentPhases) {
      for (var property in developmentPhase.properties) {
        var row = TableRow(property.propertyType, developmentPhase.phaseName, developmentPhase.phaseNumber);
        textWidgets.add(Text(row.toString(), style: const TextStyle(fontSize: 16)));
      }
    }
    return textWidgets;
  }
}

class TableRow {
  late String propertyType;
  late String phaseName;
  late int phaseNumber;

  TableRow(this.propertyType, this.phaseName, this.phaseNumber);

  @override
  String toString() {
    return 'TableRow{propertyType: $propertyType, phaseName: $phaseName, phaseNumber: $phaseNumber}';
  }
}
