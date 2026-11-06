import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../logic/finance_ui_cubit.dart';
import '../logic/finance_ui_state.dart';

/// Screen 07 & 09: Captain Earnings & Financial Details
/// Matching Figma Frame `21:2308` (Period Selector `21:2321`, Balance `21:2328`, Trust Meter `21:2399`, Ledger `21:2406`)
class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FinanceUiCubit(),
      child: const _EarningsView(),
    );
  }
}

class _EarningsView extends StatelessWidget {
  const _EarningsView();

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
            'تفاصيل الأرباح والمحفظة',
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
          child: BlocConsumer<FinanceUiCubit, FinanceUiState>(
            listener: (context, state) {
              if (state.isSettledSuccessfully) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تمت تسوية المستحقات بنجاح!'),
                    backgroundColor: AppColors.success,
                  ),
                );
                context.read<FinanceUiCubit>().resetSettlementStatus();
              }
            },
            builder: (context, state) {
              final cubit = context.read<FinanceUiCubit>();

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s16,
                  vertical: AppSpacing.s12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Period Selector Pills (Node 21:2321)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceDefault,
                        borderRadius: AppRadius.radiusMd,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildSelectorPill(
                              title: 'اليوم',
                              isSelected:
                                  state.timeFilter == FinanceTimeFilter.today,
                              onTap: () =>
                                  cubit.setTimeFilter(FinanceTimeFilter.today),
                            ),
                          ),
                          Expanded(
                            child: _buildSelectorPill(
                              title: 'هذا الأسبوع',
                              isSelected: state.timeFilter ==
                                  FinanceTimeFilter.thisWeek,
                              onTap: () => cubit
                                  .setTimeFilter(FinanceTimeFilter.thisWeek),
                            ),
                          ),
                          Expanded(
                            child: _buildSelectorPill(
                              title: 'هذا الشهر',
                              isSelected: state.timeFilter ==
                                  FinanceTimeFilter.thisMonth,
                              onTap: () => cubit
                                  .setTimeFilter(FinanceTimeFilter.thisMonth),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.s16),

                    // Main Financial Balance Card (Node 21:2328)
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.s20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.brandIndigoDark,
                            AppColors.brandIndigoDeep,
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                        borderRadius: AppRadius.radiusXl,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.brandIndigo.withValues(alpha: 0.3),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'صافي العائد المستلم (كاش وإلكتروني)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textOnDark,
                                ),
                              ),
                              Icon(
                                Icons.monetization_on_rounded,
                                color: AppColors.accentYellow,
                                size: 20,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${state.netEarnings.toStringAsFixed(0)} ج.م',
                            style: const TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.s14),
                          // Transparent Commission Breakdown Box (Node 21:2345)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.s12,
                              vertical: AppSpacing.s8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              borderRadius: AppRadius.radiusMd,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'إجمالي المشاوير: ${state.grossEarnings.toStringAsFixed(0)} ج.م',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.accentYellow,
                                    borderRadius: AppRadius.radiusXs,
                                  ),
                                  child: const Text(
                                    '١٠٪ عمولة سِكّة',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.s16),

                    // Outstanding Balance & Commission Settlement Box (Node 21:2372)
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'العمولة المستحقة غير المسددة',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'ناتجة عن مشاوير الدفع النقدي مع الركاب',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${state.outstandingCommission.toStringAsFixed(0)} ج.م',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.brandIndigoDeep,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.s12),
                          // Trust meter & safety limit (Node 21:2399)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'مؤشر حد الأمان: ${state.outstandingCommission.toStringAsFixed(0)} / ${state.maxAllowedDebtThreshold.toStringAsFixed(0)} ج.م',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    state.isSuspended
                                        ? 'تم تجاوز الحد'
                                        : 'ضمن النطاق الآمن',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: state.isSuspended
                                          ? AppColors.error
                                          : AppColors.success,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: AppRadius.radiusFull,
                                child: LinearProgressIndicator(
                                  value: (state.outstandingCommission /
                                          state.maxAllowedDebtThreshold)
                                      .clamp(0.0, 1.0),
                                  backgroundColor: AppColors.border,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    state.isSuspended
                                        ? AppColors.error
                                        : AppColors.brandIndigo,
                                  ),
                                  minHeight: 6,
                                ),
                              ),
                            ],
                          ),
                          if (state.outstandingCommission > 0) ...[
                            const SizedBox(height: AppSpacing.s14),
                            CustomButton(
                              text:
                                  'سداد وتسوية العمولة (${state.outstandingCommission.toStringAsFixed(0)} ج.م)',
                              height: 44,
                              isLoading: state.isSettling,
                              onPressed: cubit.settleCommission,
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.s16),

                    // Platform Promise Note (Figma Node 21:2480 - Verified 10% Only!)
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
                            Icons.shield_outlined,
                            color: AppColors.brandIndigo,
                            size: 22,
                          ),
                          SizedBox(width: AppSpacing.s10),
                          Expanded(
                            child: Text(
                              'عهد سِكّة الشفاف: عمولتنا ١٠٪ فقط لدعم النظام والتأمين على المشاوير، دون أي رسوم إضافية مخفية على الإطلاق.',
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

                    // Ledger Header (Node 21:2406)
                    const Text(
                      'دفتر المشاوير المكتملة وحساب العمولة',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s10),

                    ...state.recentTrips.map((item) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: AppSpacing.s10),
                        padding: const EdgeInsets.all(AppSpacing.s14),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceDefault,
                          borderRadius: AppRadius.radiusMd,
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.routeTitle,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item.dateText,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '+${item.grossFare.toStringAsFixed(0)} ج.م',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.success,
                                  ),
                                ),
                                Text(
                                  'عمولة ١٠٪: -${item.commissionDeducted.toStringAsFixed(0)} ج.م',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),

                    const SizedBox(height: AppSpacing.s20),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSelectorPill({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.radiusSm,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.brandIndigo : Colors.transparent,
          borderRadius: AppRadius.radiusSm,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
