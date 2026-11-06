import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../logic/payment_ui_cubit.dart';
import '../logic/payment_ui_state.dart';

/// Screen 01: Payment Method Selection
/// Matching Figma Frame `21:3847` (Section `21:3948`)
class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentUiCubit(),
      child: const _PaymentMethodView(),
    );
  }
}

class _PaymentMethodView extends StatelessWidget {
  const _PaymentMethodView();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.surfaceDefault,
        appBar: AppBar(
          backgroundColor: AppColors.surfaceDefault,
          elevation: 0,
          title: const Text(
            'طريقة الدفع',
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
          child: BlocBuilder<PaymentUiCubit, PaymentUiState>(
            builder: (context, state) {
              final cubit = context.read<PaymentUiCubit>();

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16,
                        vertical: AppSpacing.s12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Subtle Progress Stepper (Figma Node 21:3850)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.s16,
                              vertical: AppSpacing.s12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceMuted,
                              borderRadius: AppRadius.radiusMd,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(
                                    color: AppColors.brandIndigo,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '١',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.s8),
                                const Text(
                                  'الخطوة الأولى: تحديد وسيلة الدفع المفضلة',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.brandIndigoDeep,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: AppSpacing.s20),

                          // Heading
                          const Text(
                            'اختر طريقة دفع المشوار',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'خيارات دفع مرنة ومحايدة تناسب احتياجك في سِكّة.',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textMuted,
                            ),
                          ),

                          const SizedBox(height: AppSpacing.s16),

                          // Option 1: Cash (Direct to Captain - Selected by default, Node 21:3954)
                          _buildPaymentOptionCard(
                            context: context,
                            title: 'كاش مباشرة للكابتن (الدفع النقدي)',
                            subtitle:
                                'تدفع المبلغ المطلوب ٧٠ ج.م نقداً للكابتن عند الوصول لنقطة النزول بدون أي عمولات مخفية أو زيادات.',
                            badgeText: 'الخيار الشائع والأسرع',
                            icon: Icons.payments_rounded,
                            isSelected:
                                state.selectedMethod == PaymentMethodType.cash,
                            onTap: () => cubit
                                .selectPaymentMethod(PaymentMethodType.cash),
                          ),

                          const SizedBox(height: AppSpacing.s12),

                          // Option 2: Digital Payment (Provider-Neutral, Node 21:3977)
                          _buildPaymentOptionCard(
                            context: context,
                            title: 'الدفع الإلكتروني (محفظة سِكّة / بطاقة)',
                            subtitle:
                                'الدفع الفوري الآمن داخل التطبيق عبر رصيد محفظتك الرقمية أو كروت ميزة وفيزا بدون الحاجة لفكة.',
                            badgeText: 'بدون فكة أو نقود ورقية',
                            icon: Icons.account_balance_wallet_rounded,
                            isSelected: state.selectedMethod ==
                                PaymentMethodType.digitalWallet,
                            onTap: () => cubit.selectPaymentMethod(
                                PaymentMethodType.digitalWallet),
                          ),

                          const SizedBox(height: AppSpacing.s20),

                          // Communal Transparency Card (Figma Node 21:3997)
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.s14),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceIndigoTintLight,
                              borderRadius: AppRadius.radiusMd,
                              border: Border.all(
                                color: AppColors.brandIndigo
                                    .withValues(alpha: 0.15),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.info_outline_rounded,
                                  color: AppColors.brandIndigo,
                                  size: 20,
                                ),
                                const SizedBox(width: AppSpacing.s10),
                                const Expanded(
                                  child: Text(
                                    'سِكّة ليست خدمة تاكسي أو نقل أجرة، بل منصة لمشاركة تكاليف الطريق الفعلية بين أفراد المجتمع.',
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
                        ],
                      ),
                    ),
                  ),

                  // Bottom Action CTA
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.s16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceDefault,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -3),
                        ),
                      ],
                    ),
                    child: CustomButton(
                      text:
                          'متابعة لتأكيد الحجز (${state.totalFare.toStringAsFixed(0)} ج.م)',
                      height: 52,
                      onPressed: () {
                        context.push(
                          '/payment-confirmation',
                          extra: state.selectedMethod,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOptionCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String badgeText,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.radiusMd,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.s16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.brandIndigo.withValues(alpha: 0.04)
              : AppColors.surfaceDefault,
          borderRadius: AppRadius.radiusMd,
          border: Border.all(
            color: isSelected ? AppColors.brandIndigo : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.brandIndigo.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Radio Indicator
            Container(
              width: 22,
              height: 22,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.brandIndigo : AppColors.textMuted,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: AppColors.brandIndigo,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: AppSpacing.s12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon,
                          color: isSelected
                              ? AppColors.brandIndigo
                              : AppColors.textSecondary,
                          size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? AppColors.brandIndigoDeep
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.brandIndigo.withValues(alpha: 0.1)
                          : AppColors.surfaceMuted,
                      borderRadius: AppRadius.radiusSm,
                    ),
                    child: Text(
                      badgeText,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? AppColors.brandIndigo
                            : AppColors.textMuted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
