import 'package:flutter/material.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/utils/font_size_utils.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';

/// Reuse your existing helper if it's already in the file.
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
/// FinishLevelDropDownMenu — property finish level selector
/// =============================================================
class FinishLevelDropDownMenu extends StatelessWidget {
  final String? selectedFinishLevel;
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

  /// Overrideable list of options (defaults to standard finish levels).
  final List<String> availableOptions;

  static const List<String> _defaultOptions = [
    'Basic',
    'Standard',
    'Premium',
    'Requires Renovation',
    'Requires Light Renovation',
    'Requires Heavy Renovation',
  ];

  const FinishLevelDropDownMenu({
    super.key,
    required this.label,
    required this.onChanged,
    this.selectedFinishLevel,
    this.hintText,
    this.required = false,
    this.enabled = true,
    this.decoration,
    this.inputFailedValidation = false,
    this.validationFailedMessage = 'Please select an option',
    this.availableOptions = _defaultOptions,
  });

  @override
  Widget build(BuildContext context) {
    final headingSize = FontSizeUtils.determineHeadingSize(context);

    final items = availableOptions
        .map((o) => DropdownMenuItem<String>(
      value: o,
      child: AppText(textValue: o, fontSize: 16),
    ))
        .toList(growable: false);

    final baseDecoration = InputDecoration(
      hintText: hintText ?? 'Select finish level',
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
          value: selectedFinishLevel,
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
            if (value == null || value.isEmpty) return 'Select a finish level';
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
