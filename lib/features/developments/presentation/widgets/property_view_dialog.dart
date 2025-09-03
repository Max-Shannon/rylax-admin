import 'package:flutter/material.dart';
import 'package:rylax_admin/core/network/models/development_dto.dart';
import 'package:rylax_admin/core/network/models/property_dto.dart';
import 'package:rylax_admin/core/services/rylax_api_service.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/widgets/app_notes_box.dart';
import 'package:rylax_admin/features/developments/presentation/widgets/int_drop_down_menu.dart';
import 'package:rylax_admin/features/developments/presentation/widgets/phase_dropdown.dart';
import 'package:rylax_admin/features/developments/presentation/widgets/property_style_drop_down.dart';

import '../../../../core/utils/font_size_utils.dart';
import '../../../../core/utils/screen_size_utils.dart';
import '../../../../core/utils/snack_barz.dart';
import '../../../../core/widgets/app_form_submit_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/app_text_input_with_title.dart';

class PropertyViewDialog extends StatefulWidget {
  final PropertyDTO propertyDTO;
  final DevelopmentDTO developmentDTO;

  const PropertyViewDialog({super.key, required this.propertyDTO, required this.developmentDTO});

  @override
  State<PropertyViewDialog> createState() => PropertyViewDialogState();
}

class PropertyViewDialogState extends State<PropertyViewDialog> {
  final RylaxAPIService rylaxAPIService = RylaxAPIService();

  final TextEditingController unitTypeController = TextEditingController();
  final TextEditingController sqmController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  bool propertyStyleValidatedFailed = false;
  bool phaseValidatedFailed = false;
  bool bedsValidatedFailed = false;
  bool bathsValidatedFailed = false;
  bool sqmValidatedFailed = false;
  bool priceValidatedFailed = false;
  bool unitTypeValidatedFailed = false;

  // NEW: checkbox state
  bool _updateAllSameUnit = false;

  int? _selectedPhaseId;
  int? _unitCount;
  int? _bedsSelected;
  int? _bathsSelected;
  String? _styleSelected;
  String _propertyType = 'NEW_BUILD'; // fallback if DTO doesn’t have it

  @override
  void initState() {
    super.initState();
    // Prefill from DTO (adjust propertyDTO field names if different)
    unitTypeController.text = widget.propertyDTO.unitType ?? '';
    sqmController.text = (widget.propertyDTO.sqm ?? '').toString();
    priceController.text = (widget.propertyDTO.price ?? '').toString();
    _selectedPhaseId = findPhaseForProperty(widget.propertyDTO, widget.developmentDTO);
    _styleSelected = widget.propertyDTO.propertyStyle;
    _bedsSelected = widget.propertyDTO.beds;
    _bathsSelected = widget.propertyDTO.baths; // ensure your DTO exposes this
    _propertyType = widget.propertyDTO.propertyType ?? _propertyType;
  }

  @override
  void dispose() {
    unitTypeController.dispose();
    sqmController.dispose();
    priceController.dispose();
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
    setState(() {});
  }

  Future<void> onSubmit() async {
    try {
      final sqm = int.tryParse(sqmController.text);
      final price = int.tryParse(priceController.text);

      if (sqm == null || price == null) {
        SnackBarz.showSnackBar(context, AppColors.mainRed, 'SQM and Price must be valid numbers.');
        return;
      }

      var success = true; // <— adjust if needed

      if (success) {
        if (mounted) Navigator.pop(context);
        if (mounted) SnackBarz.showSnackBar(context, AppColors.mainGreen, 'Property updated successfully');
      } else {
        if (mounted) SnackBarz.showSnackBar(context, AppColors.mainRed, 'Failed to update property, contact support');
      }
    } on Exception {
      SnackBarz.showSnackBar(context, AppColors.mainRed, 'Failed to update property, check entered fields.');
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
        height: ScreenSizeUtils.calculatePercentageHeight(context, 80),
        width: ScreenSizeUtils.calculatePercentageWidth(context, 70),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(textValue: 'Edit Property', fontSize: headingSize),
              AppText(textValue: 'Non - Functional Placeholder', fontSize: 14, fontWeight: FontWeight.w400),
              const SizedBox(height: 24),
              // Row 1: Unit Type
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AppTextInputWithTitle(
                      inputFailedValidation: unitTypeValidatedFailed,
                      textEditingController: unitTypeController,
                      validationFailedMessage: 'Please enter a valid unit type',
                      title: 'Unit Type',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppTextInputWithTitle(
                      inputFailedValidation: sqmValidatedFailed,
                      textEditingController: sqmController,
                      validationFailedMessage: 'Please enter a valid SQM',
                      title: 'Sqm',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppTextInputWithTitle(
                      inputFailedValidation: priceValidatedFailed,
                      textEditingController: priceController,
                      validationFailedMessage: 'Please enter a valid price',
                      title: 'Price',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Row 3: Property Style | Phase
              Row(
                children: [
                  Expanded(
                    child: PropertyStyleDropdown(
                      inputFailedValidation: propertyStyleValidatedFailed,
                      label: 'Property Style',
                      selectedValue: _styleSelected,
                      required: true,
                      // inside this widget, ensure DropdownButton/FormField sets isExpanded: true
                      onChanged: (style) => setState(() => _styleSelected = style),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: PhaseDropdown(
                      inputFailedValidation: phaseValidatedFailed,
                      phases: widget.developmentDTO.developmentPhases,
                      selectedPhaseId: _selectedPhaseId,
                      onChanged: (int? id) => setState(() => _selectedPhaseId = id),
                      // ensure internal dropdown uses isExpanded: true as well
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Row 4: Beds | Baths
              Row(
                children: [
                  Expanded(
                    child: IntDropDownMenu(
                      inputFailedValidation: bedsValidatedFailed,
                      label: 'Beds',
                      selectedNumber: _bedsSelected,
                      required: true,
                      onChanged: (n) => setState(() => _bedsSelected = n),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: IntDropDownMenu(
                      inputFailedValidation: bathsValidatedFailed,
                      label: 'Baths',
                      selectedNumber: _bathsSelected,
                      required: true,
                      onChanged: (n) => setState(() => _bathsSelected = n),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              AppNotesBox(controller: notesController),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Compact checkbox + label
                  Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Checkbox(
                          value: _updateAllSameUnit,
                          onChanged: (v) => setState(() => _updateAllSameUnit = v ?? false),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('Update all of same unit'), // or AppText if you prefer
                    ],
                  ),
                  const SizedBox(width: 16),
                  SizedBox(width: 250, child: AppFormSubmitButton(label: 'Save Changes', function: () => onSubmit())),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

int? findPhaseForProperty(PropertyDTO propertyDTO, DevelopmentDTO developmentDTO) {
  for (final phase in developmentDTO.developmentPhases) {
    for (final prop in phase.properties) {
      if (prop.id == propertyDTO.id) {
        return phase.id;
      }
    }
  }
  return null; // not found
}
