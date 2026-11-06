import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/route_spine_widget.dart';
import '../logic/payment_ui_cubit.dart';
import '../logic/payment_ui_state.dart';

/// Screen 04: Ride Receipt
/// Matching Figma Frame `21:3666` (Ticket Card `21:3687`, Breakdown `21:3757`, CTAs `21:3819`)
class RideReceiptScreen extends StatelessWidget {
  final PaymentUiState? initialData;

  const RideReceiptScreen({
    super.key,
    this.initialData,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentUiCubit(),
      child: _RideReceiptView(data: initialData ?? const PaymentUiState()),
    );
  }
}

class _RideReceiptView extends StatefulWidget {
  final PaymentUiState data;

  const _RideReceiptView({required this.data});

  @override
  State<_RideReceiptView> createState() => _RideReceiptViewState();
}

class _RideReceiptViewState extends State<_RideReceiptView> {
  int _selectedRating = 5;

  @override
  Widget build(BuildContext context) {
    final state = widget.data;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F5F9), // Slate 100 soft background
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'إيصال المشوار الرقمي',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s16,
              vertical: AppSpacing.s8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Celebration Ambient Banner (Figma Node 21:3669)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.s16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7), // Mint Green
                    borderRadius: AppRadius.radiusLg,
                    border: Border.all(
                      color: AppColors.success.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.s12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'تمت الرحلة بنجاح!',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF14532D),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'شكراً لاختيارك سِكّة ومشاركتك الطريق معنا.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF166534),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.s16),

                // Digital Receipt Card (Ticket Style, Node 21:3687)
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDefault,
                    borderRadius: AppRadius.radiusLg,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Brand & Meta Header (Node 21:3690)
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.s16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.brandIndigo,
                                        borderRadius: AppRadius.radiusSm,
                                      ),
                                      child: const Text(
                                        'سِكّة',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      state.receiptId,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'إيصال إلكتروني معتمد رسمياً',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                            // Date & Time Chip (Node 21:3707)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceMuted,
                                borderRadius: AppRadius.radiusMd,
                              ),
                              child: Text(
                                state.formattedDate,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.brandIndigoDeep,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Dotted Separator Line
                      _buildTicketDashedDivider(),

                      // Route Spine (Node 21:3712)
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.s16),
                        child: RouteSpineWidget(
                          originTitle: state.originTitle,
                          destinationTitle: state.destinationTitle,
                          isCompact: true,
                        ),
                      ),

                      // Captain Info Strip (Node 21:3731)
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s16,
                        ),
                        padding: const EdgeInsets.all(AppSpacing.s12),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceSoft,
                          borderRadius: AppRadius.radiusMd,
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.brandVioletSoft,
                              child: const Icon(
                                Icons.person_rounded,
                                color: AppColors.brandIndigo,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.s10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'الكابتن: ${state.captainName}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    state.captainVehicle,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceDefault,
                                borderRadius: AppRadius.radiusSm,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 13,
                                    color: AppColors.accentYellow,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    state.captainRating.toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s12),

                      // Dotted Separator Line
                      _buildTicketDashedDivider(),

                      // Financial Breakdown Section (Node 21:3757)
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.s16),
                        child: Column(
                          children: [
                            // Status Badge (Node 21:3758)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: AppColors.success.withValues(alpha: 0.1),
                                borderRadius: AppRadius.radiusFull,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    size: 14,
                                    color: AppColors.success,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    state.selectedMethod ==
                                            PaymentMethodType.cash
                                        ? 'تم السداد نقداً للكابتن بالكامل'
                                        : 'تم السداد إلكترونياً من المحفظة',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.success,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            _buildReceiptLine(
                              title: 'أجرة مشاركة المسار',
                              amount:
                                  '${state.baseFare.toStringAsFixed(0)} ج.م',
                            ),
                            const SizedBox(height: 6),
                            _buildReceiptLine(
                              title: 'رسوم خدمة وتأمين الرحلة',
                              amount:
                                  '${state.platformFee.toStringAsFixed(0)} ج.م',
                            ),
                            const Divider(height: 18, color: AppColors.border),
                            _buildReceiptLine(
                              title: 'المبلغ الإجمالي المدفوع',
                              amount:
                                  '${state.totalFare.toStringAsFixed(0)} ج.م',
                              isTotal: true,
                            ),
                          ],
                        ),
                      ),

                      // Barcode & Trip Token Visual Anchor (Node 21:3793)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s16,
                          vertical: AppSpacing.s12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceSoft,
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'رمز التوثيق الرقمي: SKK-2024-TRIP-99',
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: AppColors.textMuted,
                              ),
                            ),
                            const Icon(
                              Icons.qr_code_rounded,
                              size: 24,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.s20),

                // Rate Driver Rating Bar (Node 21:3820)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.s16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDefault,
                    borderRadius: AppRadius.radiusLg,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'كيف كانت تجربتك مع الكابتن؟',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final star = index + 1;
                          return IconButton(
                            icon: Icon(
                              star <= _selectedRating
                                  ? Icons.star_rounded
                                  : Icons.star_outline_rounded,
                              size: 32,
                              color: AppColors.accentYellow,
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedRating = star;
                              });
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.s16),

                // Action CTAs Stack (Figma Node 21:3819)
                CustomButton(
                  text: 'العودة للرئيسية',
                  height: 52,
                  onPressed: () => Navigator.of(context).maybePop(),
                ),

                const SizedBox(height: AppSpacing.s10),

                OutlinedButton.icon(
                  icon: const Icon(Icons.share_rounded, size: 18),
                  label: const Text('مشاركة أو تحميل الإيصال'),
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
                        content: Text('تم حفظ الإيصال على جهازك بنجاح!'),
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

  Widget _buildTicketDashedDivider() {
    return SizedBox(
      height: 16,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Dashed line
          Row(
            children: List.generate(
              30,
              (_) => Expanded(
                child: Container(
                  height: 1,
                  color: AppColors.border,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                ),
              ),
            ),
          ),
          // Left Notch Cutout
          Positioned(
            left: -8,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Right Notch Cutout
          Positioned(
            right: -8,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptLine({
    required String title,
    required String amount,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 14 : 12,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: isTotal ? 16 : 12,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? AppColors.brandIndigoDeep : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
