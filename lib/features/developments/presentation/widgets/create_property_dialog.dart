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

  final TextEditingController propertyNumberController = TextEditingController();
  final TextEditingController unitTypeController = TextEditingController();
  final TextEditingController sqmController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

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
  void dispose() {
    propertyNumberController.dispose();
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
    setState(() {
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
    final bool unitTypeSelected = ValidationUtils.validateNotEmpty(unitTypeController.text);
    final bool propertyStyleSelected = ValidationUtils.validateNotEmpty(_styleSelected!);
    final bool phaseSelected = ValidationUtils.validateSelected(_selectedPhaseId!);
    final bool bedsSelected = ValidationUtils.validateSelected(_bedsSelected!);
    final bool bathsSelected = ValidationUtils.validateSelected(_bathsSelected!);
    final bool sqmSelected = ValidationUtils.validateNotEmpty(sqmController.text);
    final bool priceSelected = ValidationUtils.validateNotEmpty(priceController.text);
    final bool unitCountSelected = ValidationUtils.validateSelected(_unitCount!);

    if (unitTypeSelected &&
        propertyStyleSelected &&
        phaseSelected &&
        bedsSelected &&
        bathsSelected &&
        sqmSelected &&
        priceSelected &&
        unitTypeSelected &&
        unitCountSelected) {
      const propertyType = 'NEW_BUILD';
      final sqm = int.parse(sqmController.text);
      final price = int.parse(priceController.text);

      final createPropertyRequest = CreatePropertyRequest(
        propertyType,
        _styleSelected!,
        unitTypeController.text,
        _unitCount!,
        _bedsSelected!,
        _bathsSelected!,
        sqm,
        price,
      );

      final success = await rylaxAPIService.createProperty(_selectedPhaseId!, createPropertyRequest);
      if (success) {
        if (mounted) Navigator.pop(context);
        if (mounted) SnackBarz.showSnackBar(context, AppColors.mainGreen, 'Property Created Successfully');
      } else {
        if (mounted) SnackBarz.showSnackBar(context, AppColors.mainRed, 'Failed to create property, contact support');
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
      child: Container
        (
        height: ScreenSizeUtils.calculatePercentageHeight(context, 60),
        width: ScreenSizeUtils.calculatePercentageWidth(context, 60),
        padding: const EdgeInsets.all(24),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool twoCols = constraints.maxWidth >= 720;
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText(textValue: 'Add New Property', fontSize: headingSize),
                  const SizedBox(height: 24),

                  // Row 1: Unit Type | Unit Count
                  _rowOrColumn(
                    twoCols,
                    AppTextInputWithTitle(
                      inputFailedValidation: unitTypeValidatedFailed,
                      textEditingController: unitTypeController,
                      validationFailedMessage: 'Please enter a valid text',
                      title: 'Unit Type',
                    ),
                    IntDropDownMenu(
                      label: 'Unit Count',
                      selectedNumber: _unitCount,
                      required: true,
                      onChanged: (n) => setState(() => _unitCount = n),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Row 2: SQM | Price
                  _rowOrColumn(
                    twoCols,
                    AppTextInputWithTitle(
                      inputFailedValidation: sqmValidatedFailed,
                      textEditingController: sqmController,
                      validationFailedMessage: 'Please enter a valid text',
                      title: 'Sqm',
                    ),
                    AppTextInputWithTitle(
                      inputFailedValidation: priceValidatedFailed,
                      textEditingController: priceController,
                      validationFailedMessage: 'Please enter a valid text',
                      title: 'Price',
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Row 3: Property Style | Phase
                  _rowOrColumn(
                    twoCols,
                    PropertyStyleDropdown(
                      label: 'Property Style',
                      selectedValue: _styleSelected,
                      required: true,
                      onChanged: (style) => setState(() => _styleSelected = style),
                    ),
                    PhaseDropdown(
                      phases: widget.developmentDTO.developmentPhases,
                      onChanged: (int? id) => setState(() => _selectedPhaseId = id),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Row 4: Beds | Baths
                  _rowOrColumn(
                    twoCols,
                    IntDropDownMenu(
                      label: 'Beds',
                      selectedNumber: _bedsSelected,
                      required: true,
                      onChanged: (n) => setState(() => _bedsSelected = n),
                    ),
                    IntDropDownMenu(
                      label: 'Baths',
                      selectedNumber: _bathsSelected,
                      required: true,
                      onChanged: (n) => setState(() => _bathsSelected = n),
                    ),
                  ),

                  const SizedBox(height: 24),
                  AppText(textValue: 'Note: Clean up, just making functional', fontSize: 14),
                  const SizedBox(height: 10),
                  AppFormSubmitButton(label: 'Create', function: () => onSubmit()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Helper to render a responsive pair either as a Row (two columns)
  /// or stacked Column (single column) with consistent spacing.
  Widget _rowOrColumn(bool twoCols, Widget left, Widget right) {
    if (twoCols) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: left),
          const SizedBox(width: 50),
          Expanded(child: right),
        ],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        left,
        const SizedBox(height: 50),
        right,
      ],
    );
  }
}
