import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/utils/font_size_utils.dart';
import '../../../../core/utils/screen_size_utils.dart';
import '../../../../core/widgets/app_text.dart';

class BuyerAssigmentDialog extends StatelessWidget {
  const BuyerAssigmentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double headingSize = FontSizeUtils.determineHeadingSize(context);
    return Dialog(
      backgroundColor: AppColors.mainWhite,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: ScreenSizeUtils.calculatePercentageHeight(context, 50),
        width: ScreenSizeUtils.calculatePercentageWidth(context, 60),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(textValue: "Assign Buyer", fontSize: headingSize),
              AppText(textValue: "Buyer Assignment WIP", fontSize: 16, fontWeight: FontWeight.w400),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
