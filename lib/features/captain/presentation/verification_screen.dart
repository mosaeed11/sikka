import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

/// Screen 09 & 10: Verification Status & Documents
/// Matching Figma Frame `21:4049` (Hero `21:4055`, Documents Matrix `21:4101`, Actions `21:4171`)
class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.surfaceSoft,
        appBar: AppBar(
          backgroundColor: AppColors.surfaceDefault,
          elevation: 0,
          title: const Text(
            'حالة التوثيق والمستندات',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s16,
              vertical: AppSpacing.s12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Verified Hero Status Card (Figma Node 21:4055)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.s20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1E1B4B), // Deep Indigo Dark
                        AppColors.brandIndigo,
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: AppRadius.radiusXl,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.brandIndigo.withValues(alpha: 0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Shield / Check Avatar (Node 21:4067)
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.success,
                            width: 2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.verified_rounded,
                            color: AppColors.success,
                            size: 32,
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s12),

                      // Headline (Node 21:4057)
                      const Text(
                        'حساب كابتن موثق ومعتمد',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Subtitle (Node 21:4060)
                      Text(
                        'تم فحص جميع أوراقك الثبوتية بنجاح ومطابقتها لمعايير الأمان الرسمية في سِكّة.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.8),
                          height: 1.45,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s16),

                      // Captain Identity Mini Profile Pill (Node 21:4076)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: AppRadius.radiusFull,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.shield_rounded,
                                size: 14, color: AppColors.accentYellow),
                            SizedBox(width: 6),
                            Text(
                              'توثيق أمني كامل • مستوى ٣ (موثوق)',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.s20),

                // Multi-State Verification Matrix Header (Node 21:4092)
                const Text(
                  'المستندات التي تم فحصها واعتمادها',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.s12),

                // Documents Matrix Cards (Node 21:4101)
                // 1. National ID (Node 21:4102)
                _buildDocumentCard(
                  icon: Icons.badge_rounded,
                  title: 'بطاقة الرقم القومي المصرية',
                  subtitle: 'الوجه الأمامي والخلفي • مطابقة رقمية',
                  statusText: 'تم التحقق بنجاح ✅',
                  expiryText: 'سارية المفعول',
                  isVerified: true,
                ),

                const SizedBox(height: AppSpacing.s10),

                // 2. Personal Driving License (Node 21:4116)
                _buildDocumentCard(
                  icon: Icons.credit_card_rounded,
                  title: 'رخصة القيادة الشخصية (المرور)',
                  subtitle: 'درجة خاصة / ثالثة سارية',
                  statusText: 'معتمدة ومطابقة ✅',
                  expiryText: 'سارية حتى أغسطس ٢٠٢٧',
                  isVerified: true,
                ),

                const SizedBox(height: AppSpacing.s10),

                // 3. Vehicle Registration (Node 21:4130)
                _buildDocumentCard(
                  icon: Icons.directions_car_rounded,
                  title: 'رخصة تسيير المركبة (السيارة)',
                  subtitle: 'مطابقة لبيانات لوحة س ق د ٦ ٩ ٤',
                  statusText: 'معتمدة ومطابقة ✅',
                  expiryText: 'سارية حتى ديسمبر ٢٠٢٥',
                  isVerified: true,
                ),

                const SizedBox(height: AppSpacing.s10),

                // 4. Vehicle Technical Inspection (Node 21:4144)
                _buildDocumentCard(
                  icon: Icons.fact_check_rounded,
                  title: 'الفحص الفني الدوري والبيئة',
                  subtitle: 'فحص دوري للمحرك والمكابح والأمان',
                  statusText: 'سارٍ ومكتمل ✅',
                  expiryText: 'سارٍ حتى نهاية العام',
                  isVerified: true,
                ),

                const SizedBox(height: AppSpacing.s16),

                // Trust & Safety Commute Insight Card (Node 21:4159)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.s14),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceIndigoTintLight,
                    borderRadius: AppRadius.radiusMd,
                    border: Border.all(
                      color: AppColors.brandIndigo.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.lock_outline_rounded,
                        color: AppColors.brandIndigo,
                        size: 22,
                      ),
                      SizedBox(width: AppSpacing.s10),
                      Expanded(
                        child: Text(
                          'تشفير بياناتك: جميع صور مستنداتك ورخصك مخزنة بأعلى معايير التشفير والخصوصية ولا يطلع عليها الركاب إطلاقاً.',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.brandIndigoDeep,
                            height: 1.45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.s20),

                // Actions Cluster (Figma Node 21:4171)
                // Outline Button: Update Expiring Documents (Node 21:4172)
                OutlinedButton.icon(
                  icon: const Icon(Icons.file_upload_outlined, size: 18),
                  label: const Text('تحديث أو تعديل أي مستند'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.brandIndigo,
                    side: const BorderSide(color: AppColors.brandIndigo),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.radiusMd,
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('جميع مستنداتك الحالية سارية ومكتملة!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppSpacing.s10),

                // Direct Support Link (Node 21:4178)
                TextButton.icon(
                  icon: const Icon(Icons.support_agent_rounded, size: 18),
                  label: const Text('تواصل مع فريق مراجعة التوثيق'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('فريق التوثيق متاح للمساعدة السريعة.'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppSpacing.s20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String statusText,
    required String expiryText,
    required bool isVerified,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s14),
      decoration: BoxDecoration(
        color: AppColors.surfaceDefault,
        borderRadius: AppRadius.radiusMd,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isVerified
                  ? AppColors.success.withValues(alpha: 0.1)
                  : AppColors.surfaceMuted,
              borderRadius: AppRadius.radiusMd,
            ),
            child: Icon(
              icon,
              color: isVerified ? AppColors.success : AppColors.brandIndigo,
              size: 22,
            ),
          ),
          const SizedBox(width: AppSpacing.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      statusText,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceMuted,
                    borderRadius: AppRadius.radiusXs,
                  ),
                  child: Text(
                    expiryText,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
