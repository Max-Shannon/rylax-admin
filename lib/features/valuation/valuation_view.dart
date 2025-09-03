import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
              child: Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.red)),
            ),
          );
        } else if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final data = snapshot.data!;
        final comps = data.payload.compsPayload.comps;

        return Scaffold(
          backgroundColor: AppColors.mainWhite,
          appBar: AppBar(
            backgroundColor: AppColors.mainWhite,
            elevation: 0,
            title: const AppText(textValue: "Comparable Properties", fontSize: 18),
            centerTitle: false,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (data.summary.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: AppColors.mainGreen.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.mainGreen.withOpacity(0.2)),
                      ),
                      child: AppText(textValue: data.summary, fontSize: 14),
                    ),
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
                            childAspectRatio: 4 / 6,
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
        padding: const EdgeInsets.symmetric(horizontal: 6),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16),
              const SizedBox(width: 4),
            ],
            Text(label),
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
            SizedBox(width: 140, child: Text(key, style: const TextStyle(fontWeight: FontWeight.w600))),
            const SizedBox(width: 6),
            Expanded(child: Text(value)),
          ],
        ),
      );
    }

    final features = (comp.features ?? const []).where((f) => f.trim().isNotEmpty).toList();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Column(
          children: [
            // Image area
            SizedBox(
              height: 220,
              width: double.infinity,
              child: hasImages
                  ? PageView.builder(
                itemCount: comp.images!.length,
                controller: PageController(viewportFraction: 1),
                itemBuilder: (context, i) {
                  final url = comp.images![i];
                  return Image.network(
                    url,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _ImagePlaceholder(),
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const _ImagePlaceholder(isLoading: true);
                    },
                  );
                },
              )
                  : const _ImagePlaceholder(),
            ),

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
                          child: Text(
                            comp.title.isNotEmpty ? comp.title : (comp.address.isNotEmpty ? comp.address : 'Untitled'),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(width: 8),
                        if ((comp.status).toString().isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor(comp.status),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              (comp.status).toString(),
                              style: TextStyle(
                                color: statusTextColor(comp.status),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (comp.address.isNotEmpty)
                      Text(
                        comp.address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    const SizedBox(height: 8),

                    // Quick facts chips (auto-hide nulls)
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        if (comp.source.isNotEmpty) infoChip(icon: Icons.public, label: comp.source),
                        if (km(comp.distanceKm) != null) infoChip(icon: Icons.place, label: km(comp.distanceKm)),
                        if (comp.similarityScore != null)
                          infoChip(
                            icon: Icons.percent,
                            label: "Similarity ${(comp.similarityScore! * 100).toStringAsFixed(0)}%",
                          ),
                        if (comp.beds != null) infoChip(icon: Icons.bed_outlined, label: "${comp.beds} beds"),
                        if (comp.baths != null) infoChip(icon: Icons.bathtub_outlined, label: "${comp.baths} baths"),
                        if (comp.sqm != null) infoChip(icon: Icons.square_foot, label: "${comp.sqm} sqm"),
                        if (comp.ber?.isNotEmpty == true) infoChip(icon: Icons.eco_outlined, label: "BER ${comp.ber}"),
                        if (comp.yearBuilt != null) infoChip(icon: Icons.calendar_today, label: "Built ${comp.yearBuilt}"),
                        if (comp.siteArea != null) infoChip(icon: Icons.terrain, label: "${comp.siteArea} site area"),
                      ].whereType<Widget>().toList(),
                    ),

                    const SizedBox(height: 8),

                    // Prices & dates (only render non-null)
                    ...[
                      infoRow("List price", euroInt(comp.listPriceEur)),
                      infoRow("Sold price", euroInt(comp.soldPriceEur)),
                      infoRow("Price / sqm", euroDouble(comp.pricePerSqmEur)),
                      infoRow("Date listed", fmtDate(comp.dateListed)),
                      infoRow("Date sold", fmtDate(comp.dateSold)),
                      infoRow("Agent", comp.agent),
                      infoRow("Condition", comp.condition),
                      if (comp.adjustedValueEur != null)
                        infoRow("Adjusted value", euroInt(comp.adjustedValueEur)),
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
                              .map((f) => Chip(label: Text(f)))
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
                            icon: const Icon(Icons.open_in_new),
                            label: const Text("View listing"),
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
        children: const [
          Icon(Icons.image_not_supported_outlined, size: 32),
          SizedBox(height: 6),
          Text("No image"),
        ],
      ),
    );
  }
}

// ---------- Small extensions to make null/empty checks tidy ----------
extension _SafeStr on String? {
  bool get isNotEmpty => (this ?? '').trim().isNotEmpty;
}
