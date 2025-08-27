import 'package:flutter/material.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/utils/font_size_utils.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';

/// Dropdown for selecting a PropertyStyle enum value (as a String)
/// using your app styles. The underlying value passed to [onChanged]
/// is the enum name, e.g. "END_OF_TERRACE".
class PropertyStyleDropdown extends StatelessWidget {
  /// Currently selected enum name (e.g. 'SEMI_DETACHED'). Null if none.
  final String? selectedValue;

  /// Label shown above the field.
  final String label;

  /// Called when the selected enum name changes.
  final ValueChanged<String?> onChanged;

  /// Optional hint text when nothing is selected.
  final String? hintText;

  /// Whether the field is required; when true, a simple validator is applied.
  final bool required;

  /// Whether the dropdown is disabled.
  final bool enabled;

  /// Optional decoration override (merged with defaults).
  final InputDecoration? decoration;

  /// Options to display. If null, uses the default set mirroring the backend enum.
  final List<String>? options;

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

    // Build menu items from enum names, but show friendlier labels.
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
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
          value: selectedValue,
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
            if (value == null || value.isEmpty) return 'Please select a style';
            return null;
          }
              : null,
          isExpanded: true,
        ),
      ],
    );
  }
}

/// Converts enum-style SCREAMING_SNAKE_CASE to Title Case with spaces.
String _labelFromEnum(String value) {
  return value
      .toLowerCase()
      .split('_')
      .map((w) => w.isEmpty ? w : w[0].toUpperCase() + w.substring(1))
      .join(' ');
}
