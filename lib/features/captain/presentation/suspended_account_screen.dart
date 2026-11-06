import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_button.dart';

/// Screen 12: Suspended Captain Account
/// Matching Figma Frame `21:3258` (Hero `21:3374`, Debt `21:3262`, Permissions Matrix `21:3298`, CTA `21:3404`)
class SuspendedAccountScreen extends StatefulWidget {
  final double outstandingDebt;
  final double maxAllowedLimit;

  const SuspendedAccountScreen({
    super.key,
    this.outstandingDebt = 320.0,
    this.maxAllowedLimit = 250.0,
  });

  @override
  State<SuspendedAccountScreen> createState() => _SuspendedAccountScreenState();
}

class _SuspendedAccountScreenState extends State<SuspendedAccountScreen> {
  bool _isSettling = false;

  Future<void> _handleSettle() async {
    setState(() => _isSettling = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _isSettling = false);

    showDialog(
      context: context,
      builder: (dialogCtx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusLg),
          title: Row(
            children: const [
              Icon(Icons.check_circle_rounded,
                  color: AppColors.success, size: 28),
              SizedBox(width: 8),
              Text(
                'تم السداد وتفعيل الحساب!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text(
            'تمت تسوية مديونية العمولة بنجاح. حساب الكابتن الآن نشط وجاهز لاستقبال وإنشاء الرحلات مجدداً.',
            style: TextStyle(fontSize: 13, height: 1.45),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogCtx).pop();
                context.pop();
              },
              child: const Text(
                'العودة للرئيسية',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.brandIndigo,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
            'حالة الحساب',
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
                // Top Suspended Status Hero Card (Figma Node 21:3374)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.s16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2), // Red 50
                    borderRadius: AppRadius.radiusLg,
                    border: Border.all(color: const Color(0xFFFECACA)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.error_outline_rounded,
                          color: AppColors.error,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.s12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'حساب الكابتن موقوف مؤقتاً',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF991B1B),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'تم تعليق استقبال وإنشاء الرحلات مؤقتاً لتجاوز الحد الأقصى المسموح للعمولة غير المسددة.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF7F1D1D),
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.s16),

                // Debt Breakdown Card (Figma Node 21:3262)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.s16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDefault,
                    borderRadius: AppRadius.radiusLg,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'إجمالي العمولة المتأخرة المطلوبة',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            '${widget.outstandingDebt.toStringAsFixed(0)} ج.م',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.error,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'الحد الأقصى المسموح به قبل الإيقاف',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                          Text(
                            '${widget.maxAllowedLimit.toStringAsFixed(0)} ج.م',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20, color: AppColors.border),
                      Row(
                        children: const [
                          Icon(Icons.calendar_today_rounded,
                              size: 14, color: AppColors.textMuted),
                          SizedBox(width: 6),
                          Text(
                            'تاريخ استحقاق السداد: متأخر منذ ٤ أيام',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.s14),

                // Reassurance Banner (Figma Node 21:3288)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.s12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF), // Blue 50
                    borderRadius: AppRadius.radiusMd,
                    border: Border.all(color: const Color(0xFFBFDBFE)),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.info_rounded, color: Color(0xFF1D4ED8), size: 18),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'سيتم إعادة تفعيل حسابك فوراً وبشكل تلقائي بمجرد تأكيد سداد العمولة.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF1E40AF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.s20),

                // Permissions Matrix (Crucial UX Requirement, Node 21:3298)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.s16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDefault,
                    borderRadius: AppRadius.radiusLg,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'مصفوفة الصلاحيات الحالية لحسابك',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s12),

                      // Restricted Section (Node 21:3304)
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.s12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF1F2), // Rose 50
                          borderRadius: AppRadius.radiusMd,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.cancel_rounded,
                                    color: AppColors.error, size: 16),
                                SizedBox(width: 6),
                                Text(
                                  'الخدمات المقيدة مؤقتاً ككابتن:',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.error,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            _buildMatrixItem(
                              'إنشاء أو جدولة رحلات كابتن جديدة',
                              isAllowed: false,
                            ),
                            _buildMatrixItem(
                              'استقبال وقبول طلبات انضمام الركاب',
                              isAllowed: false,
                            ),
                            _buildMatrixItem(
                              'الظهور في نتائج بحث الركاب على المسارات',
                              isAllowed: false,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s12),

                      // Allowed Section (Node 21:3335)
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.s12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0FDF4), // Green 50
                          borderRadius: AppRadius.radiusMd,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.check_circle_rounded,
                                    color: AppColors.success, size: 16),
                                SizedBox(width: 6),
                                Text(
                                  'الخدمات المتاحة لك بحرية تامة:',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.success,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            _buildMatrixItem(
                              'البحث وحجز المقاعد والتنقل كراكب',
                              isAllowed: true,
                            ),
                            _buildMatrixItem(
                              'استعراض سجل رحلاتك السابقة وإيصالات الدفع',
                              isAllowed: true,
                            ),
                            _buildMatrixItem(
                              'إدارة محفظتك وشحن الرصيد الرقمي',
                              isAllowed: true,
                            ),
                            _buildMatrixItem(
                              'التواصل المباشر مع فريق الدعم والمساعدة',
                              isAllowed: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.s20),

                // Settlement Action Section (Figma Node 21:3394)
                CustomButton(
                  text:
                      'سداد العمولة الآن (${widget.outstandingDebt.toStringAsFixed(0)} ج.م)',
                  height: 52,
                  isLoading: _isSettling,
                  onPressed: _handleSettle,
                ),

                const SizedBox(height: AppSpacing.s10),

                // Support Help Button (Node 21:3416)
                OutlinedButton.icon(
                  icon: const Icon(Icons.headset_mic_rounded, size: 18),
                  label: const Text('التواصل مع فريق دعم الكباتن'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.brandIndigo,
                    side: const BorderSide(color: AppColors.border),
                    minimumSize: const Size(double.infinity, 46),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.radiusMd,
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'فريق دعم سِكّة متواجد لمساعدتك على مدار الساعة.',
                        ),
                        duration: Duration(seconds: 2),
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

  Widget _buildMatrixItem(String title, {required bool isAllowed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isAllowed ? Icons.check_rounded : Icons.close_rounded,
            size: 14,
            color: isAllowed ? AppColors.success : AppColors.error,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: isAllowed
                    ? const Color(0xFF166534)
                    : const Color(0xFF991B1B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
