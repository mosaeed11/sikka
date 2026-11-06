import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../logic/rides_cubit.dart';

class PassengersSection extends StatelessWidget {
  final String tripId;

  const PassengersSection({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackDriverCubit, TrackDriverState>(
      builder: (context, state) {
        final cubit = context.read<TrackDriverCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 10),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.how_to_reg_outlined,
                          color: Color(0xFF3525CD),
                          size: 22,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'جاهزية الركاب للركوب',
                          style: GoogleFonts.sourceSerif4(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: const Color(0xFF141B2B),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2DFFF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${state.onboardCount} من ${state.passengers.length} في المحطة',
                            style: GoogleFonts.sourceSerif4(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF3525CD),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    if (state.passengers.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            'لا يوجد ركاب في هذه الرحلة',
                            style: GoogleFonts.sourceSerif4(
                              color: const Color(0xFF6B7280),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )
                    else
                      ...state.passengers.map(
                        (p) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _PassengerCard(
                            passenger: p,
                            onTap: () => cubit.togglePassengerStatus(p.id),
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: state.arrivedAtPickup
                            ? null
                            : () => cubit.confirmArrivedAtPickup(context),
                        icon: const Icon(
                          Icons.verified_user_outlined,
                          size: 20,
                        ),
                        label: Text(
                          state.arrivedAtPickup
                              ? 'تم تأكيد الوصول'
                              : 'أنا وصلت عند نقطة المقابلة',
                          style: GoogleFonts.sourceSerif4(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3525CD),
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: const Color(0xFFC7C4E8),
                          disabledForegroundColor: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'الكابتن قرب يوصل، مستنيك عند نقطة المقابلة المتفق عليها أمام مدخل المترو.',
                      style: GoogleFonts.sourceSerif4(
                        fontSize: 12,
                        color: const Color(0xFF6B7280),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (state.isFull) ...[
              const SizedBox(height: 16),
              _TripFullCard(
                bookedSeats: state.bookedSeats,
                totalSeats: state.totalSeats,
              ),
            ],
          ],
        );
      },
    );
  }
}

class _PassengerCard extends StatelessWidget {
  final RidePassenger passenger;
  final VoidCallback onTap;

  const _PassengerCard({required this.passenger, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isOnboard = passenger.status == PassengerStatus.onboard;
    final isDropped = passenger.status == PassengerStatus.droppedOff;

    final String subtitle;
    final Color subtitleColor;
    if (isOnboard) {
      subtitle = passenger.pickupLabel ?? '';
      subtitleColor = const Color(0xFF6B7280);
    } else if (isDropped) {
      subtitle = 'نزل في وجهته';
      subtitleColor = const Color(0xFF6B7280);
    } else {
      subtitle = 'وصلت نقطة المقابلة وتنتظر';
      subtitleColor = const Color(0xFFF59E0B);
    }

    final hasAvatar =
        passenger.avatarUrl != null && passenger.avatarUrl!.isNotEmpty;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F3FF),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xFFE2DFFF),
              backgroundImage:
                  hasAvatar ? NetworkImage(passenger.avatarUrl!) : null,
              child: hasAvatar
                  ? null
                  : Text(
                      passenger.name.isNotEmpty ? passenger.name[0] : '?',
                      style: GoogleFonts.sourceSerif4(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: const Color(0xFF3525CD),
                      ),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    passenger.name,
                    style: GoogleFonts.sourceSerif4(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: const Color(0xFF141B2B),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: GoogleFonts.sourceSerif4(
                      fontSize: 12,
                      color: subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _StatusBadge(status: passenger.status),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final PassengerStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    late final String label;
    late final IconData icon;
    late final Color color;
    late final Color background;

    switch (status) {
      case PassengerStatus.onboard:
        label = 'ركب بالفعل';
        icon = Icons.check_circle;
        color = const Color(0xFF16A34A);
        background = const Color(0xFFEAFBF0);
        break;
      case PassengerStatus.droppedOff:
        label = 'نزل';
        icon = Icons.flag;
        color = const Color(0xFF6B7280);
        background = const Color(0xFFF3F4F6);
        break;
      case PassengerStatus.waiting:
        label = 'مستنية الكابتن';
        icon = Icons.hourglass_bottom;
        color = const Color(0xFFF59E0B);
        background = const Color(0xFFFFF7DB);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.sourceSerif4(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(width: 5),
          Icon(icon, size: 16, color: color),
        ],
      ),
    );
  }
}

class _TripFullCard extends StatelessWidget {
  final int bookedSeats;
  final int totalSeats;

  const _TripFullCard({
    required this.bookedSeats,
    required this.totalSeats,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFE2E5FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFF1F2437),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.event_seat,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الرحلة دي كملت عددها بالكامل',
                    style: GoogleFonts.sourceSerif4(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: const Color(0xFF141B2B),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '$bookedSeats من $totalSeats مقاعد محجوزة • لا يمكن قبول ركاب إضافيين',
                    style: GoogleFonts.sourceSerif4(
                      fontSize: 12,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.lock_outline,
              color: Color(0xFF6B7280),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
