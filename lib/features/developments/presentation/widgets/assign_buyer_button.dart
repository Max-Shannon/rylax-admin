import 'package:flutter/material.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';

class AssignBuyerButton extends StatelessWidget {
  final double diameter;          // overall size of the circle
  final double iconSize;          // size of the plus icon
  final VoidCallback onPressed;
  final String? tooltip;

  const AssignBuyerButton({
    super.key,
    required this.onPressed,
    this.diameter = 22,           // tweak smaller/larger
    this.iconSize = 14,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Ink(
          width: diameter,
          height: diameter,
          decoration: const ShapeDecoration(
            color: AppColors.mainGreen,
            shape: CircleBorder(),
          ),
          child: Center(
            child: Icon(Icons.add, size: iconSize, color: Colors.white),
          ),
        ),
      ),
    );

    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}
