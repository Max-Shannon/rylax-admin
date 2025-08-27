import 'package:flutter/material.dart';
import 'package:rylax_admin/core/network/models/development_phase_dto.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/utils/font_size_utils.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';

/// A reusable dropdown that displays [DevelopmentPhaseDTO.phaseName]
/// but returns the corresponding [DevelopmentPhaseDTO.id] on selection.
class PhaseDropdown extends StatelessWidget {
  /// All available phases to choose from.
  final List<DevelopmentPhaseDTO> phases;

  /// The currently selected phase id (nullable if none selected yet).
  final int? selectedPhaseId;

  /// Called when the selected phase changes. Receives the selected phase id (or null).
  final ValueChanged<int?> onChanged;

  /// Optional hint text when nothing is selected.
  final String? hintText;

  /// Whether the field is required; when true, a simple validator is applied.
  final bool required;

  /// Whether the dropdown is disabled.
  final bool enabled;

  /// Optional decoration override (merged with defaults).
  final InputDecoration? decoration;

  const PhaseDropdown({
    super.key,
    required this.phases,
    required this.onChanged,
    this.selectedPhaseId,
    this.hintText,
    this.required = false,
    this.enabled = true,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    double headingSize = FontSizeUtils.determineHeadingSize(context);
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
      hintStyle: TextStyle(
        color: AppColors.headingColor, // your custom colour
        fontSize: headingSize, // optional
        fontWeight: FontWeight.w400, // optional
      ),
      isDense: true,
      labelStyle: TextStyle(
        color: AppColors.headingColor, // your custom colour
        fontSize: headingSize, // optional
        fontWeight: FontWeight.bold, // optional
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.headingColor), // your custom colour
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.headingColor, // colour when focused
          width: 2, // thickness when focused
        ),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(alignment: Alignment.centerLeft, child: AppText(textValue: "Phase Selection", fontSize: headingSize)),
        SizedBox(height: 20),
        DropdownButtonFormField<int>(
          value: selectedPhaseId,
          items: items,
          dropdownColor: AppColors.mainWhite,
          decoration: baseDecoration.copyWith(
            // Merge provided decoration if any
            labelText: decoration?.labelText ?? baseDecoration.labelText,
            hintText: decoration?.hintText ?? baseDecoration.hintText,
            isDense: decoration?.isDense ?? baseDecoration.isDense,
            prefixIcon: decoration?.prefixIcon,
            suffixIcon: decoration?.suffixIcon,
            helperText: decoration?.helperText,
            errorText: decoration?.errorText,
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
      ],
    );
  }
}

/// Convenience helpers
extension DevelopmentPhaseListX on List<DevelopmentPhaseDTO> {
  /// Finds a phase by id, or null if not found.
  DevelopmentPhaseDTO? byId(int? id) {
    if (id == null) return null;
    for (final p in this) {
      if (p.id == id) return p;
    }
    return null;
  }
}
