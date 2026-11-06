import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/egyptian_license_plate.dart';

/// Screen 07 & 08: Vehicle Profile & Details
/// Matching Figma Frame `21:4777` (Hero `21:4781`, Plate `21:4791`, Specs `21:4835`, Amenities `21:4878`, Docs `21:4927`)
class VehicleScreen extends StatelessWidget {
  const VehicleScreen({super.key});

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
            'بيانات ومواصفات العربية',
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
          actions: [
            IconButton(
              icon: const Icon(Icons.edit_outlined,
                  color: AppColors.brandIndigo, size: 22),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تعديل مواصفات السيارة متاح محلياً.'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
          ],
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
                // Vehicle Hero Showcase Card (Figma Node 21:4781)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.s16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDefault,
                    borderRadius: AppRadius.radiusLg,
                    border: Border.all(color: AppColors.border),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x06000000),
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Verification Status Banner (Node 21:4782)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0FDF4),
                          borderRadius: AppRadius.radiusFull,
                          border: Border.all(
                            color: AppColors.success.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.verified_rounded,
                                size: 14, color: AppColors.success),
                            SizedBox(width: 4),
                            Text(
                              'مركبة معتمدة ومطابقة لمواصفات الأمان',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF166534),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s16),

                      // Vehicle Visual Icon Container (Node 21:4822)
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceMuted,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.brandIndigoLight
                                .withValues(alpha: 0.3),
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.directions_car_filled_rounded,
                          color: AppColors.brandIndigo,
                          size: 52,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s12),

                      // Overlaid Model Tag (Node 21:4825)
                      const Text(
                        'تويوتا كورولا (Toyota Corolla)',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'موديل ٢٠٢٢ • سيدان عائلية • رمادي فيراني',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textMuted,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s16),

                      // Egyptian License Plate & Seating Bar (Node 21:4790)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Reusable Egyptian Plate Widget
                          const EgyptianLicensePlateWidget(
                            letters: 'س ق د',
                            numbers: '٦ ٩ ٤',
                            width: 140,
                            height: 52,
                          ),
                          const SizedBox(width: AppSpacing.s12),
                          // Capacity Pill Module (Node 21:4806)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceMuted,
                              borderRadius: AppRadius.radiusMd,
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.event_seat_rounded,
                                  size: 18,
                                  color: AppColors.brandIndigo,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  '٤ مقاعد للركاب',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.brandIndigoDeep,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.s16),

                // Section 1: Core Vehicle Specifications (Node 21:4835)
                _buildSectionCard(
                  title: 'المواصفات الفنية للسيارة',
                  icon: Icons.tune_rounded,
                  children: [
                    _buildSpecRow('الماركة والموديل', 'Toyota Corolla 2022'),
                    _buildSpecRow('سنة الصنع', '٢٠٢٢'),
                    _buildSpecRow('لون المركبة', 'رمادي فيراني ميتاليك'),
                    _buildSpecRow('نوع ناقل الحركة', 'أوتوماتيك (CVT)'),
                    _buildSpecRow('نوع الوقود', 'بنزين ٩٢ اقتصادي'),
                  ],
                ),

                const SizedBox(height: AppSpacing.s16),

                // Section 2: Comfort & In-Car Amenities (Node 21:4878)
                _buildSectionCard(
                  title: 'مميزات الراحة والتجربة في الرحلة',
                  icon: Icons.thumb_up_alt_outlined,
                  children: [
                    _buildAmenityRow(
                      icon: Icons.ac_unit_rounded,
                      title: 'تكييف هواء يعمل بكفاءة ممتازة ❄️',
                      subtitle: 'درجة حرارة مريحة صيفاً وشتاءً',
                    ),
                    _buildAmenityRow(
                      icon: Icons.smoke_free_rounded,
                      title: 'ممنوع التدخين داخل السيارة 🚭',
                      subtitle: 'بيئة نظيفة ومريحة لجميع الركاب',
                    ),
                    _buildAmenityRow(
                      icon: Icons.luggage_rounded,
                      title: 'حقيبة سفر متوسطة لكل راكب 🧳',
                      subtitle: 'شنطة خلفية واسعة ونظيفة',
                    ),
                    _buildAmenityRow(
                      icon: Icons.battery_charging_full_rounded,
                      title: 'شاحن هاتف محمول متاح (Type-C / Lightning) 🔌',
                      subtitle: 'لشحن جهازك أثناء الطريق',
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.s16),

                // Section 3: Verification Documents & Safety Status (Node 21:4927)
                _buildSectionCard(
                  title: 'مستندات المركبة والفحص الفني',
                  icon: Icons.assignment_turned_in_outlined,
                  children: [
                    _buildDocStatusRow(
                      title: 'رخصة تسيير المركبة (المرور)',
                      status: 'سارية حتى ديسمبر ٢٠٢٥',
                      isValid: true,
                    ),
                    _buildDocStatusRow(
                      title: 'الفحص الفني الدوري للسيارة',
                      status: 'فحص معتمد وسارٍ',
                      isValid: true,
                    ),
                    _buildDocStatusRow(
                      title: 'وثيقة التأمين الإجباري',
                      status: 'مفعلة وسارية بالكامل',
                      isValid: true,
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.s20),

                // Bottom Action CTA & Compliance Note (Node 21:4983)
                CustomButton(
                  text: 'تعديل مواصفات وبيانات العربية',
                  height: 50,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('طلب تحديث بيانات السيارة قيد المراجعة.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppSpacing.s8),

                const Center(
                  child: Text(
                    'يتم التحقق من أي تعديل جديد على بيانات السيارة خلال ساعات.',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.s20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
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
            children: [
              Icon(icon, color: AppColors.brandIndigo, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: AppRadius.radiusSm,
            ),
            child: Icon(icon, color: AppColors.brandIndigo, size: 16),
          ),
          const SizedBox(width: AppSpacing.s10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocStatusRow({
    required String title,
    required String status,
    required bool isValid,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                isValid
                    ? Icons.check_circle_outline_rounded
                    : Icons.access_time_rounded,
                color: isValid ? AppColors.success : AppColors.warning,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          Text(
            status,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isValid ? AppColors.success : AppColors.warning,
            ),
          ),
        ],
      ),
    );
  }
}
