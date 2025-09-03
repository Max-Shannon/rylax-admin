import 'package:flutter/material.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/utils/font_size_utils.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';

/// Renders a small error line below a field when [show] is true.
/// (Reuse your existing helper if this already exists in the file.)
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

/// =============================================================
/// EnergyRatingDropDownMenu — BER rating selector with validation
/// =============================================================
class EnergyRatingDropDownMenu extends StatelessWidget {
  final String? selectedRating;
  final String label;
  final ValueChanged<String?> onChanged;
  final String? hintText;
  final bool required;
  final bool enabled;
  final InputDecoration? decoration;

  /// If true, shows the error line under the field.
  final bool inputFailedValidation;

  /// Message to show when [inputFailedValidation] is true.
  final String validationFailedMessage;

  /// Overrideable list of ratings (defaults to standard BER scale).
  final List<String> availableRatings;

  static const List<String> _defaultRatings = [
    'A1','A2','A3',
    'B1','B2','B3',
    'C1','C2','C3',
    'D1','D2',
    'E1','E2',
    'F','G',
  ];

  const EnergyRatingDropDownMenu({
    super.key,
    required this.label,
    required this.onChanged,
    this.selectedRating,
    this.hintText,
    this.required = false,
    this.enabled = true,
    this.decoration,
    this.inputFailedValidation = false,
    this.validationFailedMessage = 'Please select an option',
    this.availableRatings = _defaultRatings,
  });

  @override
  Widget build(BuildContext context) {
    final headingSize = FontSizeUtils.determineHeadingSize(context);

    final items = availableRatings
        .map((r) => DropdownMenuItem<String>(
      value: r,
      child: AppText(textValue: r, fontSize: 16),
    ))
        .toList(growable: false);

    final baseDecoration = InputDecoration(
      hintText: hintText ?? 'Select a rating',
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
          child: AppText(textValue: label, fontSize: headingSize),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: selectedRating,
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
            if (value == null || value.isEmpty) return 'Select a rating';
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
