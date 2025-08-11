import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../utils/font_size_utils.dart';
import 'app_text.dart';

class DocumentOptionBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const DocumentOptionBox({super.key, required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double headingSize = FontSizeUtils.determineHeadingSize(context);
    double subtitleSize = FontSizeUtils.determineSubtitleSize(context);
    return Card(
      color: AppColors.mainWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.mainWhite,
                radius: 24,
                child: Icon(icon, color: AppColors.mainGreen),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(textValue: title, fontSize: headingSize, fontWeight: FontWeight.w600),
                    const SizedBox(height: 4),
                    AppText(textValue: subtitle, fontSize: subtitleSize, fontColor: AppColors.headingColorLight, fontWeight: FontWeight.w400),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.mainGreen),
            ],
          ),
        ),
      ),
    );
  }
}
