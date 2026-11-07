import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../logic/booking_confirmation_cubit.dart';
import '../logic/booking_confirmation_state.dart';

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingConfirmationCubit(),
      child: const _BookingConfirmationView(),
    );
  }
}

class _BookingConfirmationView extends StatelessWidget {
  const _BookingConfirmationView();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: BlocBuilder<BookingConfirmationCubit, BookingConfirmationState>(
            builder: (context, state) {
              final cubit = context.read<BookingConfirmationCubit>();

              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildTopTabs(context, state, cubit),
                        const SizedBox(height: 18),
                        if (state.selectedTab == 2) ...[
                          _buildCancellationHeaderCard(),
                          const SizedBox(height: 16),
                          _buildBookingDetailsCard(),
                          const SizedBox(height: 16),
                          _buildPolicyCard(state),
                          const SizedBox(height: 20),
                          _buildActionButtons(context, cubit),
                        ] else if (state.selectedTab == 1) ...[
                          _buildTimeoutCard(context, cubit),
                        ] else ...[
                          _buildNotesCard(context, cubit),
                        ],
                        const SizedBox(height: 20),
                        _buildFooterBranding(),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTopTabs(
    BuildContext context,
    BookingConfirmationState state,
    BookingConfirmationCubit cubit,
  ) {
    final tabs = [
      {'title': 'ملاحظات الرحلة', 'index': 0},
      {'title': 'انتهاء مهلة الطلب', 'index': 1},
      {'title': 'تأكيد الإلغاء', 'index': 2},
    ];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2F6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: tabs.reversed.map((tab) {
          final isSelected = state.selectedTab == tab['index'];
          return Expanded(
            child: InkWell(
              onTap: () => cubit.changeTab(tab['index'] as int),
              borderRadius: BorderRadius.circular(10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  tab['title'] as String,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF64748B),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCancellationHeaderCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: const BoxDecoration(
              color: Color(0xFFFFE4E6),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.highlight_off_rounded,
              color: Color(0xFFE11D48),
              size: 34,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'عايز تلغى الرحلة؟',
            style: GoogleFonts.cairo(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'تقدر تحتفظ بمقعدك وتكمل مشوارك براحة وبأمان مع كابتن رحلتك.',
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: 13,
              color: const Color(0xFF64748B),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'تفاصيل الحجز الحالي',
                style: GoogleFonts.cairo(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF64748B),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 13,
                      color: Color(0xFF4338CA),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'اليوم، ٠٨:٣٠ ص',
                      style: GoogleFonts.cairo(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF4338CA),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFF1F5F9)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 4),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3B82F6),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 2,
                      height: 34,
                      color: const Color(0xFFCBD5E1),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0F172A),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'نقطة الركوب',
                        style: GoogleFonts.cairo(
                          fontSize: 11,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      Text(
                        'المعادي (محطة مترو ثكنات المعادي)',
                        style: GoogleFonts.cairo(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'الوصول',
                        style: GoogleFonts.cairo(
                          fontSize: 11,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      Text(
                        'التجمع الخامس (شارع التسعين الشمالى)',
                        style: GoogleFonts.cairo(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFFE0E7FF),
                child: Text(
                  'أ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4338CA),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'كابتن أحمد محمود',
                          style: GoogleFonts.cairo(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.verified,
                          size: 15,
                          color: Color(0xFF16A34A),
                        ),
                      ],
                    ),
                    Text(
                      'نيسان صني • رمادي ميتالك',
                      style: GoogleFonts.cairo(
                        fontSize: 11,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: Color(0xFFF59E0B),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '4.9',
                      style: GoogleFonts.cairo(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyCard(BookingConfirmationState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3FF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEDE9FE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.info_outline_rounded,
                size: 20,
                color: Color(0xFF4338CA),
              ),
              const SizedBox(width: 8),
              Text(
                'قاعدة الإلغاء ونقاط التقييم في سِكّة',
                style: GoogleFonts.cairo(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: GoogleFonts.cairo(
                fontSize: 12,
                color: const Color(0xFF475569),
                height: 1.5,
              ),
              children: [
                const TextSpan(text: 'بعد أول '),
                TextSpan(
                  text: '٥ رحلات ملغية',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const TextSpan(text: ' كل رحلتين إضافيتين بتخصم '),
                TextSpan(
                  text: '٠.١',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFE11D48),
                  ),
                ),
                const TextSpan(text: ' من تقييمك العام في التطبيق.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'سجل الإلغاءات المستهلكة',
                      style: GoogleFonts.cairo(
                        fontSize: 11,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    Text(
                      '${state.usedCancellations} من ${state.maxFreeCancellations} رحلات مجانية',
                      style: GoogleFonts.cairo(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: state.usedCancellations / state.maxFreeCancellations,
                    backgroundColor: const Color(0xFFE2E8F0),
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF4338CA)),
                    minHeight: 7,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline_rounded,
                          size: 15,
                          color: Color(0xFF16A34A),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'الإلغاء الحالي مش هيأثر على حسابك',
                          style: GoogleFonts.cairo(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF16A34A),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'تقييمك الحالي: ٤.٩ ★',
                      style: GoogleFonts.cairo(
                        fontSize: 11,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.shield_outlined,
                size: 16,
                color: Color(0xFF64748B),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'بدون أي غرامات أو رسوم مالية مفاجئة. نظام سِكّة مبني على الثقة المتبادلة.',
                  style: GoogleFonts.cairo(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    BookingConfirmationCubit cubit,
  ) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () => cubit.keepTrip(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4338CA),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.directions_car_filled_outlined,
                  size: 19,
                ),
                const SizedBox(width: 8),
                Text(
                  'الاحتفاظ بالرحلة ومتابعة المشوار',
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () => cubit.confirmCancellation(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFE4E6),
              foregroundColor: const Color(0xFFDC2626),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.close_rounded,
                  size: 19,
                ),
                const SizedBox(width: 8),
                Text(
                  'تأكيد إلغاء الرحلة',
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeoutCard(
    BuildContext context,
    BookingConfirmationCubit cubit,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: const BoxDecoration(
              color: Color(0xFFFEF3C7),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.timer_off_outlined,
              color: Color(0xFFD97706),
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'انتهت مهلة انتظار الكابتن',
            style: GoogleFonts.cairo(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'لم يتم الرد على طلبك خلال المهلة المحددة. يمكنك إعادة المحاولة أو البحث عن رحلة بديلة.',
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: 12,
              color: const Color(0xFF64748B),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () => cubit.retryBooking(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4338CA),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'إعادة إرسال الطلب',
                style: GoogleFonts.cairo(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesCard(
    BuildContext context,
    BookingConfirmationCubit cubit,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.sticky_note_2_outlined,
                color: Color(0xFF4338CA),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'ملاحظات وتعليمات المشوار المشترك',
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _noteItem('التواجد في نقطة الركوب قبل الموعد بـ ٥ دقائق لضمان انطلاق الرحلة في وقتها.'),
          const SizedBox(height: 10),
          _noteItem('الالتزام بالمقعد المحدد وعدم اصطحاب حقائب كبيرة تعيق باقي الركاب.'),
          const SizedBox(height: 10),
          _noteItem('الدفع يتم بالوسيلة المحددة مسبقاً (كاش أو محفظة سِكّة الإلكترونية).'),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () => cubit.contactSupport(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFE2E8F0)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'تواصل مع الدعم الفني',
                style: GoogleFonts.cairo(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4338CA),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _noteItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 6),
          child: Icon(
            Icons.circle,
            size: 6,
            color: Color(0xFF4338CA),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.cairo(
              fontSize: 12,
              color: const Color(0xFF475569),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterBranding() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFFE0E7FF),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'SIKKA',
            style: GoogleFonts.inter(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF4338CA),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '• نفس السِكّة، نروح سوا • رحلات يومية آمنة في القاهرة والجيزة',
          style: GoogleFonts.cairo(
            fontSize: 11,
            color: const Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }
}
