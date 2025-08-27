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
// PropertyStyleDropdown — String enum values with validation line
// =============================================================
class PropertyStyleDropdown extends StatelessWidget {
  final String? selectedValue;
  final String label;
  final ValueChanged<String?> onChanged;
  final String? hintText;
  final bool required;
  final bool enabled;
  final InputDecoration? decoration;
  final List<String>? options;

  final bool inputFailedValidation;
  final String validationFailedMessage;

  const PropertyStyleDropdown({
    super.key,
    required this.label,
    required this.onChanged,
    this.selectedValue,
    this.hintText,
    this.required = false,
    this.enabled = true,
    this.decoration,
    this.options,
    this.inputFailedValidation = false,
    this.validationFailedMessage = 'Please select an option',
  });

  static const List<String> defaultPropertyStyles = [
    'END_OF_TERRACE',
    'MID_TERRACE',
    'SEMI_DETACHED',
    'DETACHED',
    'BUNGALOW',
    'GROUND_FLOOR_END_OF_TERRACE',
    'GROUND_FLOOR_MID_TERRACE',
    'DUPLEX_END_OF_TERRACE',
    'DUPLEX_MID_TERRACE',
  ];

  @override
  Widget build(BuildContext context) {
    final headingSize = FontSizeUtils.determineHeadingSize(context);
    final values = options ?? defaultPropertyStyles;

    final items = values
        .map(
          (value) => DropdownMenuItem<String>(
            value: value,
            child: AppText(textValue: _labelFromEnum(value), fontSize: 16),
          ),
        )
        .toList(growable: false);

    final baseDecoration = InputDecoration(
      hintText: hintText ?? 'Select a style',
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
          value: selectedValue,
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
                  if (value == null || value.isEmpty) return 'Please select a style';
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

String _labelFromEnum(String value) {
  return value.toLowerCase().split('_').map((w) => w.isEmpty ? w : w[0].toUpperCase() + w.substring(1)).join(' ');
}