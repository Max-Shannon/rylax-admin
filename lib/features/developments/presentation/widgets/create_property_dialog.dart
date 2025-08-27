import 'package:flutter/material.dart';
import 'package:rylax_admin/core/network/models/create_property_request.dart';
import 'package:rylax_admin/core/network/models/development_dto.dart';
import 'package:rylax_admin/core/services/rylax_api_service.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/utils/validation_utils.dart';
import 'package:rylax_admin/features/developments/presentation/widgets/int_drop_down_menu.dart';
import 'package:rylax_admin/features/developments/presentation/widgets/phase_dropdown.dart';
import 'package:rylax_admin/features/developments/presentation/widgets/property_style_drop_down.dart';

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
  TextEditingController sqmController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool propertyStyleValidatedFailed = false;
  bool phaseValidatedFailed = false;
  bool bedsValidatedFailed = false;
  bool bathsValidatedFailed = false;
  bool sqmValidatedFailed = false;
  bool priceValidatedFailed = false;
  bool unitTypeValidatedFailed = false;
  bool unitCountValidatedFailed = false;

  int? _selectedPhaseId;
  int? _unitCount;
  int? _bedsSelected;
  int? _bathsSelected;
  String? _styleSelected;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    propertyNumberController.dispose();
    super.dispose();
  }

  void refreshState(
    bool propertyStyleValidated,
    bool phaseValidated,
    bool bedsValidated,
    bool bathsValidated,
    bool sqmValidated,
    bool priceValidated,
    bool unitTypeValidated,
    bool unitCountValidated,
  ) {
    setState(() {
      // Reverse the boolean values so the errors don't show when the page opens.
      propertyStyleValidatedFailed = !propertyStyleValidated;
      phaseValidatedFailed = !phaseValidated;
      bedsValidatedFailed = !bedsValidated;
      bathsValidatedFailed = !bathsValidated;
      sqmValidatedFailed = !sqmValidated;
      priceValidatedFailed = !priceValidated;
      unitTypeValidatedFailed = !unitTypeValidated;
      unitCountValidatedFailed = !unitCountValidated;
    });
  }

  Future<void> onSubmit() async {
    bool unitTypeSelected = ValidationUtils.validateNotEmpty(unitTypeController.text);
    bool propertyStyleSelected = ValidationUtils.validateNotEmpty(_styleSelected!);
    bool phaseSelected = ValidationUtils.validateSelected(_selectedPhaseId!);
    bool bedsSelected = ValidationUtils.validateSelected(_bedsSelected!);
    bool bathsSelected = ValidationUtils.validateSelected(_bathsSelected!);
    bool sqmSelected = ValidationUtils.validateNotEmpty(sqmController.text);
    bool priceSelected = ValidationUtils.validateNotEmpty(priceController.text);
    bool unitCountSelected = ValidationUtils.validateSelected(_unitCount!);

    if (unitTypeSelected &&
        propertyStyleSelected &&
        phaseSelected &&
        bedsSelected &&
        bathsSelected &&
        sqmSelected &&
        priceSelected &&
        unitTypeSelected &&
        unitCountSelected) {

      var propertyType = "NEW_BUILD";
      var sqm = int.parse(sqmController.text);
      var price = int.parse(priceController.text);

      var createPropertyRequest = CreatePropertyRequest(
        propertyType,
        _styleSelected!,
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
      refreshState(
        propertyStyleValidatedFailed,
        phaseValidatedFailed,
        bedsValidatedFailed,
        bathsValidatedFailed,
        sqmValidatedFailed,
        priceValidatedFailed,
        unitTypeValidatedFailed,
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
              const SizedBox(height: 32),

              AppTextInputWithTitle(
                inputFailedValidation: unitTypeValidatedFailed,
                textEditingController: unitTypeController,
                validationFailedMessage: "Please enter a valid text",
                title: "Unit Type",
              ),
              const SizedBox(height: 16),

              AppTextInputWithTitle(
                inputFailedValidation: sqmValidatedFailed,
                textEditingController: sqmController,
                validationFailedMessage: "Please enter a valid text",
                title: "Sqm",
              ),
              const SizedBox(height: 16),

              AppTextInputWithTitle(
                inputFailedValidation: priceValidatedFailed,
                textEditingController: priceController,
                validationFailedMessage: "Please enter a valid text",
                title: "Price",
              ),
              const SizedBox(height: 16),

              PropertyStyleDropdown(
                label: 'Property Style',
                selectedValue: _styleSelected,
                required: true,
                onChanged: (propertyStyle) => setState(() => _styleSelected = propertyStyle), // v is like 'MID_TERRACE'
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
