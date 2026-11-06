import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sikka/features/rides/presentation/driver_map_card.dart';
import '../logic/rides_cubit.dart';
import 'package:sikka/features/rides/presentation/passengers_section.dart';

class ActiveRideScreen extends StatelessWidget {
  final String tripId;
  final LatLng passengerPos;
  const ActiveRideScreen({
    super.key,
    this.tripId = 'TRIP-9042',
    this.passengerPos = const LatLng(30.0055, 31.4280),
  });

  @override
  Widget build(BuildContext context) {
    try {
      context.read<TrackDriverCubit>();
      return _buildContent(context);
    } catch (_) {
      return BlocProvider(
        create: (_) => TrackDriverCubit(),
        child: Builder(
          builder: (ctx) => _buildContent(ctx),
        ),
      );
    }
  }

  Widget _buildContent(BuildContext context) {
    final cubit = context.read<TrackDriverCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF3525CD),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => cubit.clickBack(context),
                      icon: SvgPicture.asset(
                        'assets/icons/Container.svg',
                        width: 12,
                        height: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Active ride Tracking',
                    style: GoogleFonts.sora(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'سِكّة',
                        style: GoogleFonts.sourceSerif4(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF3525CD),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'SIKKA',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF6B7280),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => cubit.clickHelp(context),
                    icon: SvgPicture.asset('assets/icons/Icon.svg'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'رقم الرحلة :',
                    style: GoogleFonts.sourceSerif4(
                      color: const Color(0xFF6B7280),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2DFFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF3525CD),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'مباشر الآن',
                          style: GoogleFonts.sourceSerif4(
                            color: const Color(0xFF0F0069),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1E8FD),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/mark.svg',
                            width: 13,
                            height: 13,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'مستنيين الركوب',
                            style: GoogleFonts.sourceSerif4(
                              color: const Color(0xFF6B7280),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: SvgPicture.asset(
                        'assets/icons/backarrowIcon.svg',
                        width: 10,
                        height: 10,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3525CD),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/start icon.svg',
                            width: 11,
                            height: 14,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'بدأت الرحله',
                            style: GoogleFonts.sourceSerif4(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: SvgPicture.asset(
                        'assets/icons/backarrowIcon.svg',
                        width: 10,
                        height: 10,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1E8FD),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/near.svg',
                            width: 13,
                            height: 13,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'قربنا نوصل',
                            style: GoogleFonts.sourceSerif4(
                              color: const Color(0xFF6B7280),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F3FF),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4F46E5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/car.svg',
                            width: 15,
                            height: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'في الطريق للتجمع الخامس',
                              style: GoogleFonts.sourceSerif4(
                                color: const Color(0xFF141B2B),
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'الوصول المتوقع: ٨:٤٥ صباحاً (خلال ٢٢ دقيقة)',
                              style: GoogleFonts.sourceSerif4(
                                color: const Color(0xFF6B7280),
                                fontSize: 11.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'سِكّة سالكة',
                          style: GoogleFonts.sourceSerif4(
                            color: const Color(0xFF3525CD),
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDE68A),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/coutin.svg',
                                width: 15,
                                height: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'تنبيه انحراف مسار مسموح به',
                                  style: GoogleFonts.sourceSerif4(
                                    color: const Color(0xFF451A03),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  'إشعار أوتوماتيكي لك وللركاب',
                                  style: GoogleFonts.sourceSerif4(
                                    color: const Color(0xFF92400E),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDE68A),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '١.٤ كم+',
                              style: GoogleFonts.sourceSerif4(
                                color: const Color(0xFF78350F),
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'تحذير المسار للكابتن: النقطة دي هتزود انحراف ١.٤ كم عن سِكّتك الأساسية (مسموح به ومبلّغ به الركاب لحساب الأجرة بدقة)',
                        style: GoogleFonts.sourceSerif4(
                          color: const Color(0xFF78350F),
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'الممر المعتمد: المعادي ٩ ← الدائري ←',
                                      style: GoogleFonts.sourceSerif4(
                                        color: const Color(0xFF6B7280),
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'التجمع',
                                      style: GoogleFonts.sourceSerif4(
                                        color: const Color(0xFF6B7280),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'تأخير تقريبى ٤',
                                      style: GoogleFonts.sourceSerif4(
                                        color: const Color(0xFF3525CD),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'دقائق',
                                      style: GoogleFonts.sourceSerif4(
                                        color: const Color(0xFF3525CD),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 90,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TimelineTile(
                                      axis: TimelineAxis.horizontal,
                                      alignment: TimelineAlign.start,
                                      isLast: true,
                                      indicatorStyle: IndicatorStyle(
                                        width: 28,
                                        height: 28,
                                        padding: EdgeInsets.zero,
                                        indicator: Container(
                                          width: 24,
                                          height: 24,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF3525CD),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Container(
                                              width: 7,
                                              height: 7,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      beforeLineStyle: const LineStyle(
                                        color: Color(0xFFF59E0B),
                                        thickness: 4,
                                      ),
                                      endChild: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                        ),
                                        child: Text(
                                          'المعادي',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.sourceSerif4(
                                            fontSize: 13,
                                            color: const Color(0xFF1F2937),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TimelineTile(
                                      axis: TimelineAxis.horizontal,
                                      alignment: TimelineAlign.start,
                                      indicatorStyle: IndicatorStyle(
                                        width: 28,
                                        height: 28,
                                        padding: EdgeInsets.zero,
                                        indicator: Container(
                                          width: 26,
                                          height: 26,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFF59E0B),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.location_on_outlined,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      beforeLineStyle: const LineStyle(
                                        color: Color(0xFFF59E0B),
                                        thickness: 4,
                                      ),
                                      afterLineStyle: const LineStyle(
                                        color: Color(0xFFF59E0B),
                                        thickness: 4,
                                      ),
                                      endChild: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'نقطة المقابلة',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.sourceSerif4(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xFFF59E0B),
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              '+1.4km',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.sourceSerif4(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xFFF59E0B),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TimelineTile(
                                      axis: TimelineAxis.horizontal,
                                      alignment: TimelineAlign.start,
                                      isFirst: false,
                                      indicatorStyle: IndicatorStyle(
                                        width: 28,
                                        height: 28,
                                        padding: EdgeInsets.zero,
                                        indicator: Container(
                                          width: 24,
                                          height: 24,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF111827),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Container(
                                              width: 7,
                                              height: 7,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      beforeLineStyle: const LineStyle(
                                        color: Color(0xFFDDE3F8),
                                        thickness: 4,
                                      ),
                                      afterLineStyle: const LineStyle(
                                        color: Color(0xFFF59E0B),
                                        thickness: 4,
                                      ),
                                      endChild: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                        ),
                                        child: Text(
                                          'التجمع الخامس',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.sourceSerif4(
                                            fontSize: 13,
                                            color: const Color(0xFF1F2937),
                                          ),
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<TrackDriverCubit, TrackDriverState>(
                builder: (context, state) {
                  return DriverMapCard(
                    passengerPos: passengerPos,
                    driverPos: state.driverPos,
                    distanceText: state.driverPos != null?  state.distanceText
                        : null,
                  );
                },
              ),
              const SizedBox(height: 14),
              BlocBuilder<TrackDriverCubit, TrackDriverState>(
                builder: (context, state) {
                  return ElevatedButton.icon(
                    onPressed: state.activePassengers.isEmpty
                        ? null
                        : () => context
                              .read<TrackDriverCubit>()
                              .confirmAllOnboard(context),
                    icon: SvgPicture.asset('assets/icons/confirm.svg'),
                    label: Text(
                      'تأكيد ركوب الجميع وبدء التحرك',
                      style: GoogleFonts.sourceSerif4(
                        color: const Color(0xFFFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3525CD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
                PassengersSection(tripId: tripId),
              const SizedBox(height: 20),
                Directionality(textDirection: TextDirection.rtl, child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset('assets/icons/wallet.svg'),
                      Text('الدفع والأمان في السِكّة', style: GoogleFonts.sourceSerif4(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),),
                    ],
                  ),)
            ],
          ),
        ),
      ),
    );
  }
}
