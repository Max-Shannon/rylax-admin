import 'package:flutter/material.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';
// If you already use intl, you can uncomment and use it for currency formatting.
// import 'package:intl/intl.dart';

import '../../../core/network/models/development_dto.dart';

class DevelopmentCard extends StatelessWidget {
  final DevelopmentDTO? dev;
  final VoidCallback? onTap;

  const DevelopmentCard({super.key, required this.dev, this.onTap});

  // ---- Helpers you can adapt to your DTO shape ----

// TODO: point to your hero/cover image url if available.
  String? get _imageUrl {
    return dev?.developmentCoverPhotoImage;
  }


  int get _phaseCount => dev?.developmentPhases?.length ?? 0;

  int get _propertyCount {
    // TODO: adapt if your phases/properties structure differs.
    final phases = dev?.developmentPhases ?? const [];
    int sum = 0;
    for (final p in phases) {
      sum += (p.properties?.length ?? 0);
    }
    return sum;
  }

  num get _totalPropertyValue {
    // TODO: replace `price` with your property price field (e.g., askingPrice).
    final phases = dev?.developmentPhases ?? const [];
    num total = 0;
    for (final p in phases) {
      for (final prop in (p.properties ?? const [])) {
        final price = (prop.price ?? 0); // <-- change to your field
        total += (price is num) ? price : 0;
      }
    }
    return total;
  }

  int get _buyerCount {
    // TODO: change to your buyers source (e.g., dev?.buyers?.length ?? 0).
    return 0;
  }

  int get _verifiedBuyerCount {
    // TODO: change to your verified buyers source.
    return 0;
  }

  String _fmtMoney(num value) {
    // If you prefer intl:
    // final f = NumberFormat.compactCurrency(symbol: '€');
    // return f.format(value);
    // // Lightweight fallback:
    if (value >= 1_000_000_000) return '€${(value / 1_000_000_000).toStringAsFixed(1)}B';
    if (value >= 1_000_000) return '€${(value / 1_000_000).toStringAsFixed(1)}M';
    if (value >= 1_000) return '€${(value / 1_000).toStringAsFixed(1)}K';
    return '€${value.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    final title = dev?.developmentName ?? '—';

    return SizedBox(
      width: 400,
      height: 600,
      child: Card
        (
        color: AppColors.mainWhite,
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ---------- Top Image ----------
              AspectRatio(
                aspectRatio: 16 / 9,
                child: _imageUrl != null && _imageUrl!.isNotEmpty
                    ? Ink.image(image: NetworkImage(_imageUrl!), fit: BoxFit.cover,) : _PlaceholderImage()
              ),
              // ---------- Body ----------
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodyMedium!,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        AppText(textValue: title, fontSize: 18),
                        const SizedBox(height: 10),

                        // Meta rows
                        _MetaRow(
                          icon: Icons.splitscreen_rounded,
                          text: 'Phases: $_phaseCount',
                        ),
                        _MetaRow(
                          icon: Icons.home_work_outlined,
                          text: 'Properties: $_propertyCount',
                        ),
                        _MetaRow(
                          icon: Icons.euro_outlined,
                          text: 'Total value: ${_fmtMoney(_totalPropertyValue)}',
                        ),
                        _MetaRow(
                          icon: Icons.group_outlined,
                          text: 'Buyers: $_buyerCount',
                        ),
                        _MetaRow(
                          icon: Icons.verified_user_outlined,
                          text: 'Verified buyers: $_verifiedBuyerCount',
                        ),

                        const Spacer(),
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
}

// Simple gray placeholder with an icon and label.
class _PlaceholderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image, size: 48, color: Colors.grey.shade500),
          const SizedBox(height: 8),
          Text(
            'No image',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MetaRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade700),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
