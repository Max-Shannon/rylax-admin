import 'package:flutter/material.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/utils/font_size_utils.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';

/// Simple dropdown (1–10) using your app styles.
/// Returns the selected number via [onChanged].
class IntDropDownMenu extends StatelessWidget {
  /// The currently selected number (1–10). Null if none selected yet.
  final int? selectedNumber;
  final String label;

  /// Called when the selected number changes.
  final ValueChanged<int?> onChanged;

  /// Optional hint text when nothing is selected.
  final String? hintText;

  /// Whether the field is required; when true, a simple validator is applied.
  final bool required;

  /// Whether the dropdown is disabled.
  final bool enabled;

  /// Optional decoration override (merged with defaults).
  final InputDecoration? decoration;

  const IntDropDownMenu({
    super.key,
    required this.label,
    required this.onChanged,
    this.selectedNumber,
    this.hintText,
    this.required = false,
    this.enabled = true,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final headingSize = FontSizeUtils.determineHeadingSize(context);

    // Build fixed items 1..10
    final items = List<DropdownMenuItem<int>>.generate(
      10,
          (i) {
        final value = i + 1; // 1..10
        return DropdownMenuItem<int>(
          value: value,
          child: AppText(textValue: value.toString(), fontSize: 16),
        );
      },
      growable: false,
    );

    final baseDecoration = InputDecoration(
      hintText: hintText ?? 'Select a number',
      hintStyle: TextStyle(
        color: AppColors.headingColor,
        fontSize: headingSize,
        fontWeight: FontWeight.w400,
      ),
      isDense: true,
      labelStyle: TextStyle(
        color: AppColors.headingColor,
        fontSize: headingSize,
        fontWeight: FontWeight.bold,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.headingColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.headingColor, width: 2),
      ),
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
            // Merge provided decoration if any
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
      ],
    );
  }
}
