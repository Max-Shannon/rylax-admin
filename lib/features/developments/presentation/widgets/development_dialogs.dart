import 'package:flutter/material.dart';
import 'package:rylax_admin/core/utils/font_size_utils.dart';
import 'package:rylax_admin/core/utils/screen_size_utils.dart';
import 'package:rylax_admin/core/widgets/app_form_submit_button.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';
import 'package:rylax_admin/core/widgets/app_text_input_with_title.dart';
import 'package:rylax_admin/core/widgets/date_picker_field.dart';

class DevelopmentDialogs {
  static void doNothing() {}

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
            height: ScreenSizeUtils.calculatePercentageHeight(context, 42.5),
            width: ScreenSizeUtils.calculatePercentageWidth(context, 25),
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(minWidth: 250, maxWidth: 800, maxHeight: 600),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppText(textValue: "Add New Phase", fontSize: headingSize),
                AppText(textValue: "Non-functional", fontSize: 14, fontWeight: FontWeight.w300),
                SizedBox(height: 40),
                AppTextInputWithTitle(
                  textEditingController: phaseNameController,
                  validationFailedMessage: "Please enter a valid name",
                  title: "Phase Name",
                ),

                SizedBox(height: 20),
                AppTextInputWithTitle(
                  textEditingController: phaseNumberController,
                  validationFailedMessage: "Please enter a valid number",
                  title: "Phase Number",
                ),

                AppText(textValue: "Note: We can add dates? Not sure if relevant. Start/End Estimates", fontSize: 14),
                SizedBox(height: 10),
                AppFormSubmitButton(label: "Create", function: () => doNothing()),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showCreatePropertyDialog(BuildContext context) {
    double headingSize = FontSizeUtils.determineHeadingSize(context);
    TextEditingController propertyNumber = TextEditingController();
    TextEditingController phaseSelector = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            height: ScreenSizeUtils.calculatePercentageHeight(context, 65),
            width: ScreenSizeUtils.calculatePercentageWidth(context, 42.5),
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(minWidth: 250, maxWidth: 800, maxHeight: 600),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppText(textValue: "Add New Property", fontSize: headingSize),
                AppText(textValue: "Non-functional", fontSize: 14, fontWeight: FontWeight.w300),
                SizedBox(height: 40),
                AppTextInputWithTitle(
                  textEditingController: phaseSelector,
                  validationFailedMessage: "Please enter a valid name",
                  title: "Phase Selector",
                ),

                SizedBox(height: 20),
                AppTextInputWithTitle(
                  textEditingController: phaseSelector,
                  validationFailedMessage: "Please enter a valid number",
                  title: "Beds",
                ),

                AppTextInputWithTitle(
                  textEditingController: phaseSelector,
                  validationFailedMessage: "Please enter a valid number",
                  title: "Baths",
                ),

                AppTextInputWithTitle(
                  textEditingController: phaseSelector,
                  validationFailedMessage: "Please enter a valid number",
                  title: "Unit Name",
                ),

                AppText(textValue: "Note: Clean up, just making functional", fontSize: 14),
                SizedBox(height: 10),
                AppFormSubmitButton(label: "Create", function: () => doNothing()),
              ],
            ),
          ),
        );
      },
    );
  }
}
