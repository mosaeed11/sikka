import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/route_spine_widget.dart';
import '../logic/payment_ui_cubit.dart';
import '../logic/payment_ui_state.dart';

/// Screen 02: Payment Confirmation & Checkout
/// Matching Figma Frame `21:3847` (Summary `21:3862`, Pricing `21:3915`, CTA `21:4024`)
class PaymentConfirmationScreen extends StatelessWidget {
  final PaymentMethodType initialMethod;

  const PaymentConfirmationScreen({
    super.key,
    this.initialMethod = PaymentMethodType.cash,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentUiCubit()..selectPaymentMethod(initialMethod),
      child: const _PaymentConfirmationView(),
    );
  }
}

class _PaymentConfirmationView extends StatelessWidget {
  const _PaymentConfirmationView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentUiCubit, PaymentUiState>(
      listener: (context, state) {
        if (state.isConfirmed) {
          context.read<PaymentUiCubit>().resetConfirmation();
          // Navigate to Ride Receipt
          context.pushReplacement('/ride-receipt', extra: state);
        }
      },
      builder: (context, state) {
        final cubit = context.read<PaymentUiCubit>();

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: AppColors.surfaceSoft,
            appBar: AppBar(
              backgroundColor: AppColors.surfaceDefault,
              elevation: 0,
              title: const Text(
                'تأكيد الحجز والتسعير',
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
              child: Column(
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
                              vertical: AppSpacing.s10,
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
                                    color: AppColors.success,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.s8),
                                const Text(
                                  'الخطوة الثانية: مراجعة المسار والتسعير العادل',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.brandIndigoDeep,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: AppSpacing.s16),

                          // Ride Summary Card (Route-First Spine, Node 21:3862)
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.s16),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceDefault,
                              borderRadius: AppRadius.radiusLg,
                              border: Border.all(color: AppColors.border),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x06000000),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Timing & Distance Header Pill
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.brandIndigo
                                            .withValues(alpha: 0.08),
                                        borderRadius: AppRadius.radiusFull,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.access_time_filled_rounded,
                                            size: 14,
                                            color: AppColors.brandIndigo,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            state.formattedDate,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.brandIndigo,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '${state.distanceKm.toStringAsFixed(0)} كم • ${state.durationMin} دقيقة',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                  ],
                                ),

                                const Divider(
                                    height: 24, color: AppColors.border),

                                // Route Spine
                                RouteSpineWidget(
                                  originTitle: state.originTitle,
                                  originSubtitle: state.originSubtitle,
                                  destinationTitle: state.destinationTitle,
                                  destinationSubtitle:
                                      state.destinationSubtitle,
                                ),

                                const Divider(
                                    height: 24, color: AppColors.border),

                                // Captain Trust Badge Profile (Node 21:3893)
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: AppColors.brandVioletSoft,
                                      child: const Icon(
                                        Icons.person_rounded,
                                        color: AppColors.brandIndigo,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.s12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                state.captainName,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.textPrimary,
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 6,
                                                  vertical: 1,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: AppColors.success
                                                      .withValues(alpha: 0.1),
                                                  borderRadius:
                                                      AppRadius.radiusFull,
                                                ),
                                                child: const Text(
                                                  'موثق',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.success,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            state.captainVehicle,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: AppColors.textMuted,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Rating Pill
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.surfaceMuted,
                                        borderRadius: AppRadius.radiusSm,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star_rounded,
                                            size: 14,
                                            color: AppColors.accentYellow,
                                          ),
                                          const SizedBox(width: 2),
                                          Text(
                                            state.captainRating.toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.textPrimary,
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

                          // Dynamic Price Breakdown Card (Figma Node 21:3915)
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
                                  'تفاصيل الأجرة والتسعير',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.s12),
                                // Base Fare Line
                                _buildPriceRow(
                                  label:
                                      'أجرة مشاركة المسار (${state.distanceKm.toStringAsFixed(0)} كم)',
                                  amount:
                                      '${state.baseFare.toStringAsFixed(0)} ج.م',
                                ),
                                const SizedBox(height: 8),
                                // Service Fee Line
                                _buildPriceRow(
                                  label: 'رسوم خدمة وتأمين الرحلة (سِكّة)',
                                  amount:
                                      '${state.platformFee.toStringAsFixed(0)} ج.م',
                                ),
                                const Divider(
                                    height: 20, color: AppColors.border),
                                // Total Line
                                _buildPriceRow(
                                  label: 'المبلغ الإجمالي المستحق',
                                  amount:
                                      '${state.totalFare.toStringAsFixed(0)} ج.م',
                                  isTotal: true,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: AppSpacing.s16),

                          // Selected Payment Method Strip
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.s16,
                              vertical: AppSpacing.s12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceDefault,
                              borderRadius: AppRadius.radiusMd,
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      state.selectedMethod ==
                                              PaymentMethodType.cash
                                          ? Icons.payments_rounded
                                          : Icons.account_balance_wallet_rounded,
                                      color: AppColors.brandIndigo,
                                      size: 20,
                                    ),
                                    const SizedBox(width: AppSpacing.s10),
                                    Text(
                                      state.selectedMethod ==
                                              PaymentMethodType.cash
                                          ? 'الدفع نقداً للكابتن مباشرة'
                                          : 'الدفع من رصيد المحفظة الإلكترونية',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () => context.pop(),
                                  child: const Text(
                                    'تغيير',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.brandIndigo,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: AppSpacing.s16),

                          // Visual Ride Guarantee Snapshot (Figma Node 21:4008)
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.s14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0FDF4), // Mint Success Tint
                              borderRadius: AppRadius.radiusMd,
                              border: Border.all(
                                color: AppColors.success.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.verified_user_rounded,
                                  color: AppColors.success,
                                  size: 22,
                                ),
                                SizedBox(width: AppSpacing.s10),
                                Expanded(
                                  child: Text(
                                    'ضمان سِكّة: رحلة مسجلة بالكامل مع إمكانية مشاركة مسار التتبع المباشر لحظياً مع عائلتك.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF166534),
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

                  // Fixed Bottom Action Drawer (Figma Node 21:4024)
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomButton(
                          text:
                              'تأكيد الحجز والدفع (${state.totalFare.toStringAsFixed(0)} ج.م)',
                          height: 52,
                          isLoading: state.isProcessing,
                          onPressed: cubit.confirmCheckout,
                        ),
                        const SizedBox(height: AppSpacing.s8),
                        TextButton(
                          onPressed: () => context.pop(),
                          child: const Text(
                            'تعديل تفاصيل المشوار',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textMuted,
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
      },
    );
  }

Widget _buildPriceRow({
  required String label,
  required String amount,
  bool isTotal = false,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: isTotal ? 14 : 13,
          fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
        ),
      ),
      Text(
        amount,
        style: TextStyle(
          fontSize: isTotal ? 16 : 13,
          fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
          color: isTotal ? AppColors.brandIndigoDeep : AppColors.textPrimary,
        ),
      ),
    ],
  );
}
}
