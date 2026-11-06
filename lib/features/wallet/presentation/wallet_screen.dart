import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../logic/finance_ui_cubit.dart';
import '../logic/finance_ui_state.dart';
import 'widgets/commission_policy_card.dart';

/// Screen 06-08: Captain Finance & Commission
/// Matching Figma Frame `21:3441` (Hero `21:3462`, Commission `21:3516`, Ledger `21:3554`)
class WalletScreen extends StatelessWidget {
  final bool showAppBar;

  const WalletScreen({
    super.key,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FinanceUiCubit(),
      child: _WalletView(showAppBar: showAppBar),
    );
  }
}

class _WalletView extends StatelessWidget {
  final bool showAppBar;

  const _WalletView({required this.showAppBar});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.surfaceSoft,
        appBar: showAppBar
            ? AppBar(
                backgroundColor: AppColors.surfaceDefault,
                elevation: 0,
                title: const Text(
                  'الإيرادات والعمولة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.info_outline_rounded,
                        color: AppColors.brandIndigo),
                    onPressed: () {
                      context.push('/earnings-details');
                    },
                  ),
                ],
              )
            : null,
        body: SafeArea(
          child: BlocConsumer<FinanceUiCubit, FinanceUiState>(
            listener: (context, state) {
              if (state.isSettledSuccessfully) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تمت تسوية العمولة وتحديث الحساب بنجاح!'),
                    backgroundColor: AppColors.success,
                    duration: Duration(seconds: 2),
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
                    // Time Filter Tabs (Figma Node 21:3444)
                    _buildTimeFilterTabs(context, state, cubit),

                    const SizedBox(height: AppSpacing.s16),

                    // Suspended Account Alert Banner (if applicable or test mode)
                    if (state.isSuspended) ...[
                      _buildSuspensionAlert(context),
                      const SizedBox(height: AppSpacing.s16),
                    ],

                    // Hero Transparent Earnings Summary Card (Node 21:3462)
                    _buildHeroEarningsCard(context, state),

                    const SizedBox(height: AppSpacing.s16),

                    // Outstanding Cash Commission Notice Card (Node 21:3516)
                    _buildOutstandingCommissionCard(context, state, cubit),

                    const SizedBox(height: AppSpacing.s16),

                    // Commission Policy Explanation Card (Node 21:3536)
                    const CommissionPolicyCard(
                      captainPercent: 90.0,
                      sikkaPercent: 10.0,
                    ),

                    const SizedBox(height: AppSpacing.s20),

                    // Recent Completed Trips Ledger (Node 21:3554)
                    _buildRecentTransactionsHeader(context),
                    const SizedBox(height: AppSpacing.s10),
                    ...state.recentTrips.map(
                      (trip) => _buildTransactionItem(context, trip),
                    ),

                    const SizedBox(height: AppSpacing.s20),

                    // Simulation Demo Switcher for Suspended Account testing
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.s12),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceMuted,
                        borderRadius: AppRadius.radiusMd,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'معاينة شاشة الحساب الموقوف (محاكاة):',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Switch(
                            value: state.isSuspended,
                            activeThumbColor: AppColors.error,
                            onChanged: (val) {
                              cubit.toggleSuspensionForDemo(val);
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.s24),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTimeFilterTabs(
    BuildContext context,
    FinanceUiState state,
    FinanceUiCubit cubit,
  ) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceDefault,
        borderRadius: AppRadius.radiusMd,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildFilterPill(
              title: 'اليوم',
              isSelected: state.timeFilter == FinanceTimeFilter.today,
              onTap: () => cubit.setTimeFilter(FinanceTimeFilter.today),
            ),
          ),
          Expanded(
            child: _buildFilterPill(
              title: 'هذا الأسبوع',
              isSelected: state.timeFilter == FinanceTimeFilter.thisWeek,
              onTap: () => cubit.setTimeFilter(FinanceTimeFilter.thisWeek),
            ),
          ),
          Expanded(
            child: _buildFilterPill(
              title: 'هذا الشهر',
              isSelected: state.timeFilter == FinanceTimeFilter.thisMonth,
              onTap: () => cubit.setTimeFilter(FinanceTimeFilter.thisMonth),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterPill({
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

  Widget _buildSuspensionAlert(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/suspended-account'),
      borderRadius: AppRadius.radiusMd,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.s14),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF2F2), // Red 50
          borderRadius: AppRadius.radiusMd,
          border: Border.all(color: AppColors.error),
        ),
        child: Row(
          children: [
            const Icon(Icons.warning_amber_rounded,
                color: AppColors.error, size: 24),
            const SizedBox(width: AppSpacing.s10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'تنبيه: حساب الكابتن موقوف مؤقتاً',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.error,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'تجاوزت العمولة المستحقة الحد الأقصى (٢٥٠ ج.م). اضغط للسداد.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF991B1B),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_back_ios_rounded,
                size: 14, color: AppColors.error),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroEarningsCard(BuildContext context, FinanceUiState state) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.brandIndigoDark,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'صافي أرباحك المقدرة',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textOnDark,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: AppRadius.radiusFull,
                ),
                child: const Text(
                  'وضع مالي نشط',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${state.netEarnings.toStringAsFixed(0)} ج.م',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.s16),
          // Quick Metrics Strip (Node 21:3504)
          Container(
            padding: const EdgeInsets.all(AppSpacing.s12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: AppRadius.radiusMd,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetricColumn(
                  label: 'المشاوير المشتركة',
                  value: '${state.completedRides} مشوار',
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                _buildMetricColumn(
                  label: 'الكيلومترات',
                  value: '${state.sharedKm} كم',
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                _buildMetricColumn(
                  label: 'نسبة احتفاظك',
                  value: '٩٠٪',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricColumn({required String label, required String value}) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withValues(alpha: 0.75),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildOutstandingCommissionCard(
    BuildContext context,
    FinanceUiState state,
    FinanceUiCubit cubit,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDefault,
        borderRadius: AppRadius.radiusLg,
        border: Border.all(
          color: state.isSuspended ? AppColors.error : AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet_rounded,
                    color: state.isSuspended
                        ? AppColors.error
                        : AppColors.brandIndigo,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'العمولة المستحقة لسِكّة (١٠٪)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Text(
                '${state.outstandingCommission.toStringAsFixed(0)} ج.م',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: state.isSuspended
                      ? AppColors.error
                      : AppColors.brandIndigoDeep,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            state.outstandingCommission > 0
                ? 'مستحقات الرحلات النقدية المطلوب تحويلها للمنصة. الحد الأقصى المسموح: ${state.maxAllowedDebtThreshold.toStringAsFixed(0)} ج.م.'
                : 'رصيد عمولتك مسدد بالكامل! شكراً لالتزامك.',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          if (state.outstandingCommission > 0) ...[
            const SizedBox(height: AppSpacing.s12),
            CustomButton(
              text:
                  'تسوية العمولة (${state.outstandingCommission.toStringAsFixed(0)} ج.م)',
              height: 44,
              isLoading: state.isSettling,
              onPressed: cubit.settleCommission,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRecentTransactionsHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'سجل الرحلات الأخيرة والعمولة',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        InkWell(
          onTap: () => context.push('/earnings-details'),
          child: const Text(
            'عرض التفاصيل',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.brandIndigo,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(
    BuildContext context,
    FinanceTripLedgerItem trip,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.s10),
      padding: const EdgeInsets.all(AppSpacing.s12),
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
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.surfaceMuted,
                  borderRadius: AppRadius.radiusSm,
                ),
                child: const Icon(
                  Icons.directions_car_rounded,
                  color: AppColors.brandIndigo,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.s10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip.routeTitle,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    trip.dateText,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '+${trip.grossFare.toStringAsFixed(0)} ج.م',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.success,
                ),
              ),
              Text(
                'عمولة: -${trip.commissionDeducted.toStringAsFixed(0)} ج.م',
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
