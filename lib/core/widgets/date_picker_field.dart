import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DatePickerField extends StatelessWidget {
  /// Current value (null shows placeholder)
  final DateTime? value;

  /// Emits the picked date (or null if cleared)
  final ValueChanged<DateTime?> onChanged;

  /// Bounds and initial suggestion
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate;

  /// UI bits
  final String? label;
  final String? placeholder;
  final bool adaptive; // iOS-style picker on iOS
  final bool enabled;
  final bool clearable;
  final InputDecoration? decoration;

  /// Optional: limit which days are selectable in Material picker
  final SelectableDayPredicate? selectableDayPredicate;

  DatePickerField({
    super.key,
    required this.value,
    required this.onChanged,
    DateTime? firstDate,
    DateTime? lastDate,
    this.initialDate,
    this.label,
    this.placeholder,
    this.adaptive = true,
    this.enabled = true,
    this.clearable = true,
    this.decoration,
    this.selectableDayPredicate,
  }) : firstDate = firstDate ?? DateTime(1900, 1, 1),
       lastDate = lastDate ?? DateTime(2100, 12, 31);

  @override
  Widget build(BuildContext context) {
    final loc = MaterialLocalizations.of(context);
    final shown = value == null ? (placeholder ?? 'Select date') : loc.formatMediumDate(value!);

    return InkWell(
      onTap: enabled ? () => _pick(context) : null,
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        isFocused: false,
        isEmpty: value == null,
        decoration:
            (decoration ??
                    InputDecoration(labelText: label ?? 'Date', prefixIcon: const Icon(Icons.event), border: const OutlineInputBorder()))
                .copyWith(
                  enabled: enabled,
                  suffixIcon: clearable && enabled && value != null
                      ? IconButton(tooltip: 'Clear', icon: const Icon(Icons.clear), onPressed: () => onChanged(null))
                      : (decoration?.suffixIcon),
                ),
        child: Text(
          shown,
          style: value == null
              ? Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).hintColor)
              : Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final platform = Theme.of(context).platform;
    final useCupertino = adaptive && (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS);

    // Clamp initial date into range
    DateTime seed = initialDate ?? value ?? DateTime.now();
    if (seed.isBefore(firstDate)) seed = firstDate;
    if (seed.isAfter(lastDate)) seed = lastDate;

    if (useCupertino) {
      final picked = await _showCupertino(context, seed);
      if (picked != null) onChanged(_stripTime(picked));
      return;
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: seed,
      firstDate: firstDate,
      lastDate: lastDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      selectableDayPredicate: selectableDayPredicate,
    );
    if (picked != null) onChanged(_stripTime(picked));
  }

  Future<DateTime?> _showCupertino(BuildContext context, DateTime seed) {
    DateTime temp = seed;
    return showCupertinoModalPopup<DateTime?>(
      context: context,
      builder: (ctx) {
        final bg = CupertinoColors.systemBackground.resolveFrom(ctx);
        return Container(
          height: 300,
          color: bg,
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(padding: EdgeInsets.zero, onPressed: () => Navigator.of(ctx).pop(null), child: const Text('Cancel')),
                    CupertinoButton(padding: EdgeInsets.zero, onPressed: () => Navigator.of(ctx).pop(temp), child: const Text('Done')),
                  ],
                ),
              ),
              const Divider(height: 0),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: seed,
                  minimumDate: firstDate,
                  maximumDate: lastDate,
                  onDateTimeChanged: (d) => temp = d,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  DateTime _stripTime(DateTime d) => DateTime(d.year, d.month, d.day);
}
