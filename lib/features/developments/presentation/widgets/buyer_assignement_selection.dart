import 'package:flutter/material.dart';
import 'package:rylax_admin/core/widgets/app_form_submit_button.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/utils/font_size_utils.dart';
import '../../../../core/utils/screen_size_utils.dart';
import '../../../../core/widgets/app_text.dart';

class BuyerAssigmentDialog extends StatelessWidget {
  const BuyerAssigmentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final double headingSize = FontSizeUtils.determineHeadingSize(context);
    final Color primary = AppColors.mainGreen;

    return Dialog(
      backgroundColor: AppColors.mainWhite,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: ScreenSizeUtils.calculatePercentageHeight(context, 50),
        width: ScreenSizeUtils.calculatePercentageWidth(context, 60),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(textValue: "Assign Buyer", fontSize: headingSize),
              const SizedBox(height: 8),
              const AppText(
                textValue: "Choose a method below — all actions are placeholders for now.",
                fontSize: 16,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Responsive layout: row on wide screens, column on narrow
              LayoutBuilder(
                builder: (context, constraints) {
                  final bool isNarrow = constraints.maxWidth < 900;

                  final children = [
                    Expanded(
                      child: _OptionCard(
                        icon: Icons.email_outlined,
                        iconColor: primary,
                        title: "Assign by Email",
                        description:
                        "Send an invitation to a buyer’s email address. They’ll be linked to this property automatically.",
                        buttonText: "Use Email",
                        onPressed: () => _placeholder(context, "Assign by Email"),
                      ),
                    ),
                    const SizedBox(width: 16, height: 16),
                    Expanded(
                      child: _OptionCard(
                        icon: Icons.qr_code_2_outlined,
                        iconColor: primary,
                        title: "Assign by Invite Code",
                        description:
                        "Generate or enter an invite code to connect the buyer to this property.",
                        buttonText: "Use Invite Code",
                        onPressed: () => _placeholder(context, "Assign by Invite Code"),
                      ),
                    ),
                    const SizedBox(width: 16, height: 16),
                    Expanded(
                      child: _OptionCard(
                        icon: Icons.person_add_alt_1_outlined,
                        iconColor: primary,
                        title: "Assign by Manual Creation",
                        description:
                        "Create a buyer record manually and assign them to this property now.",
                        buttonText: "Create Buyer",
                        onPressed: () => _placeholder(context, "Assign by Manual Creation"),
                      ),
                    ),
                  ];

                  if (isNarrow) {
                    // Stack vertically on narrow screens
                    return Column(
                      children: [
                        _OptionCard(
                          icon: Icons.email_outlined,
                          iconColor: primary,
                          title: "Assign by Email",
                          description:
                          "Send an invitation to a buyer’s email address. They’ll be linked to this property automatically.",
                          buttonText: "Use Email",
                          onPressed: () => _placeholder(context, "Assign by Email"),
                        ),
                        const SizedBox(height: 16),
                        _OptionCard(
                          icon: Icons.qr_code_2_outlined,
                          iconColor: primary,
                          title: "Assign by Invite Code",
                          description:
                          "Generate or enter an invite code to connect the buyer to this property.",
                          buttonText: "Use Invite Code",
                          onPressed: () => _placeholder(context, "Assign by Invite Code"),
                        ),
                        const SizedBox(height: 16),
                        _OptionCard(
                          icon: Icons.person_add_alt_1_outlined,
                          iconColor: primary,
                          title: "Assign by Manual Creation",
                          description:
                          "Create a buyer record manually and assign them to this property now.",
                          buttonText: "Create Buyer",
                          onPressed: () => _placeholder(context, "Assign by Manual Creation"),
                        ),
                      ],
                    );
                  }

                  // Row on wide screens
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void _placeholder(BuildContext context, String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$label tapped (placeholder)"),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.mainWhite,
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.headingColor ?? Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          // Bounded height so Column has finite main-axis constraints
          height: 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top block
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, size: 32, color: iconColor),
                  const SizedBox(height: 12),
                  AppText(
                    textValue: title,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 8),
                  AppText(
                    textValue: description,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              // Bottom button
              AppFormSubmitButton(label: buttonText, function: onPressed)
            ],
          ),
        ),
      ),
    );
  }
}
