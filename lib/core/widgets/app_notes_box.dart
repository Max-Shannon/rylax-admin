import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import 'app_text.dart';

class AppNotesBox extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hint;
  final double height; // default ~250px

  const AppNotesBox({super.key, required this.controller, this.title = 'Notes', this.hint = 'Write notes…', this.height = 250});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(textValue: title, fontSize: 18, textAlign: TextAlign.left),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity, // stretch left/right
          height: height, // ~400px tall
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.mainWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12),
            ),
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              expands: true,
              // fill the 400px box
              minLines: null,
              maxLines: null,
              decoration: const InputDecoration(isCollapsed: true, border: InputBorder.none, hintText: 'Write notes…'),
            ),
          ),
        ),
      ],
    );
  }
}
