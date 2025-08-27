import 'package:flutter/material.dart';
import 'package:rylax_admin/core/network/models/create_property_request.dart';
import 'package:rylax_admin/core/network/models/development_dto.dart';
import 'package:rylax_admin/core/services/rylax_api_service.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/utils/validation_utils.dart';
import 'package:rylax_admin/features/developments/presentation/widgets/int_drop_down_menu.dart';
import 'package:rylax_admin/features/developments/presentation/widgets/phase_dropdown.dart';

import '../../../../core/utils/font_size_utils.dart';
import '../../../../core/utils/screen_size_utils.dart';
import '../../../../core/utils/snack_barz.dart';
import '../../../../core/widgets/app_form_submit_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/app_text_input_with_title.dart';

class CreatePropertyDialog extends StatefulWidget {
  final DevelopmentDTO developmentDTO;

  const CreatePropertyDialog({super.key, required this.developmentDTO});

  @override
  State<CreatePropertyDialog> createState() => _CreatePropertyDialogState();
}

class _CreatePropertyDialogState extends State<CreatePropertyDialog> {
  final RylaxAPIService rylaxAPIService = RylaxAPIService();

  TextEditingController propertyNumberController = TextEditingController();
  TextEditingController unitTypeController = TextEditingController();

  bool propertyNumberValidatedFailed = false;
  bool phaseValidatedFailed = false;
  bool bedsValidatedFailed = false;
  bool bathsValidatedFailed = false;
  bool unitTypeValidatedFailed = false;
  bool unitCountValidatedFailed = false;

  int? _selectedPhaseId;
  int? _unitCount;
  int? _bedsSelected;
  int? _bathsSelected;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    propertyNumberController.dispose();
    super.dispose();
  }

  void refreshState(bool phaseValidated, bool bedsValidated, bool bathsValidated, bool unitNameValidated, bool unitCountValidated) {
    setState(() {
      // Reverse the boolean values so the errors don't show when the page opens.
      phaseValidatedFailed = !phaseValidated;
      bedsValidatedFailed = !bedsValidated;
      bathsValidatedFailed = !bathsValidated;
      unitTypeValidatedFailed = !unitNameValidated;
      unitCountValidatedFailed = !unitCountValidated;
    });
  }

  Future<void> onSubmit() async {
    bool unitTypeSelected = ValidationUtils.validateNotEmpty(unitTypeController.text);
    bool phaseSelected = ValidationUtils.validateSelected(_selectedPhaseId!);
    bool bedsSelected = ValidationUtils.validateSelected(_bedsSelected!);
    bool bathsSelected = ValidationUtils.validateSelected(_bathsSelected!);
    bool unitCountSelected = ValidationUtils.validateSelected(_unitCount!);

    if (phaseSelected && bedsSelected && bathsSelected && unitTypeSelected && unitCountSelected) {
      //TODO: Commit when this is working, then refactor to include the other bits. Such as sqm, price etc.

      var propertyType = "NEW_BUILD";
      var propertyStyle = "END_OF_TERRACE";
      var sqm = 102;
      var price = 495000;

      var createPropertyRequest = CreatePropertyRequest(
        propertyType,
        propertyStyle,
        unitTypeController.text,
        _unitCount!,
        _bedsSelected!,
        _bathsSelected!,
        sqm,
        price,
      );

      var success = await rylaxAPIService.createProperty(_selectedPhaseId!, createPropertyRequest);
      if (success) {
        Navigator.pop(context);
        SnackBarz.showSnackBar(context, AppColors.mainGreen, "Property Created Successfully");
      } else {
        SnackBarz.showSnackBar(context, AppColors.mainRed, "Failed to create property, contact support");
      }
    } else {
      refreshState(propertyNumberValidatedFailed, phaseValidatedFailed, bedsValidatedFailed, bathsValidatedFailed, unitTypeValidatedFailed);
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
              const SizedBox(height: 32),

              AppTextInputWithTitle(
                inputFailedValidation: unitTypeValidatedFailed,
                textEditingController: unitTypeController,
                validationFailedMessage: "Please enter a valid text",
                title: "Unit Type",
              ),
              const SizedBox(height: 16),

              // This needs to be a drop-down based on the phases set out for this development.
              PhaseDropdown(
                phases: widget.developmentDTO.developmentPhases,
                onChanged: (int? id) {
                  setState(() => _selectedPhaseId = id);
                  // call your API with the chosen id
                  // await apiClient.assignPhase(id!);
                },
              ),

              const SizedBox(height: 16),

              IntDropDownMenu(label: "Beds", onChanged: (bedsSelected) => setState(() => _bedsSelected = bedsSelected)),
              const SizedBox(height: 16),

              IntDropDownMenu(label: "Baths", onChanged: (bathsSelected) => setState(() => _bathsSelected = bathsSelected)),
              const SizedBox(height: 16),

              IntDropDownMenu(label: "Unit Count", onChanged: (unitCount) => setState(() => _unitCount = unitCount)),
              const SizedBox(height: 16),

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
