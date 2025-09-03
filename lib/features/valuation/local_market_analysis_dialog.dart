import 'package:flutter/material.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';

import '../../core/styles/app_colors.dart';
import '../../core/utils/screen_size_utils.dart';

class LocalMarketAnalysisDialog extends StatelessWidget {
  final String analysisSummary;

  const LocalMarketAnalysisDialog({super.key, required this.analysisSummary});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.mainWhite,

      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        child: Container(
          height: ScreenSizeUtils.calculatePercentageHeight(context, 70),
          width: ScreenSizeUtils.calculatePercentageWidth(context, 60),
          child: Align(alignment: Alignment.centerLeft, child: AppText(textValue: analysisSummary, fontSize: 12)),
        ),
      ),
    );
  }
}
