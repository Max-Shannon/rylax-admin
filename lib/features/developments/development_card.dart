import 'package:flutter/material.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/widgets/app_form_submit_button.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';

import '../../core/network/models/development_dto.dart';

class DevelopmentCard extends StatelessWidget {
  final DevelopmentDTO? dev;
  final VoidCallback? onTap;

  const DevelopmentCard({super.key, required this.dev, this.onTap});

  void doNothing() {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 500,
      child: Card(
        color: AppColors.mainWhite,
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Body
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodyMedium!,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(textValue: dev!.developmentName, fontSize: 18),
                        const SizedBox(height: 6),
                        const Spacer(),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _fmtDate(DateTime d) {
    // e.g., "Jun 2026" or "2026-06-01"
    return '${_mon(d.month)} ${d.year}';
  }

  String _mon(int m) => const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][m - 1];
}

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MetaRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade700),
          const SizedBox(width: 6),
          Expanded(child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
