import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidebarx/sidebarx.dart';
import '../logic/dashboard_cubit.dart';
import '../logic/dashboard_state.dart';

class RidesScreen extends StatelessWidget {
  const RidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(initialNavIndex: 4),
      child: const _RidesScreenView(),
    );
  }
}

class _RidesScreenView extends StatefulWidget {
  const _RidesScreenView();

  @override
  State<_RidesScreenView> createState() => _RidesScreenViewState();
}

class _RidesScreenViewState extends State<_RidesScreenView> {
  late final SidebarXController sidebarController;

  @override
  void initState() {
    super.initState();
    sidebarController = SidebarXController(
      selectedIndex: 4,
      extended: true,
    );
  }

  @override
  void dispose() {
    sidebarController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> menuItems = [
    {'icon': SvgPicture.asset('assets/icons/dashboard.svg'), 'label': 'Dashboard'},
    {'icon': SvgPicture.asset('assets/icons/users.svg'), 'label': 'Users'},
    {'icon': SvgPicture.asset('assets/icons/captains.svg'), 'label': 'Captains'},
    {'icon': SvgPicture.asset('assets/icons/verification.svg'), 'label': 'Verification'},
    {'icon': SvgPicture.asset('assets/icons/rides.svg'), 'label': 'Rides'},
    {'icon': SvgPicture.asset('assets/icons/finance.svg'), 'label': 'Finance'},
    {'icon': SvgPicture.asset('assets/icons/reports.svg'), 'label': 'Reports'},
    {'icon': SvgPicture.asset('assets/icons/settings.svg'), 'label': 'Settings'},
  ];

  final List<Map<String, dynamic>> tabs = [
    {'title': 'نشطة الآن (Active)', 'count': '342', 'icon': Icons.radio_button_checked},
    {'title': 'رحلات قادمة (Upcoming)', 'count': '84', 'icon': Icons.access_time},
    {'title': 'اكتملت المقاعد (Fully Booked)', 'count': '215', 'icon': Icons.airline_seat_recline_extra},
    {'title': 'مكتملة اليوم (Completed)', 'count': '1,290', 'icon': Icons.check_circle_outline},
  ];

  final List<Map<String, dynamic>> rideCorridors = [
    {
      'id': '#SK-8241',
      'tag': 'Ring Road Hub',
      'tagBg': Color(0xFFF1F5F9),
      'tagFg': Color(0xFF475569),
      'from': 'تجمع الخامس (شارع التسعين)',
      'to': 'نزهة المعادي',
      'rating': '4.9',
      'car': 'نيسان صني فضي • (ل ن ب ٩٢١)',
      'passengersBooked': 3,
      'passengersTotal': 4,
      'passengersText': '3 / 4 مقاعد محجوزة',
      'time': 'اليوم 08:30 ص',
      'timeSub': 'في الموعد (On Schedule)',
      'timeSubColor': Color(0xFF16A34A),
      'pricePerSeat': '50 ج.م',
      'totalFare': '150 ج.م',
      'deviationKm': '+0.0',
      'isDeviation': false,
      'paymentType': 'كاش مسجل بالسيستم',
      'isCash': true,
      'status': 'نشطة',
      'statusColor': Color(0xFF16A34A),
    },
    {
      'id': '#SK-8242',
      'tag': 'High Demand',
      'tagBg': Color(0xFFFEF3C7),
      'tagFg': Color(0xFFD97706),
      'from': 'ميدان لبنان المهندسين',
      'to': 'هايبر وان زايد',
      'rating': '4.96',
      'car': 'كيا سيراتو أبيض • (ق ر ب ٥١٤)',
      'passengersBooked': 4,
      'passengersTotal': 4,
      'passengersText': 'اكتملت المقاعد (4/4)',
      'time': 'اليوم 08:45 ص',
      'timeSub': 'تحركت قبل ١٢ دقيقة',
      'timeSubColor': Color(0xFF64748B),
      'pricePerSeat': '45 ج.م',
      'totalFare': '180 ج.م',
      'deviationKm': '+1.4 km',
      'isDeviation': true,
      'paymentType': 'محفظة سِكّة (SIKKA Pay)',
      'isCash': false,
      'status': 'نشطة',
      'statusColor': Color(0xFF16A34A),
    },
    {
      'id': '#SK-8243',
      'tag': 'Tech Corridor',
      'tagBg': Color(0xFFEEF2FF),
      'tagFg': Color(0xFF4338CA),
      'from': 'القرية الذكية (البوابة 1)',
      'to': 'حصرى 6 أكتوبر',
      'rating': '4.88',
      'car': 'هيونداي إلنترا كحلي • (س ج د ٨٤٢)',
      'passengersBooked': 2,
      'passengersTotal': 4,
      'passengersText': '2 / 4 مقاعد محجوزة',
      'time': 'اليوم 09:15 ص',
      'timeSub': 'تبدأ خلال 30 دقيقة',
      'timeSubColor': Color(0xFF4338CA),
      'pricePerSeat': '35 ج.م',
      'totalFare': '70 ج.م',
      'deviationKm': '+0.0',
      'isDeviation': false,
      'paymentType': 'محفظة سِكّة (SIKKA Pay)',
      'isCash': false,
      'status': 'مجدولة',
      'statusColor': Color(0xFF4338CA),
    },
    {
      'id': '#SK-8244',
      'tag': 'كاملة',
      'tagBg': Color(0xFFFEF3C7),
      'tagFg': Color(0xFFD97706),
      'from': 'الجامعة الأمريكية AUC',
      'to': 'تي ستارت مدينة نصر',
      'rating': '5.0',
      'car': 'تويوتا كورولا أسود • (ع م س ١١٦٧)',
      'passengersBooked': 3,
      'passengersTotal': 3,
      'passengersText': '3 / 3 مقاعد مكتملة',
      'time': 'اليوم 08:15 ص',
      'timeSub': 'تقترب من الوجهة (ETA 10m)',
      'timeSubColor': Color(0xFF16A34A),
      'pricePerSeat': '60 ج.م',
      'totalFare': '180 ج.م',
      'deviationKm': '+0.0',
      'isDeviation': false,
      'paymentType': 'كاش مسجل (3 ركاب)',
      'isCash': true,
      'status': 'مكتملة العدد',
      'statusColor': Color(0xFFD97706),
    },
    {
      'id': '#SK-8245',
      'tag': 'East Cairo Line',
      'tagBg': Color(0xFFEEF2FF),
      'tagFg': Color(0xFF4338CA),
      'from': 'مدينة الشروق (مدخل 2)',
      'to': 'محطة عدلي منصور',
      'rating': '4.92',
      'car': 'رينو ميجان فضي • (د ب و ٧٣٩)',
      'passengersBooked': 1,
      'passengersTotal': 4,
      'passengersText': '1 / 4 مقاعد محجوزة',
      'time': 'اليوم 09:30 ص',
      'timeSub': 'مجدولة لاحقاً',
      'timeSubColor': Color(0xFF64748B),
      'pricePerSeat': '40 ج.م',
      'totalFare': '40 ج.م',
      'deviationKm': '+0.0',
      'isDeviation': false,
      'paymentType': 'محفظة سِكّة (SIKKA Pay)',
      'isCash': false,
      'status': 'مجدولة',
      'statusColor': Color(0xFF4338CA),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final cubit = context.read<DashboardCubit>();

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          body: LayoutBuilder(
            builder: (context, constraints) {
              final layout = Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  sidebar(context, cubit),
                  Expanded(
                    child: Column(
                      children: [
                        topBar(context, state, cubit),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(28),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                pageHeader(context),
                                const SizedBox(height: 20),
                                filterTabsRow(context, state, cubit),
                                const SizedBox(height: 16),
                                searchAndFiltersBar(context, state, cubit),
                                const SizedBox(height: 16),
                                streamSubheader(),
                                const SizedBox(height: 12),
                                carpoolStreamTable(context, state, cubit),
                                const SizedBox(height: 16),
                                paginationFooter(context, state, cubit),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );

              if (constraints.maxWidth >= 1280) return layout;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 1280,
                  height: constraints.maxHeight,
                  child: layout,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget card({
    required Widget child,
    EdgeInsets padding = const EdgeInsets.all(20),
    Color color = Colors.white,
  }) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: child,
    );
  }

  Widget pill(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }

  Widget sidebar(BuildContext context, DashboardCubit cubit) {
    return SidebarX(
      controller: sidebarController,
      showToggleButton: false,
      theme: SidebarXTheme(
        decoration: const BoxDecoration(color: Colors.white),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
        selectedTextStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
        hoverTextStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
        hoverColor: const Color(0xFFF8FAFC),
        itemTextPadding: const EdgeInsets.only(left: 12),
        selectedItemTextPadding: const EdgeInsets.only(left: 12),
        itemDecoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        selectedItemDecoration: BoxDecoration(
          color: const Color(0xFF4338CA),
          borderRadius: BorderRadius.circular(10),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF64748B), size: 20),
        selectedIconTheme: const IconThemeData(color: Colors.white, size: 20),
      ),
      extendedTheme: const SidebarXTheme(
        width: 256,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white),
      ),
      headerBuilder: (context, extended) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4338CA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.directions_car_outlined, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SIKKA', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                    Text('Operations Portal', style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B))),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Operational Fleet', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A))),
                  Row(
                    children: [
                      const Icon(Icons.circle, size: 8, color: Color(0xFF16A34A)),
                      const SizedBox(width: 4),
                      Text('Live System', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF16A34A))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
      footerBuilder: (context, extended) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFF4338CA),
                child: Icon(Icons.person_outline, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tamer Mostafa', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                    Text('مدير تشغيل (Ops Admin)', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B))),
                  ],
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Color(0xFF64748B)),
            ],
          ),
        );
      },
      items: [
        for (int i = 0; i < menuItems.length; i++)
          SidebarXItem(
            icon: menuItems[i]['icon'] is IconData ? menuItems[i]['icon'] as IconData : null,
            iconBuilder: menuItems[i]['icon'] is Widget ? (context, isSelected) => menuItems[i]['icon'] as Widget : null,
            label: menuItems[i]['label'] as String?,
            onTap: () => cubit.changeNavIndex(context, i),
          ),
      ],
    );
  }

  Widget topBar(BuildContext context, DashboardState state, DashboardCubit cubit) {
    return Container(
      height: 78,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              onChanged: (val) => cubit.updateSearch(val),
              decoration: InputDecoration(
                hintText: 'Search users, captains, ride IDs, or nat...',
                hintStyle: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF64748B)),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B)),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          pill('● Cairo-Giza Hub', const Color(0xFFE0E7FF), const Color(0xFF0F172A)),
          const SizedBox(width: 8),
          pill('New Cairo Express', const Color(0xFFF8FAFC), const Color(0xFF64748B)),
          const Spacer(),
          OutlinedButton.icon(
            onPressed: () => cubit.toggleLanguage(context),
            icon: const Icon(Icons.translate, size: 18),
            label: Text(state.isArabic ? 'English' : 'العربية'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF0F172A),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () => cubit.clickNotifications(context),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications_none, size: 28, color: Color(0xFF0F172A)),
                Positioned(
                  top: -6,
                  right: -6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Color(0xFFDC2626), shape: BoxShape.circle),
                    child: Text('5', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          const CircleAvatar(
            backgroundColor: Color(0xFF4338CA),
            child: Icon(Icons.person_outline, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Operations Control', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
              Text('Online', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF16A34A))),
            ],
          ),
        ],
      ),
    );
  }

  Widget pageHeader(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 1050;
        return Flex(
          direction: isCompact ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: isCompact ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.circle, size: 7, color: Color(0xFF16A34A)),
                      const SizedBox(width: 6),
                      Text(
                        'LIVE CORRIDORS MONITOR (Cairo-Giza Metropolitan Ring • Hub v4.2)',
                        style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF16A34A)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      'إدارة رحلات السِكّة المشتركة',
                      style: GoogleFonts.sourceSerif4(fontSize: 26, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'SIKKA Fleet Operations',
                      style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: const Color(0xFF64748B)),
                    ),
                  ],
                ),
              ],
            ),
            if (isCompact) const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 10,
              children: [
                _topHeaderStatCard(
                  icon: Icons.directions_bus_outlined,
                  iconBg: const Color(0xFFEEF2FF),
                  iconFg: const Color(0xFF4338CA),
                  title: 'Active Seats In-Transit',
                  value: '1,184',
                  valueSuffix: ' / 1,420',
                  sub: 'total',
                ),
                _topHeaderStatCard(
                  icon: Icons.warning_amber_rounded,
                  iconBg: const Color(0xFFFEF3C7),
                  iconFg: const Color(0xFFD97706),
                  title: 'Deviation Flags (>1km)',
                  value: '7 Trips',
                  valueSuffix: '',
                  sub: '',
                  valueColor: const Color(0xFFD97706),
                ),
                _topHeaderStatCard(
                  icon: Icons.eco_outlined,
                  iconBg: const Color(0xFFEDE9FE),
                  iconFg: const Color(0xFF6D28D9),
                  title: 'Shared CO2 Offset',
                  value: '4.2 Tons',
                  valueSuffix: '',
                  sub: 'today',
                  subColor: const Color(0xFF16A34A),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _topHeaderStatCard({
    required IconData icon,
    required Color iconBg,
    required Color iconFg,
    required String title,
    required String value,
    required String valueSuffix,
    required String sub,
    Color valueColor = const Color(0xFF0F172A),
    Color subColor = const Color(0xFF64748B),
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: iconFg, size: 20),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: GoogleFonts.inter(fontSize: 10, color: const Color(0xFF64748B))),
              const SizedBox(height: 2),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(value, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: valueColor)),
                  if (valueSuffix.isNotEmpty)
                    Text(valueSuffix, style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF16A34A), fontWeight: FontWeight.w600)),
                  if (sub.isNotEmpty) ...[
                    const SizedBox(width: 4),
                    Text(sub, style: GoogleFonts.inter(fontSize: 10, color: subColor, fontWeight: FontWeight.w500)),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget filterTabsRow(BuildContext context, DashboardState state, DashboardCubit cubit) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          for (int i = 0; i < tabs.length; i++) ...[
            InkWell(
              onTap: () => cubit.changeRideTab(i),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: state.ridesTab == i ? const Color(0xFF4338CA) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      tabs[i]['icon'] as IconData,
                      size: 14,
                      color: state.ridesTab == i ? Colors.white : const Color(0xFF64748B),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      tabs[i]['title'] as String,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: state.ridesTab == i ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: state.ridesTab == i ? Colors.white.withValues(alpha: 0.25) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tabs[i]['count'] as String,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: state.ridesTab == i ? Colors.white : const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (i < tabs.length - 1) const SizedBox(width: 8),
          ],
          const Spacer(),
          IconButton(
            onPressed: () => cubit.changeRideTab(0),
            icon: const Icon(Icons.cancel_outlined, size: 18, color: Color(0xFF94A3B8)),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget searchAndFiltersBar(BuildContext context, DashboardState state, DashboardCubit cubit) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              onChanged: (val) => cubit.updateCorridorSearch(val),
              decoration: InputDecoration(
                hintText: 'Search Corridor, Captain, Passenger, or #SK-XXX...',
                hintStyle: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF94A3B8)),
                prefixIcon: const Icon(Icons.search, size: 18, color: Color(0xFF94A3B8)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 11),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        _dropdownFilterButton(
          title: 'جميع المسارات (All Corridors)',
          onTap: () => cubit.filterByCorridor('All'),
        ),
        const SizedBox(width: 10),
        _dropdownFilterButton(
          title: 'طريقة الدفع (Payment)',
          onTap: () => cubit.filterByPayment('All'),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () => cubit.toggleDeviationFilter(),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: state.isDeviationFilterOnly ? const Color(0xFFFEF3C7) : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: state.isDeviationFilterOnly ? const Color(0xFFD97706) : const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                const Icon(Icons.alt_route, size: 16, color: Color(0xFFD97706)),
                const SizedBox(width: 6),
                Text(
                  'انحراف المسار (>1km)',
                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: const Color(0xFFFDE68A), borderRadius: BorderRadius.circular(10)),
                  child: Text('7', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF92400E))),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune, size: 18, color: Color(0xFF475569)),
          ),
        ),
      ],
    );
  }

  Widget _dropdownFilterButton({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Text(title, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF0F172A))),
            const SizedBox(width: 6),
            const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF64748B)),
          ],
        ),
      ),
    );
  }

  Widget streamSubheader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              'Active Carpool Corridors Stream',
              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(width: 6),
            Text(
              '(عرض 5 من إجمالي 342 رحلة متطابقة)',
              style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B)),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.circle, size: 7, color: Color(0xFF16A34A)),
            const SizedBox(width: 5),
            Text('Strict Fixed Waypoint Mode', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, color: const Color(0xFF64748B))),
            const SizedBox(width: 14),
            const Icon(Icons.circle, size: 7, color: Color(0xFF4338CA)),
            const SizedBox(width: 5),
            Text('Zero Detour Tolerated: Max 2.5km', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, color: const Color(0xFF64748B))),
          ],
        ),
      ],
    );
  }

  Widget carpoolStreamTable(BuildContext context, DashboardState state, DashboardCubit cubit) {
    return card(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text('Ride ID & Corridor', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text('Captain', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text('Passengers', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text('Departure', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text('Price / Seat', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text('Route Deviation', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text('Payment', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text('Status', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)))),
                Expanded(flex: 1, child: Text('Actions', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)))),
              ],
            ),
          ),
          for (int i = 0; i < rideCorridors.length; i++) ...[
            _corridorTableRow(context, rideCorridors[i], cubit),
            if (i < rideCorridors.length - 1) const Divider(height: 1, color: Color(0xFFF1F5F9)),
          ],
        ],
      ),
    );
  }

  Widget _corridorTableRow(BuildContext context, Map<String, dynamic> r, DashboardCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(r['id'] as String, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF4338CA))),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: r['tagBg'] as Color, borderRadius: BorderRadius.circular(4)),
                      child: Text(r['tag'] as String, style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: r['tagFg'] as Color)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.circle, size: 7, color: Color(0xFF4338CA)),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        '${r['from']}  ←  ${r['to']}',
                        style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF0F172A), fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(0xFFEEF2FF),
                      child: Icon(Icons.person, size: 16, color: Color(0xFF4338CA)),
                    ),
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(Icons.check_circle, size: 10, color: Color(0xFF16A34A)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, size: 11, color: Color(0xFFF59E0B)),
                          const SizedBox(width: 3),
                          Text(r['rating'] as String, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(r['car'] as String, style: GoogleFonts.inter(fontSize: 10, color: const Color(0xFF64748B)), overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int p = 0; p < (r['passengersBooked'] as int); p++)
                      Container(
                        margin: const EdgeInsets.only(right: 2),
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(color: Color(0xFF4338CA), shape: BoxShape.circle),
                        child: const Icon(Icons.person, size: 10, color: Colors.white),
                      ),
                    if ((r['passengersTotal'] as int) > (r['passengersBooked'] as int))
                      Container(
                        width: 18,
                        height: 16,
                        decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            '+${(r['passengersTotal'] as int) - (r['passengersBooked'] as int)}',
                            style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: const Color(0xFF475569)),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(r['passengersText'] as String, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: const Color(0xFF4338CA))),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r['time'] as String, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                const SizedBox(height: 2),
                Text(r['timeSub'] as String, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w500, color: r['timeSubColor'] as Color)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.event_seat, size: 13, color: Color(0xFF4338CA)),
                    const SizedBox(width: 4),
                    Text('${r['passengersBooked']} / ${r['passengersTotal']}', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                  ],
                ),
                const SizedBox(height: 2),
                Text('إجمالي: ${r['totalFare']}', style: GoogleFonts.inter(fontSize: 10, color: const Color(0xFF64748B))),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: (r['isDeviation'] as bool)
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.warning_amber_rounded, size: 13, color: Color(0xFFD97706)),
                        const SizedBox(width: 4),
                        Text(r['deviationKm'] as String, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFFD97706))),
                      ],
                    ),
                  )
                : Row(
                    children: [
                      Container(width: 6, height: 16, decoration: BoxDecoration(color: const Color(0xFF16A34A), borderRadius: BorderRadius.circular(2))),
                      const SizedBox(width: 3),
                      Container(width: 6, height: 16, decoration: BoxDecoration(color: const Color(0xFF16A34A), borderRadius: BorderRadius.circular(2))),
                      const SizedBox(width: 3),
                      Container(width: 6, height: 16, decoration: BoxDecoration(color: const Color(0xFF16A34A), borderRadius: BorderRadius.circular(2))),
                    ],
                  ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: (r['isCash'] as bool) ? const Color(0xFFF1F5F9) : const Color(0xFFEDE9FE),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                r['paymentType'] as String,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: (r['isCash'] as bool) ? const Color(0xFF475569) : const Color(0xFF6D28D9),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Icon(Icons.circle, size: 8, color: r['statusColor'] as Color),
                const SizedBox(width: 4),
                Text(
                  r['status'] as String,
                  style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: r['statusColor'] as Color),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () => cubit.clickRideDetails(context, r['id'] as String),
              icon: const Icon(Icons.more_vert, size: 18, color: Color(0xFF64748B)),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }

  Widget paginationFooter(BuildContext context, DashboardState state, DashboardCubit cubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'عرض الصفحة 1 من 35 (إجمالي 342 رحلة متزامنة مع خريطة القاهرة الكبرى)',
          style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B)),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
              onPressed: () => cubit.changeRidesPage(state.ridesCurrentPage > 1 ? state.ridesCurrentPage - 1 : 1),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF0F172A),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('السابق', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(width: 8),
            for (final p in [1, 2, 3]) ...[
              InkWell(
                onTap: () => cubit.changeRidesPage(p),
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: state.ridesCurrentPage == p ? const Color(0xFF4338CA) : Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: state.ridesCurrentPage == p ? const Color(0xFF4338CA) : const Color(0xFFE2E8F0)),
                  ),
                  child: Center(
                    child: Text(
                      '$p',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: state.ridesCurrentPage == p ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
            ],
            Text('...', style: GoogleFonts.inter(color: const Color(0xFF64748B))),
            const SizedBox(width: 6),
            InkWell(
              onTap: () => cubit.changeRidesPage(35),
              borderRadius: BorderRadius.circular(6),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: state.ridesCurrentPage == 35 ? const Color(0xFF4338CA) : Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Center(
                  child: Text('35', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => cubit.changeRidesPage(state.ridesCurrentPage < 35 ? state.ridesCurrentPage + 1 : 35),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4338CA),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('التالي', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }
}
