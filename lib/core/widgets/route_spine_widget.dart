import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Reusable Route Transit Spine Component
/// Matching Figma Node `21:3874` & `21:3712`
class RouteSpineWidget extends StatelessWidget {
  final String originTitle;
  final String originSubtitle;
  final String destinationTitle;
  final String destinationSubtitle;
  final bool isCompact;

  const RouteSpineWidget({
    super.key,
    required this.originTitle,
    this.originSubtitle = 'نقطة الركوب',
    required this.destinationTitle,
    this.destinationSubtitle = 'نقطة النزول',
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Visual Spine Column (Dots & Connecting Line)
          Column(
            children: [
              const SizedBox(height: 2),
              // Origin Dot
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: AppColors.brandIndigoLight.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.brandIndigo,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              // Vertical Connector
              Container(
                width: 2,
                height: isCompact ? 30 : 42,
                color: AppColors.border,
                margin: const EdgeInsets.symmetric(vertical: 2),
              ),
              // Destination Pin Dot
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: AppColors.brandVioletSoft,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.location_on_rounded,
                    size: 11,
                    color: AppColors.brandViolet,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.s12),
          // Text Descriptions Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Origin
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      originTitle,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (originSubtitle.isNotEmpty) ...[
                      const SizedBox(height: 1),
                      Text(
                        originSubtitle,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: isCompact ? 16 : 24),
                // Destination
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destinationTitle,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (destinationSubtitle.isNotEmpty) ...[
                      const SizedBox(height: 1),
                      Text(
                        destinationSubtitle,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
