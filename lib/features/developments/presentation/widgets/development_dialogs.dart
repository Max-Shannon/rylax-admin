import 'package:flutter/material.dart';
import 'package:rylax_admin/core/utils/font_size_utils.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';

class DevelopmentDialogs {
  static void showCreateDevelopmentPhaseDialog(BuildContext context) {
    double headingSize = FontSizeUtils.determineHeadingSize(context);
    TextEditingController phaseNameController = TextEditingController();
    TextEditingController phaseNumberController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            height: 400,
            width: 350,
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(minWidth: 250, maxWidth: 800, maxHeight: 600),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppText(textValue: "Add New Phase", fontSize: headingSize),
                SizedBox(height: 100),
                AppText(textValue: "Placeholder (WIP)", fontSize: 14, fontWeight: FontWeight.w400),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showCreatePropertyDialog(BuildContext context) {
    double headingSize = FontSizeUtils.determineHeadingSize(context);
    TextEditingController phaseNameController = TextEditingController();
    TextEditingController phaseNumberController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            height: 400,
            width: 350,
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(minWidth: 250, maxWidth: 800, maxHeight: 600),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppText(textValue: "Add New Property", fontSize: headingSize),
                SizedBox(height: 100),
                AppText(textValue: "Placeholder (WIP)", fontSize: 14, fontWeight: FontWeight.w400),
              ],
            ),
          ),
        );
      },
    );
  }
}
