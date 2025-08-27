import 'package:flutter/material.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/utils/font_size_utils.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';

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
// IntDropDownMenu — numbers 1..10 with validation message support
// =============================================================
class IntDropDownMenu extends StatelessWidget {
  final int? selectedNumber;
  final String label;
  final ValueChanged<int?> onChanged;
  final String? hintText;
  final bool required;
  final bool enabled;
  final InputDecoration? decoration;

  /// If true, shows the error line under the field.
  final bool inputFailedValidation;

  /// Message to show when [inputFailedValidation] is true.
  final String validationFailedMessage;

  const IntDropDownMenu({
    super.key,
    required this.label,
    required this.onChanged,
    this.selectedNumber,
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

    final items = List<DropdownMenuItem<int>>.generate(10, (i) {
      final value = i + 1;
      return DropdownMenuItem<int>(
        value: value,
        child: AppText(textValue: value.toString(), fontSize: 16),
      );
    }, growable: false);

    final baseDecoration = InputDecoration(
      hintText: hintText ?? 'Select a number',
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
        DropdownButtonFormField<int>(
          value: selectedNumber,
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
                  if (value == null) return 'Please select a number';
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
