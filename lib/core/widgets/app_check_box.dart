import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import '../utils/font_size_utils.dart';

class AppCheckBox extends StatefulWidget {
  final String textLabel;
  final String textLink;
  final Function onTapFunction;
  final ValueChanged<bool> onChanged;

  const AppCheckBox({super.key, required this.onTapFunction, required this.textLabel, required this.textLink, required this.onChanged});

  @override
  State<StatefulWidget> createState() => AppCheckBoxState();
}

class AppCheckBoxState extends State<AppCheckBox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = false;
  }

  @override
  Widget build(BuildContext context) {
    double subtitleSize = FontSizeUtils.determineSubtitleSize(context);
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: CheckboxListTile(
        activeColor: AppColors.mainGreen,
        value: _isChecked,
        onChanged: _toggleCheckbox,
        title: RichText(
          text: TextSpan(
            recognizer: TapGestureRecognizer()..onTap = () => widget.onTapFunction(context),
            text: widget.textLabel,
            style: AppTextStyles.defaultFontStyle(subtitleSize),
            children: [
              TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () => widget.onTapFunction(context),
                text: widget.textLink,
                style: AppTextStyles.defaultUnderlinedFont(subtitleSize),
              ),
            ],
          ),
        ),
        controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }

  void _toggleCheckbox(bool? newValue) {
    if (newValue != null) {
      setState(() => _isChecked = newValue);
      widget.onChanged(newValue); // Notify parent
    }
  }
}
