import 'package:flutter/material.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/utils/font_size_utils.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';
import 'package:rylax_admin/core/network/models/development_phase_dto.dart';

/// Renders a small error line below a field when [show] is true.
Widget _errorLine({required bool show, String message = 'Please select an option'}) {
  if (!show) return const SizedBox.shrink();
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: AppText(textValue: message, fontSize: 14, fontWeight: FontWeight.w300, fontColor: Colors.red),
    ),
  );
}

// =============================================================
// PhaseDropdown — phases by name, returns phase id, with error line
// =============================================================
class PhaseDropdown extends StatelessWidget {
  final List<DevelopmentPhaseDTO> phases;
  final int? selectedPhaseId;
  final ValueChanged<int?> onChanged;
  final String? hintText;
  final bool required;
  final bool enabled;
  final InputDecoration? decoration;

  final bool inputFailedValidation;
  final String validationFailedMessage;

  const PhaseDropdown({
    super.key,
    required this.phases,
    required this.onChanged,
    this.selectedPhaseId,
    this.hintText,
    this.required = false,
    this.enabled = true,
    this.decoration,
    this.inputFailedValidation = false,
    this.validationFailedMessage = 'Please select an option',
  });

  @override
  Widget build(BuildContext context) {
    final headingSize = FontSizeUtils.determineHeadingSize(context);

    final items = phases
        .map(
          (p) => DropdownMenuItem<int>(
            value: p.id,
            child: AppText(textValue: p.phaseName, fontSize: 16),
          ),
        )
        .toList(growable: false);

    final baseDecoration = InputDecoration(
      hintText: hintText ?? 'Select a phase',
      hintStyle: TextStyle(color: AppColors.headingColor, fontSize: headingSize, fontWeight: FontWeight.w400),
      isDense: true,
      labelStyle: TextStyle(color: AppColors.headingColor, fontSize: headingSize, fontWeight: FontWeight.bold),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.headingColor)),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.headingColor, width: 2)),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppText(textValue: 'Phase', fontSize: headingSize),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<int>(
          value: selectedPhaseId,
          items: items,
          dropdownColor: AppColors.mainWhite,
          decoration: baseDecoration.copyWith(
            labelText: decoration?.labelText ?? baseDecoration.labelText,
            hintText: decoration?.hintText ?? baseDecoration.hintText,
            isDense: decoration?.isDense ?? baseDecoration.isDense,
            prefixIcon: decoration?.prefixIcon,
            suffixIcon: decoration?.suffixIcon,
            helperText: decoration?.helperText,
            errorText: decoration?.errorText,
            enabledBorder: decoration?.enabledBorder ?? baseDecoration.enabledBorder,
            focusedBorder: decoration?.focusedBorder ?? baseDecoration.focusedBorder,
            labelStyle: decoration?.labelStyle ?? baseDecoration.labelStyle,
            hintStyle: decoration?.hintStyle ?? baseDecoration.hintStyle,
          ),
          onChanged: enabled ? onChanged : null,
          validator: required
              ? (value) {
                  if (value == null) return 'Please select a phase';
                  return null;
                }
              : null,
          isExpanded: true,
        ),
        _errorLine(show: inputFailedValidation, message: validationFailedMessage),
      ],
    );
  }
}

extension DevelopmentPhaseListX on List<DevelopmentPhaseDTO> {
  DevelopmentPhaseDTO? byId(int? id) {
    if (id == null) return null;
    for (final p in this) {
      if (p.id == id) return p;
    }
    return null;
  }
}
