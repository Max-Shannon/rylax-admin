import 'package:flutter/material.dart';
import 'package:rylax_admin/core/network/models/create_development_phase_request.dart';
import 'package:rylax_admin/core/network/models/development_dto.dart';
import 'package:rylax_admin/core/services/rylax_api_service.dart';
import 'package:rylax_admin/core/utils/font_size_utils.dart';
import 'package:rylax_admin/core/utils/snack_barz.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/utils/screen_size_utils.dart';
import '../../../../core/utils/validation_utils.dart';
import '../../../../core/widgets/app_form_submit_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/app_text_input_with_title.dart';

class CreateDevelopmentPhaseDialog extends StatefulWidget {
  final DevelopmentDTO developmentDTO;

  const CreateDevelopmentPhaseDialog({super.key, required this.developmentDTO});

  @override
  State<CreateDevelopmentPhaseDialog> createState() => _CreateDevelopmentPhaseState();
}

class _CreateDevelopmentPhaseState extends State<CreateDevelopmentPhaseDialog> {
  final RylaxAPIService rylaxAPIService = RylaxAPIService();

  TextEditingController phaseNameController = TextEditingController();
  TextEditingController phaseNumberController = TextEditingController();

  bool phaseNamedValidationFailed = false;
  bool phaseNumberValidationFailed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    phaseNameController.dispose();
    phaseNumberController.dispose();
    super.dispose();
  }

  void refreshState(bool phaseNameValidated, bool phaseNumberValidated) {
    setState(() {
      // Reverse the boolean values so the errors don't show when the page opens.
      phaseNamedValidationFailed = !phaseNameValidated;
      phaseNumberValidationFailed = !phaseNumberValidated;
    });
  }

  Future<void> onSubmit() async {
    bool phaseNameSelected = ValidationUtils.validateNotEmpty(phaseNameController.text);
    bool phaseNumberSelected = ValidationUtils.validateNotEmpty(phaseNumberController.text);
    if (phaseNameSelected && phaseNumberSelected) {
      int? phaseNumber = int.parse(phaseNumberController.text);
      var createDevelopmentPhaseReq = CreateDevelopmentPhaseRequest(
        phaseNameController.text,
        phaseNumber,
        DateTime.now(),
        DateTime.now(),
      );

      await rylaxAPIService.createDevelopmentPhase(widget.developmentDTO.id, createDevelopmentPhaseReq);
      SnackBarz.showSnackBar(context, AppColors.mainGreen, "Phase Added");
      Navigator.pop(context);

    } else {
      refreshState(phaseNamedValidationFailed, phaseNumberValidationFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    double headingSize = FontSizeUtils.determineHeadingSize(context);
    return Dialog(
      backgroundColor: AppColors.mainWhite,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: ScreenSizeUtils.calculatePercentageHeight(context, 40),
        width: ScreenSizeUtils.calculatePercentageWidth(context, 30),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(textValue: "Add New Phase", fontSize: headingSize),
              const SizedBox(height: 6),
              const SizedBox(height: 32),
              AppTextInputWithTitle(
                inputFailedValidation: phaseNamedValidationFailed,
                textEditingController: phaseNameController,
                validationFailedMessage: "Please enter a valid name",
                title: "Phase Name",
              ),
              const SizedBox(height: 16),
              AppTextInputWithTitle(
                inputFailedValidation: phaseNumberValidationFailed,
                textEditingController: phaseNumberController,
                validationFailedMessage: "Please enter a valid number",
                title: "Phase Selector",
              ),
              const SizedBox(height: 16),
              SizedBox(height: 10),
              AppFormSubmitButton(label: "Create", function: () => onSubmit()),
            ],
          ),
        ),
      ),
    );
  }
}
