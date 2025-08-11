import 'package:flutter/material.dart';
import '../styles/app_colors.dart';

class SnackBarz {
  static showSnackBar(BuildContext context, Color color, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 4),
      behavior: SnackBarBehavior.floating,
      width: 400,
      action: SnackBarAction(
        label: 'Close',
        textColor: AppColors.mainWhite,
        onPressed: () {
          // Your undo logic here
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
