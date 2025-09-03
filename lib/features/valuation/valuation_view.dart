import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rylax_admin/core/utils/font_size_utils.dart';
import 'package:rylax_admin/core/widgets/summary_card.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:rylax_admin/core/network/models/valuation/res/rylax_valuation_response.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';

import '../../core/network/models/valuation/res/comp_dto.dart';

// ---------- ValuationView (updated) ----------
class ValuationView extends StatelessWidget {
  final Future<RylaxValuationResponse> valuationResponse;

  const ValuationView({super.key, required this.valuationResponse});

  @override
  Widget build(BuildContext context) {
    double headingSize = FontSizeUtils.determineHeadingSize(context);
    double subtitleSize = FontSizeUtils.determineSubtitleSize(context);

    return FutureBuilder<RylaxValuationResponse>(
      future: valuationResponse,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: AppColors.mainWhite,
            body: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: AppColors.mainGreen),
                  SizedBox(height: 16),
                  AppText(textValue: "Thinking. . .", fontSize: 48),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: AppColors.mainWhite,
            body: Center(
              child: AppText(textValue: "Error: ${snapshot.error}", fontSize: headingSize, fontColor: AppColors.mainRed),
            ),
          );
        } else if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final data = snapshot.data!;
        final comps = data.payload.compsPayload.comps;

        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SummaryCard(summary: data.payload.compsPayload.summary, analysisSummary: data.summary),

                  // if (data.summary.isNotEmpty)
                  //   // Summary Display, Maybe this is a closable box.
                  //   Container(
                  //     padding: const EdgeInsets.all(12),
                  //     margin: const EdgeInsets.only(bottom: 12),
                  //     decoration: BoxDecoration(
                  //       color: AppColors.mainGreen.withOpacity(0.06),
                  //       borderRadius: BorderRadius.circular(12),
                  //       border: Border.all(color: AppColors.mainGreen.withOpacity(0.2)),
                  //     ),
                  //     child: AppText(textValue: data.summary, fontSize: 14),
                  //   ),

                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = 1;
                        final w = constraints.maxWidth;
                        if (w >= 1200) {
                          crossAxisCount = 3;
                        } else if (w >= 800) {
                          crossAxisCount = 2;
                        }

                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 4 / 5,
                          ),
                          itemCount: comps.length,
                          itemBuilder: (context, index) {
                            return CompCard(comp: comps[index]);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ---------- CompCard ----------
class CompCard extends StatelessWidget {
  final CompDTO comp;

  const CompCard({super.key, required this.comp});

  @override
  Widget build(BuildContext context) {
    final nfMoney = NumberFormat.currency(locale: 'en_IE', symbol: '€', decimalDigits: 0);
    String? euroInt(int? v) => v == null ? null : nfMoney.format(v);
    String? euroDouble(double? v) => v == null ? null : nfMoney.format(v);
    String? km(double? v) => v == null ? null : "${v.toStringAsFixed(v >= 10 ? 0 : 1)} km";
    final df = DateFormat('yyyy-MM-dd');
    String? fmtDate(DateTime? d) => d == null ? null : df.format(d);

    final hasImages = (comp.images ?? const []).isNotEmpty;

    Color statusColor(String? status) {
      switch ((status ?? '').toLowerCase()) {
        case 'sold':
          return Colors.red.shade100;
        case 'active':
          return Colors.green.shade100;
        default:
          return Colors.grey.shade200;
      }
    }

    Color statusTextColor(String? status) {
      switch ((status ?? '').toLowerCase()) {
        case 'sold':
          return Colors.red.shade700;
        case 'active':
          return Colors.green.shade700;
        default:
          return Colors.grey.shade700;
      }
    }

    // Helper chip (auto-hides on null/empty)
    Widget? infoChip({IconData? icon, String? label}) {
      if (label == null || label.trim().isEmpty) return null;

      return Chip(
        color: WidgetStatePropertyAll(AppColors.backgroundColor),
        padding: const EdgeInsets.symmetric(horizontal: 6),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, size: 16), const SizedBox(width: 4)],
            AppText(textValue: label, fontSize: 12, fontWeight: FontWeight.w400),
          ],
        ),
      );
    }

    // Key/value row (auto-hides)
    Widget? infoRow(String key, String? value) {
      if (value == null || value.trim().isEmpty) return null;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 140,
              child: AppText(textValue: key, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: AppText(textValue: value, fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      );
    }

    final features = (comp.features ?? const []).where((f) => f.trim().isNotEmpty).toList();

    return Card(
      elevation: 2,
      color: AppColors.mainWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Column(
          children: [
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title + status/source chips
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppText(
                            textValue: comp.title.isNotEmpty ? comp.title : (comp.address.isNotEmpty ? comp.address : 'Untitled'),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 8),

                        if ((comp.status).toString().isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: statusColor(comp.status), borderRadius: BorderRadius.circular(999)),
                            child: AppText(textValue: (comp.status).toString(), fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                      ],
                    ),

                    const SizedBox(height: 4),
                    if (comp.address.isNotEmpty) AppText(textValue: comp.address, fontSize: 12, fontColor: AppColors.headingColorLight),
                    const SizedBox(height: 8),

                    // Quick facts chips (auto-hide nulls)
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        if (comp.source.isNotEmpty) infoChip(icon: Icons.public, label: comp.source),
                        if (km(comp.distanceKm) != null) infoChip(icon: Icons.place, label: km(comp.distanceKm)),
                        if (comp.similarityScore != null)
                          infoChip(icon: Icons.percent, label: "Similarity ${(comp.similarityScore! * 100).toStringAsFixed(0)}%"),
                        if (comp.beds != null) infoChip(icon: Icons.bed_outlined, label: "${comp.beds} beds"),
                        if (comp.baths != null) infoChip(icon: Icons.bathtub_outlined, label: "${comp.baths} baths"),
                        if (comp.sqm != null) infoChip(icon: Icons.square_foot, label: "${comp.sqm} sqm"),
                        if (comp.ber?.isNotEmpty == true) infoChip(icon: Icons.eco_outlined, label: "BER ${comp.ber}"),
                        if (comp.yearBuilt != null) infoChip(icon: Icons.calendar_today, label: "Built ${comp.yearBuilt}"),
                        if (comp.siteArea != null) infoChip(icon: Icons.terrain, label: "${comp.siteArea} site area"),
                      ].whereType<Widget>().toList(),
                    ),

                    const SizedBox(height: 60),

                    // Prices & dates (only render non-null)
                    ...[
                      infoRow("List price", euroInt(comp.listPriceEur)),
                      infoRow("Sold price", euroInt(comp.soldPriceEur)),
                      infoRow("Price / sqm", euroDouble(comp.pricePerSqmEur)),
                      infoRow("Date listed", fmtDate(comp.dateListed)),
                      infoRow("Date sold", fmtDate(comp.dateSold)),
                      infoRow("Agent", comp.agent),
                      infoRow("Condition", comp.condition),
                      if (comp.adjustedValueEur != null) infoRow("Adjusted value", euroInt(comp.adjustedValueEur)),
                      if (comp.notes?.isNotEmpty == true) infoRow("Notes", comp.notes),
                    ].whereType<Widget>(),

                    const Spacer(),

                    // Features
                    if (features.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: features
                              .take(8) // cap to keep the card compact
                              .map((f) => Chip(color: WidgetStatePropertyAll(AppColors.backgroundColor), label: Text(f)))
                              .toList(),
                        ),
                      ),

                    // Actions row
                    Row(
                      children: [
                        if (comp.url.isNotEmpty)
                          TextButton.icon(
                            onPressed: () async {
                              if (await canLaunchUrlString(comp.url)) {
                                await launchUrlString(comp.url, mode: LaunchMode.externalApplication);
                              }
                            },
                            icon: const Icon(Icons.open_in_new, color: AppColors.mainGreen),
                            label: const AppText(textValue: "View Listing", fontSize: 14),
                          ),
                        const Spacer(),
                        if (comp.lat != null && comp.lon != null)
                          IconButton(
                            tooltip: "Open in Maps",
                            onPressed: () async {
                              final uri = "https://www.google.com/maps/search/?api=1&query=${comp.lat},${comp.lon}";
                              if (await canLaunchUrlString(uri)) {
                                await launchUrlString(uri, mode: LaunchMode.externalApplication);
                              }
                            },
                            icon: const Icon(Icons.map_outlined),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  final bool isLoading;

  const _ImagePlaceholder({this.isLoading = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: isLoading
          ? const CircularProgressIndicator()
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: const [Icon(Icons.image_not_supported_outlined, size: 32), SizedBox(height: 6), Text("No image")],
            ),
    );
  }
}

// ---------- Small extensions to make null/empty checks tidy ----------
extension _SafeStr on String? {
  bool get isNotEmpty => (this ?? '').trim().isNotEmpty;
}
