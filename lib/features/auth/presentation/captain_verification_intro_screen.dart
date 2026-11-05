import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_button.dart';
import 'login_screen.dart';

/// Screen 10: Captain Verification Intro (قبل ما تبدأ رحلاتك)
/// Figma Node ID: `21:225`
class CaptainVerificationIntroScreen extends StatelessWidget {
  const CaptainVerificationIntroScreen({super.key});

  void _onStartVerification(BuildContext context) {
    // Local interactive presentation feedback
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.radiusLg,
            ),
            title: const Row(
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 28,
                ),
                SizedBox(width: 8),
                Text(
                  'تم استلام طلب التوثيق!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: const Text(
              'أوراقك وبيانات عربيتك قيد المراجعة اليدوية السريعة (خلال ١٢ - ٢٤ ساعة). سنرسل لك إشعاراً فورياً بمجرد الاعتماد لتتمكن من إنشاء أول رحلة ككابتن في سِكّة.',
              style: TextStyle(fontSize: 14, height: 1.45),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  // Return to Login screen or previous safe route
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
                child: const Text(
                  'العودة لتسجيل الدخول',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.brandIndigoDeep,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onLaterAsPassenger(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white.withValues(alpha: 0.95),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.textPrimary,
              size: 20,
            ),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          centerTitle: true,
          title: const Text(
            'Captain Verification Intro',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.brandIndigo,
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s16,
                    vertical: AppSpacing.s8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Sub-header Capsules from Figma
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F3FF),
                              borderRadius: AppRadius.radiusFull,
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  'مطلوب قبل نشر الرحلات',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                SizedBox(width: 4),
                                CircleAvatar(
                                  radius: 4,
                                  backgroundColor: Color(0xFFF59E0B),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE1E8FD),
                              borderRadius: AppRadius.radiusFull,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x0D000000),
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  'أمان وموثوقية سِكّة',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.brandIndigoDeep,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.verified_user_rounded,
                                  size: 14,
                                  color: AppColors.brandIndigoDeep,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.s16),

                      // Hero Header Area with Route Wave & Shield Emblem
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.s20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFE2DFFF),
                              Color(0xFFF1F3FF),
                            ],
                          ),
                          borderRadius: AppRadius.radiusLg,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x08000000),
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Shield Emblem with check badge
                            Center(
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    width: 76,
                                    height: 76,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x14000000),
                                          blurRadius: 8,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 54,
                                        height: 54,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.brandIndigo,
                                        ),
                                        child: const Icon(
                                          Icons.security_rounded,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 26,
                                    height: 26,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFFFE083),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x1A000000),
                                          blurRadius: 4,
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.check_rounded,
                                      size: 16,
                                      color: Color(0xFF231B00),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: AppSpacing.s12),

                            // Heading
                            const Text(
                              'قبل ما تبدأ رحلاتك',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                                letterSpacing: -0.5,
                              ),
                            ),

                            const SizedBox(height: 6),

                            // Subheading
                            const Text(
                              'محتاجين نتأكد من بياناتك وعربيتك علشان نخلي سِكّة أكثر أمانًا وثقة للجميع على الطريق.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                                height: 1.45,
                              ),
                            ),

                            const SizedBox(height: AppSpacing.s12),

                            // Benefits ticker
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.groups_rounded,
                                      size: 14,
                                      color: AppColors.textSecondary,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'أولوية الحجز للكباتن الموثقين',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: CircleAvatar(
                                    radius: 2,
                                    backgroundColor: Color(0xFFC7C4D8),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.lock_rounded,
                                      size: 14,
                                      color: AppColors.success,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'بياناتك محمية ومشفرة',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s20),

                      // Verification Steps Checklist (3 Steps)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'خطوات التوثيق (٣ خطوات)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE2DFFF),
                              borderRadius: AppRadius.radiusFull,
                            ),
                            child: const Text(
                              'جاهزة الآن',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.brandIndigoDeep,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.s10),

                      // 3-step vertical card
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: AppRadius.radiusLg,
                          border: Border.all(color: const Color(0xFFE1E8FD)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x06000000),
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Step 1: Personal Info
                            _buildStepRow(
                              stepNumber: '١',
                              title: 'بياناتك الشخصية',
                              badgeText: 'جاهزة للإدخال',
                              badgeColor: AppColors.brandIndigo,
                              description:
                                  'بطاقة الرقم القومي سارية ومطابقة للصورة الشخصية لتأكيد هويتك ككابتن موثوق.',
                              isFirst: true,
                              isActive: true,
                            ),

                            const Divider(height: 1, color: Color(0xFFE1E8FD)),

                            // Step 2: Vehicle Info
                            _buildStepRow(
                              stepNumber: '٢',
                              title: 'بيانات العربية',
                              badgeText: 'خطوة ٢',
                              badgeColor: AppColors.textSecondary,
                              description:
                                  'الماركة والموديل وسنة الصنع ورقم اللوحات المعدنية وعدد الكراسي المتاحة للركاب.',
                            ),

                            const Divider(height: 1, color: Color(0xFFE1E8FD)),

                            // Step 3: Required Docs
                            _buildStepRow(
                              stepNumber: '٣',
                              title: 'المستندات المطلوبة',
                              badgeText: 'خطوة ٣',
                              badgeColor: AppColors.textSecondary,
                              description:
                                  'صورة واضحة لرخصة القيادة ورخصة تسيير السيارة وتكون سارية المفعول.',
                              isLast: true,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s16),

                      // Why Verification Mandatory Card from Figma
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.s16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F3FF),
                          borderRadius: AppRadius.radiusLg,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFE083),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.help_outline_rounded,
                                    size: 20,
                                    color: Color(0xFF231B00),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.s10),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ليه التحقق إجباري؟',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    Text(
                                      'مجتمع سِكّة مبني على الأمان المتبادل',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.s10),
                            const Text(
                              'كل كباتن سِكّة بيتم فحص أوراقهم يدويًا وبدقة عشان نضمن رحلة آمنة، مريحة، وموثوقة لكل راكب يركب معاك، وعشان حقك ككابتن يكون محفوظ ومحمي.',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.s10),

                            // Turnaround time capsule
                            Container(
                              padding: const EdgeInsets.all(AppSpacing.s10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: AppRadius.radiusMd,
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.schedule_rounded,
                                    size: 18,
                                    color: Color(0xFFF59E0B),
                                  ),
                                  SizedBox(width: AppSpacing.s8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'المراجعة بتاخد من ١٢ إلى ٢٤ ساعة فقط',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        Text(
                                          'وهنبعتلك إشعار فوري بأول ما يتوافق على حسابك',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s16),

                      // Social Proof Card from Figma
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.s14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: AppRadius.radiusLg,
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.verified_rounded,
                                  color: AppColors.success,
                                  size: 22,
                                ),
                                SizedBox(width: AppSpacing.s8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '+٥٠٠٠ كابتن موثق',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    Text(
                                      'بيشاركوا رحلات يومية في القاهرة والجيزة',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // Overlapping avatar circles from Figma
                            Row(
                              children: [
                                _buildAvatarCircle(
                                  text: '+٥ك',
                                  bgColor: const Color(0xFFE1E8FD),
                                  textColor: AppColors.textPrimary,
                                ),
                                Transform.translate(
                                  offset: const Offset(-8, 0),
                                  child: _buildAvatarCircle(
                                    text: 'س',
                                    bgColor: const Color(0xFFEADDFF),
                                    textColor: AppColors.brandViolet,
                                  ),
                                ),
                                Transform.translate(
                                  offset: const Offset(-16, 0),
                                  child: _buildAvatarCircle(
                                    text: 'ك',
                                    bgColor: const Color(0xFFE2DFFF),
                                    textColor: AppColors.brandIndigo,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s20),
                    ],
                  ),
                ),
              ),

              // Bottom Action CTAs
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.s16,
                  AppSpacing.s8,
                  AppSpacing.s16,
                  AppSpacing.s20,
                ),
                child: Column(
                  children: [
                    CustomButton(
                      text: 'ابدأ التحقق الآن',
                      height: 52,
                      onPressed: () => _onStartVerification(context),
                      prefixIcon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s8),
                    InkWell(
                      onTap: () => _onLaterAsPassenger(context),
                      borderRadius: AppRadius.radiusMd,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 16.0,
                        ),
                        child: Text(
                          'هعملها بعدين ومتابعة كراكب',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepRow({
    required String stepNumber,
    required String title,
    required String badgeText,
    required Color badgeColor,
    required String description,
    bool isFirst = false,
    bool isLast = false,
    bool isActive = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.s16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step number circle
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? AppColors.brandIndigo : const Color(0xFFE1E8FD),
            ),
            child: Center(
              child: Text(
                stepNumber,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          ),

          const SizedBox(width: AppSpacing.s12),

          // Content
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
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor.withValues(alpha: 0.12),
                        borderRadius: AppRadius.radiusFull,
                      ),
                      child: Text(
                        badgeText,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: badgeColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarCircle({
    required String text,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
