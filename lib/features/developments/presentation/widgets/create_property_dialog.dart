import 'package:flutter/material.dart';
import 'package:rylax_admin/core/network/models/create_property_request.dart';
import 'package:rylax_admin/core/services/rylax_api_service.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/utils/validation_utils.dart';

import '../../../../core/utils/font_size_utils.dart';
import '../../../../core/utils/screen_size_utils.dart';
import '../../../../core/widgets/app_form_submit_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/app_text_input_with_title.dart';

class CreatePropertyDialog extends StatefulWidget {
  const CreatePropertyDialog({super.key});

  @override
  State<CreatePropertyDialog> createState() => _CreatePropertyDialogState();
}

class _CreatePropertyDialogState extends State<CreatePropertyDialog> {
  final RylaxAPIService rylaxAPIService = RylaxAPIService();

  TextEditingController propertyNumberController = TextEditingController();
  TextEditingController phaseSelectorController = TextEditingController();
  TextEditingController bedController = TextEditingController();
  TextEditingController bathsController = TextEditingController();
  TextEditingController unitNameController = TextEditingController();
  TextEditingController unitCountController = TextEditingController();

  bool propertyNumberValidatedFailed = false;
  bool phaseValidatedFailed = false;
  bool bedsValidatedFailed = false;
  bool bathsValidatedFailed = false;
  bool unitNameValidatedFailed = false;
  bool unitCountValidatedFailed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    propertyNumberController.dispose();
    phaseSelectorController.dispose();
    bedController.dispose();
    bathsController.dispose();
    bathsController.dispose();
    unitCountController.dispose();
    super.dispose();
  }

  void refreshState(
    bool propertyNumberValidated,
    bool phaseValidated,
    bool bedsValidated,
    bool bathsValidated,
    bool unitNameValidated,
    bool unitCountValidated,
  ) {
    setState(() {
      // Reverse the boolean values so the errors don't show when the page opens.
      propertyNumberValidatedFailed = !propertyNumberValidated;
      phaseValidatedFailed = !phaseValidated;
      bedsValidatedFailed = !bedsValidated;
      bathsValidatedFailed = !bathsValidated;
      unitNameValidatedFailed = !unitNameValidated;
      unitCountValidatedFailed = !unitCountValidated;
    });
  }

  Future<void> onSubmit() async {
    bool propertyNumberSelected = ValidationUtils.validateNotEmpty(propertyNumberController.text);
    bool phaseSelected = ValidationUtils.validateNotEmpty(phaseSelectorController.text);
    bool bedsSelected = ValidationUtils.validateNotEmpty(bedController.text);
    bool bathsSelected = ValidationUtils.validateNotEmpty(bathsController.text);
    bool unitNameSelected = ValidationUtils.validateNotEmpty(unitNameController.text);
    bool unitCountSelected = ValidationUtils.validateNotEmpty(unitCountController.text);

    var propertyType = "NEW_BUILD_NEW";
    var createPropertyRequest = CreatePropertyRequest(propertyType);
    await rylaxAPIService.createProperty(100005, createPropertyRequest);

    if (propertyNumberSelected && phaseSelected && bedsSelected && bathsSelected && unitNameSelected && unitCountSelected) {
    //TODO:
    } else {
      refreshState(
        propertyNumberValidatedFailed,
        phaseValidatedFailed,
        bedsValidatedFailed,
        bathsValidatedFailed,
        unitNameValidatedFailed,
        unitCountValidatedFailed,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final headingSize = FontSizeUtils.determineHeadingSize(context);

    return Dialog(
      backgroundColor: AppColors.mainWhite,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: ScreenSizeUtils.calculatePercentageHeight(context, 95),
        width: ScreenSizeUtils.calculatePercentageWidth(context, 42.5),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(textValue: "Add New Property", fontSize: headingSize),
              const SizedBox(height: 6),
              const AppText(textValue: "Non-functional", fontSize: 14, fontWeight: FontWeight.w300),
              const SizedBox(height: 32),
              AppTextInputWithTitle(
                inputFailedValidation: propertyNumberValidatedFailed,
                textEditingController: propertyNumberController,
                validationFailedMessage: "Please enter a valid number",
                title: "Property Number",
              ),
              const SizedBox(height: 16),
              AppTextInputWithTitle(
                inputFailedValidation: phaseValidatedFailed,
                textEditingController: phaseSelectorController,
                validationFailedMessage: "Please enter a valid name",
                title: "Phase Selector",
              ),
              const SizedBox(height: 16),

              AppTextInputWithTitle(
                inputFailedValidation: bedsValidatedFailed,
                textEditingController: bedController,
                validationFailedMessage: "Please enter a valid number",
                title: "Beds",
              ),
              const SizedBox(width: 16),
              AppTextInputWithTitle(
                inputFailedValidation: bathsValidatedFailed,
                textEditingController: bathsController,
                validationFailedMessage: "Please enter a valid number",
                title: "Baths",
              ),

              const SizedBox(height: 16),
              AppTextInputWithTitle(
                inputFailedValidation: unitNameValidatedFailed,
                textEditingController: unitNameController,
                validationFailedMessage: "Please enter a valid text",
                title: "Unit Name",
              ),
              const SizedBox(height: 16),
              AppTextInputWithTitle(
                inputFailedValidation: unitCountValidatedFailed,
                textEditingController: unitCountController,
                validationFailedMessage: "Please enter a valid text",
                title: "Unit Count",
              ),
              const SizedBox(height: 12),
              AppText(textValue: "Note: Clean up, just making functional", fontSize: 14),
              SizedBox(height: 10),
              AppFormSubmitButton(label: "Create", function: () => onSubmit()),
            ],
          ),
        ),
      ),
    );
  }
}
