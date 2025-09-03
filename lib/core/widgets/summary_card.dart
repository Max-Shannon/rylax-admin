import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rylax_admin/features/valuation/local_market_analysis_dialog.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';
import 'package:rylax_admin/core/network/models/valuation/res/summary_dto.dart';

class SummaryCard extends StatelessWidget {
  final String analysisSummary;
  final SummaryDTO summary;

  const SummaryCard({super.key, required this.summary, required this.analysisSummary});

  @override
  Widget build(BuildContext context) {
    final nfMoney = NumberFormat.currency(locale: 'en_IE', symbol: '€', decimalDigits: 0);
    String euroInt(int v) => nfMoney.format(v);
    final confPct = (summary.dataConfidence0to1.clamp(0, 1) * 100).toStringAsFixed(0);

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.mainGreen.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.mainGreen.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Headline: point value and range
          Row(
            children: [
              Expanded(
                child: _metricTile(label: "Valuation", value: euroInt(summary.valuationPointEur)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _metricTile(label: "Range", value: "${euroInt(summary.valuationLowEur)} - ${euroInt(summary.valuationHighEur)}"),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Confidence bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(textValue: "Data confidence", fontSize: 12, fontWeight: FontWeight.w600),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: summary.dataConfidence0to1.clamp(0, 1),
                  minHeight: 10,
                  backgroundColor: AppColors.mainGreen.withOpacity(0.15),
                  color: AppColors.mainGreen,
                ),
              ),
              const SizedBox(height: 6),
              AppText(textValue: "$confPct%", fontSize: 12, fontColor: AppColors.headingColorLight),
            ],
          ),
          const SizedBox(height: 12),

          // Method
          if (summary.method.trim().isNotEmpty) ...[
            const Align(
              alignment: Alignment.centerLeft,
              child: AppText(textValue: "Method", fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: AppText(textValue: summary.method, fontSize: 12, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 12),
          ],

          // Disclaimers
          if ((summary.disclaimers ?? '').trim().isNotEmpty) ...[
            const Align(
              alignment: Alignment.centerLeft,
              child: AppText(textValue: "Notes", fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: AppText(textValue: summary.disclaimers!, fontSize: 12, fontColor: AppColors.headingColorLight),
            ),
          ],

          // Sources
          if (summary.sourcesUsed.isNotEmpty) ...[
            const Align(
              alignment: Alignment.centerLeft,
              child: AppText(textValue: "Sources", fontSize: 12, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),

            Row(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: summary.sourcesUsed.take(8).map((s) {
                    final isUrl = Uri.tryParse(s)?.hasAbsolutePath == true || s.startsWith('http');
                    return isUrl
                        ? OutlinedButton.icon(
                            onPressed: () async {
                              if (await canLaunchUrlString(s)) {
                                await launchUrlString(s, mode: LaunchMode.externalApplication);
                              }
                            },
                            icon: const Icon(Icons.link, size: 16, color: AppColors.mainGreen),
                            label: AppText(textValue: _shortenUrl(s), fontSize: 12),
                          )
                        : Chip(
                            label: AppText(textValue: s, fontSize: 12),
                            color: const WidgetStatePropertyAll(Colors.white),
                            side: const BorderSide(color: Color(0xFFE5E7EB)),
                          );
                  }).toList(),
                ),
              ],
            ),

            SizedBox(
              width: 400,
              child: TextButton.icon(
                onPressed: () {
                  showPropertyDialog(context);
                },
                icon: const Icon(Icons.open_in_new, color: AppColors.mainGreen),
                label: const AppText(textValue: "View Local Market Analysis", fontSize: 14),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  void showPropertyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LocalMarketAnalysisDialog(analysisSummary: analysisSummary);
      },
    );
  }

  static String _shortenUrl(String s) {
    try {
      final uri = Uri.parse(s);
      final host = uri.host.replaceFirst('www.', '');
      final path = uri.path.length > 20 ? "${uri.path.substring(0, 20)}…" : uri.path;
      return path.isEmpty ? host : "$host$path";
    } catch (_) {
      return s;
    }
  }

  Widget _metricTile({required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.mainGreen.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(textValue: label, fontSize: 12, fontColor: AppColors.headingColorLight),
          const SizedBox(height: 4),
          AppText(textValue: value, fontSize: 18, fontWeight: FontWeight.w700),
        ],
      ),
    );
  }
}
