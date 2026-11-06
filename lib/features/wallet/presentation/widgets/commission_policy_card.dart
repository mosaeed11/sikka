import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// Commission Policy Explanation Component
/// Matching Figma Frame `21:3441` (Node `21:3536` & Formula Block `21:3481`)
class CommissionPolicyCard extends StatelessWidget {
  final double captainPercent;
  final double sikkaPercent;

  const CommissionPolicyCard({
    super.key,
    this.captainPercent = 90.0,
    this.sikkaPercent = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDefault,
        borderRadius: AppRadius.radiusLg,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: const [
              Icon(
                Icons.handshake_rounded,
                color: AppColors.brandIndigo,
                size: 20,
              ),
              SizedBox(width: AppSpacing.s8),
              Text(
                'سياسة عمولة سِكّة العادلة',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'سِكّة تأخذ فقط ١٠٪ لتشغيل المنصة والتأمين على المشاوير، وتترك لك ٩٠٪ كاملة لعائد وقودك واستهلاك سيارتك بدون أي استقطاعات مفاجئة.',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.s14),
          // Dual-Color Progress Bar
          ClipRRect(
            borderRadius: AppRadius.radiusFull,
            child: SizedBox(
              height: 10,
              child: Row(
                children: [
                  Expanded(
                    flex: captainPercent.toInt(),
                    child: Container(
                      color: AppColors.brandIndigo,
                    ),
                  ),
                  Expanded(
                    flex: sikkaPercent.toInt(),
                    child: Container(
                      color: AppColors.brandViolet,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Labels Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.brandIndigo,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'عائد الكابتن (${captainPercent.toInt()}٪)',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brandIndigoDeep,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.brandViolet,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'عمولة سِكّة (${sikkaPercent.toInt()}٪ فقط)',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brandViolet,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
