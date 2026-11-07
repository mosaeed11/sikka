import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidebarx/sidebarx.dart';
import '../logic/dashboard_cubit.dart';
import '../logic/dashboard_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(initialNavIndex: 0),
      child: const _DashboardScreenView(),
    );
  }
}

class _DashboardScreenView extends StatefulWidget {
  const _DashboardScreenView();

  @override
  State<_DashboardScreenView> createState() => _DashboardScreenViewState();
}

class _DashboardScreenViewState extends State<_DashboardScreenView> {
  late final SidebarXController sidebarController;

  @override
  void initState() {
    super.initState();
    sidebarController = SidebarXController(
      selectedIndex: 0,
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

  final List<Map<String, dynamic>> topCorridors = [
    {
      'num': '01',
      'title': 'المعادي ← التجمع الخامس',
      'sub': 'Ring Rd → New Cairo South 90th',
      'rides': '118 rides',
      'tag': '● 89% Capacity',
      'tagColor': Color(0xFF16A34A),
      'numBg': Color(0xFF4338CA),
      'numFg': Colors.white,
    },
    {
      'num': '02',
      'title': 'الهرم / أكتوبر ← القرية الذكية',
      'sub': 'Haram / 26th Oct → Smart Village',
      'rides': '94 rides',
      'tag': '● Normal Flow',
      'tagColor': Color(0xFF16A34A),
      'numBg': Color(0xFFF1F5F9),
      'numFg': Color(0xFF0F172A),
    },
    {
      'num': '03',
      'title': 'مصر الجديدة ← التجمع',
      'sub': 'Heliopolis Roxiy → AUC / Choueifat',
      'rides': '76 rides',
      'tag': '● +4m Delay',
      'tagColor': Color(0xFFD97706),
      'numBg': Color(0xFFF1F5F9),
      'numFg': Color(0xFF0F172A),
    },
    {
      'num': '04',
      'title': 'الشيخ زايد ← المهندسين',
      'sub': 'Sheikh Zayed Hyper One → Lebanon Sq',
      'rides': '54 rides',
      'tag': '● Fluid Corridor',
      'tagColor': Color(0xFF16A34A),
      'numBg': Color(0xFFF1F5F9),
      'numFg': Color(0xFF0F172A),
    },
  ];

  final List<Map<String, dynamic>> warningCaptains = [
    {
      'num': '1',
      'name': 'كريم عادل (Karim Adel)',
      'car': 'Nissan Sunny • Maadi Sector',
      'amount': '820 EGP',
      'badge': 'Over 3 days',
      'badgeBg': Color(0xFFFEE2E2),
      'badgeFg': Color(0xFFDC2626),
      'circleBg': Color(0xFFFEE2E2),
      'circleFg': Color(0xFFDC2626),
    },
    {
      'num': '2',
      'name': 'حسام الغزالي (Hossam El-Ghazaly)',
      'car': 'Hyundai Elantra • 6th October',
      'amount': '540 EGP',
      'badge': 'Suspended',
      'badgeBg': Color(0xFFFEF3C7),
      'badgeFg': Color(0xFFD97706),
      'circleBg': Color(0xFFFEE2E2),
      'circleFg': Color(0xFFDC2626),
    },
    {
      'num': '3',
      'name': 'شريف الباز (Sherif El-Baz)',
      'car': 'Kia Cerato • New Cairo',
      'amount': '485 EGP',
      'badge': 'Near limit',
      'badgeBg': Color(0xFFFEF3C7),
      'badgeFg': Color(0xFFD97706),
      'circleBg': Color(0xFFFEF3C7),
      'circleFg': Color(0xFFD97706),
    },
  ];

  final List<Map<String, dynamic>> liveRides = [
    {
      'id': '#RD-4921',
      'routeMain': 'Dokki, Mesaha → New Cairo Tagamoa',
      'routeSub': 'مسار الدائري ومحور المشير',
      'avatarInitials': 'YM',
      'captainName': 'Youssef Mansour',
      'carInfo': 'كيا سيراتو / س ط د ٧٨٩',
      'depTime': '08:15 AM',
      'eta': 'ETA 08:48 AM (On Track)',
      'etaColor': Color(0xFF16A34A),
      'seatsFilled': 3,
      'seatsTotal': 4,
      'fareTotal': '120 EGP Total',
      'fareSub': '40 EGP / seat (Cash)',
      'status': 'In Transit',
      'statusBg': Color(0xFFDCFCE7),
      'statusFg': Color(0xFF16A34A),
    },
    {
      'id': '#RD-4918',
      'routeMain': 'Hyper One, Zayed → Smart Village Hub',
      'routeSub': 'محور ٢٦ يوليو السريع',
      'avatarInitials': 'NA',
      'captainName': 'Nouran Allam',
      'carInfo': 'شيري تيجو / أ ب ج ١٢٣',
      'depTime': '08:30 AM',
      'eta': 'ETA 08:52 AM (On Track)',
      'etaColor': Color(0xFF16A34A),
      'seatsFilled': 4,
      'seatsTotal': 4,
      'fareTotal': '140 EGP Total',
      'fareSub': '35 EGP / seat (In-App)',
      'status': 'Full',
      'statusBg': Color(0xFFEDE9FE),
      'statusFg': Color(0xFF6D28D9),
    },
    {
      'id': '#RD-4912',
      'routeMain': 'Heliopolis, Marghany → Tagamoa 1',
      'routeSub': 'طريق السويس - تقاطع شيراتون',
      'avatarInitials': 'MK',
      'captainName': 'Mostafa Kamal',
      'carInfo': 'نيسان صني / م ن ه ٥٦٧',
      'depTime': '08:45 AM',
      'eta': 'Boarding at Pick Point',
      'etaColor': Color(0xFFD97706),
      'seatsFilled': 3,
      'seatsTotal': 4,
      'fareTotal': '90 EGP Total',
      'fareSub': '45 EGP / seat',
      'status': 'Waiting',
      'statusBg': Color(0xFFFEF3C7),
      'statusFg': Color(0xFFD97706),
    },
  ];

  final List<Map<String, dynamic>> activityLedger = [
    {
      'tag': 'Ride Completed',
      'tagBg': Color(0xFFDCFCE7),
      'tagFg': Color(0xFF16A34A),
      'time': '1 min ago',
      'title': 'Ring Road Segment (Maadi → New Cairo)',
      'desc': 'Capt. Tarek completed drop-off for 3 passengers. Route punctuality +2m.',
      'footerLeft': 'Trip Fare: 150 EGP',
      'footerRight': '+15 EGP SIKKA Fee',
      'footerRightColor': Color(0xFF16A34A),
    },
    {
      'tag': 'Cash Recorded',
      'tagBg': Color(0xFFEDE9FE),
      'tagFg': Color(0xFF6D28D9),
      'time': '3 mins ago',
      'title': 'Cash Payment: 50 EGP (Mohandessin)',
      'desc': 'Passenger Salma paid cash. 10% platform commission (5 EGP) debited to Capt. wallet.',
      'footerLeft': 'Capt Balance: 380 EGP',
      'footerRight': 'Logged',
      'footerRightColor': Color(0xFF6D28D9),
    },
    {
      'tag': 'Captain Approved',
      'tagBg': Color(0xFFFCE7F3),
      'tagFg': Color(0xFFBE185D),
      'time': '6 mins ago',
      'title': 'Captain Omar F. Clearance Granted',
      'desc': 'National ID & Faysh Sahifa registration verified. Onboarding SMS automatically sent.',
      'footerLeft': 'Reviewer: OpsAdmin #4',
      'footerRight': 'Active Fleet',
      'footerRightColor': Color(0xFF0F172A),
    },
    {
      'tag': 'New Route Published',
      'tagBg': Color(0xFFE0E7FF),
      'tagFg': Color(0xFF3730A3),
      'time': '9 mins ago',
      'title': 'Zayed Arkan → Smart Village Line',
      'desc': 'Capt. Dina published 3 empty seats for 09:15 AM schedule. 2 riders pre-booked.',
      'footerLeft': 'Match Score: 88%',
      'footerRight': '1 Seat Open',
      'footerRightColor': Color(0xFFD97706),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final cubit = context.read<DashboardCubit>();

        return Scaffold(
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
                                pageHeader(context, cubit),
                                const SizedBox(height: 24),
                                statsRow(context, cubit),
                                const SizedBox(height: 24),
                                middleSection(context, state, cubit),
                                const SizedBox(height: 24),
                                reviewAndWarningsSection(context, cubit),
                                const SizedBox(height: 28),
                                liveRideStreamTable(context, state, cubit),
                                const SizedBox(height: 28),
                                recentActivityLedger(context, cubit),
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
                    Text('المدير الشامل - Admin', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B))),
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

  Widget pageHeader(BuildContext context, DashboardCubit cubit) {
    return card(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 1250;
          return Flex(
            direction: isCompact ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: isCompact ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.hub_outlined, color: Color(0xFF4338CA), size: 26),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10,
                        runSpacing: 4,
                        children: [
                          Text(
                            'Operations Dispatch & Network Control',
                            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDCFCE7),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.circle, size: 7, color: Color(0xFF16A34A)),
                                const SizedBox(width: 4),
                                Text(
                                  'LIVE 4G / Cairo Grid',
                                  style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF16A34A)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'مركز المتابعة والتحكم اللحظي لحركة الرحلات والتوجيه | Cairo-Giza Operations Hub',
                        style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ],
              ),
              if (isCompact) const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Fleet Occupancy: ', style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B))),
                      Text('88.4%', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF4338CA))),
                      const SizedBox(width: 12),
                      Container(width: 1, height: 16, color: const Color(0xFFE2E8F0)),
                      const SizedBox(width: 12),
                      Text('Corridor Load: ', style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B))),
                      Text('Peak Rush Hour', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFFD97706))),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () => cubit.broadcastNotice(context),
                    icon: const Icon(Icons.campaign, size: 18),
                    label: Text(
                      'Broadcast Notice / إشعار جماعي',
                      style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4338CA),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget statCard({
    required String title,
    required Widget icon,
    required String value,
    required String badgeText,
    required Color badgeBg,
    required Color badgeFg,
    required List<Widget> bottomItems,
  }) {
    return card(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF64748B)),
                ),
              ),
              const SizedBox(width: 6),
              icon,
            ],
          ),
          const SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                ),
                if (badgeText.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: badgeBg, borderRadius: BorderRadius.circular(4)),
                    child: Text(badgeText, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: badgeFg)),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < bottomItems.length; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  bottomItems[i],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget statsRow(BuildContext context, DashboardCubit cubit) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double computedWidth;
        if (constraints.maxWidth >= 1200) {
          computedWidth = (constraints.maxWidth - (4 * 16)) / 5;
        } else if (constraints.maxWidth >= 720) {
          computedWidth = (constraints.maxWidth - (2 * 16)) / 3;
        } else {
          computedWidth = (constraints.maxWidth - 16) / 2;
        }

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            SizedBox(
              width: computedWidth,
              child: statCard(
                title: 'TOTAL RIDERS / إجمالي الركاب',
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: const Color(0xFFE0E7FF), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.people_outline, size: 16, color: Color(0xFF4338CA)),
                ),
                value: '14,820',
                badgeText: '▲ +12%',
                badgeBg: const Color(0xFFDCFCE7),
                badgeFg: const Color(0xFF16A34A),
                bottomItems: [
                  Text('Booked: 11,400', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B))),
                  Text('Captains: 3,420', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B))),
                ],
              ),
            ),
            SizedBox(
              width: computedWidth,
              child: statCard(
                title: 'FLEET CAPTAINS / الكباتن',
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: const Color(0xFFEDE9FE), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.directions_car_outlined, size: 16, color: Color(0xFF6D28D9)),
                ),
                value: '3,420',
                badgeText: '64% Live',
                badgeBg: const Color(0xFFDCFCE7),
                badgeFg: const Color(0xFF16A34A),
                bottomItems: [
                  Row(
                    children: [
                      const Icon(Icons.circle, size: 6, color: Color(0xFF16A34A)),
                      const SizedBox(width: 4),
                      Text('2,890 Active', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF16A34A))),
                    ],
                  ),
                  Text('410 Off', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B))),
                  Text('120 Susp.', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFFDC2626))),
                ],
              ),
            ),
            SizedBox(
              width: computedWidth,
              child: statCard(
                title: 'VERIFICATION / التوثيق',
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.verified_user_outlined, size: 16, color: Color(0xFFD97706)),
                ),
                value: '28 Drivers',
                badgeText: 'Action Needed',
                badgeBg: const Color(0xFFFEF3C7),
                badgeFg: const Color(0xFFD97706),
                bottomItems: [
                  Text('Avg Wait: 22 mins', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B))),
                  InkWell(
                    onTap: () => cubit.reviewAllVerifications(context),
                    child: Text('Review All →', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF4338CA))),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: computedWidth,
              child: statCard(
                title: 'ACTIVE RIDES / الرحلات الجارية',
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: const Color(0xFFE0E7FF), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.alt_route, size: 16, color: Color(0xFF4338CA)),
                ),
                value: '342 In Transit',
                badgeText: '',
                badgeBg: Colors.transparent,
                badgeFg: Colors.transparent,
                bottomItems: [
                  Text('Corridors: 14 Active', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B))),
                  Text('97.8% On-Time', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF16A34A))),
                ],
              ),
            ),
            SizedBox(
              width: computedWidth,
              child: statCard(
                title: 'COMMISSION / العمولات',
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.account_balance_wallet_outlined, size: 16, color: Color(0xFF16A34A)),
                ),
                value: '48,650 EGP',
                badgeText: '',
                badgeBg: Colors.transparent,
                badgeFg: Colors.transparent,
                bottomItems: [
                  Text('Weekly 10% Fee', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B))),
                  Text('34 Pending Cash', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFFDC2626))),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget middleSection(BuildContext context, DashboardState state, DashboardCubit cubit) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 1050;
        if (isCompact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              realTimeGridMapCard(context, state, cubit),
              const SizedBox(height: 24),
              topCorridorsCard(context),
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: realTimeGridMapCard(context, state, cubit),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 4,
              child: topCorridorsCard(context),
            ),
          ],
        );
      },
    );
  }

  Widget realTimeGridMapCard(BuildContext context, DashboardState state, DashboardCubit cubit) {
    return card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.navigation_outlined, size: 16, color: Color(0xFF4338CA)),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cairo & Giza Corridor Real-Time Grid', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                      Text('مراقبة محاور الحركة الرئيسية والازدحام وتدفق الركاب', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B))),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => cubit.toggleHeatmap(),
                    icon: Icon(Icons.layers_outlined, size: 14, color: state.isHeatmapEnabled ? const Color(0xFF4338CA) : const Color(0xFF64748B)),
                    label: Text(
                      'Heatmap',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: state.isHeatmapEnabled ? const Color(0xFF4338CA) : const Color(0xFF0F172A),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      side: BorderSide(color: state.isHeatmapEnabled ? const Color(0xFF4338CA) : const Color(0xFFE2E8F0)),
                      backgroundColor: state.isHeatmapEnabled ? const Color(0xFFEEF2FF) : Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () => cubit.refreshGrid(context),
                    icon: const Icon(Icons.refresh, size: 14),
                    label: Text('Refresh (5s)', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4338CA),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 240,
              width: double.infinity,
              color: const Color(0xFFF1F5F9),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _CairoMapGridPainter(isHeatmap: state.isHeatmapEnabled),
                    ),
                  ),
                  Positioned(
                    top: 14,
                    left: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Peak Corridor Flow: ', style: GoogleFonts.inter(fontSize: 10, color: const Color(0xFF64748B))),
                              Text('142 km/h | Mod. Congestion', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFFD97706))),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text('كثافة متوسطة | سرعة الحركة مستقرة', style: GoogleFonts.inter(fontSize: 9, color: const Color(0xFF64748B))),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(Icons.warning_amber, size: 11, color: Color(0xFFDC2626)),
                              const SizedBox(width: 4),
                              Text('Heavy Traffic: Ring Rd / El-Mounib', style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.w600, color: const Color(0xFFDC2626))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.95),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.circle, size: 8, color: Color(0xFF4338CA)),
                            const SizedBox(width: 4),
                            Text('Origin Stop', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A))),
                            const SizedBox(width: 14),
                            const Icon(Icons.circle, size: 8, color: Color(0xFF0F172A)),
                            const SizedBox(width: 4),
                            Text('Destination Hub', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A))),
                            const SizedBox(width: 14),
                            const Icon(Icons.circle, size: 8, color: Color(0xFF16A34A)),
                            const SizedBox(width: 4),
                            Text('Live Vehicle', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A))),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _gridBottomMetric(
                  title: 'Average Fare',
                  value: '38.5 EGP',
                  sub: 'Per Passenger Seat',
                  valColor: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _gridBottomMetric(
                  title: 'Avg Match Radius',
                  value: '1.2 km',
                  sub: 'Walking waypoint',
                  valColor: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _gridBottomMetric(
                  title: 'Deviation Alerts',
                  value: '3 Rides',
                  sub: 'Off geo-fence (>500m)',
                  valColor: const Color(0xFFD97706),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _gridBottomMetric(
                  title: 'Network Punctuality',
                  value: '96.4%',
                  sub: 'Within ±5 mins ETA',
                  valColor: const Color(0xFF16A34A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _gridBottomMetric({
    required String title,
    required String value,
    required String sub,
    required Color valColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.inter(fontSize: 10, color: const Color(0xFF64748B))),
          const SizedBox(height: 2),
          Text(value, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: valColor)),
          const SizedBox(height: 1),
          Text(sub, style: GoogleFonts.inter(fontSize: 9, color: const Color(0xFF64748B))),
        ],
      ),
    );
  }

  Widget topCorridorsCard(BuildContext context) {
    return card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Top Arterial Corridors (المحاور النشطة)', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                  Text('Highest carpooling volume during morning peak', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B))),
                ],
              ),
              pill('4 Major Routes', const Color(0xFFEEF2FF), const Color(0xFF4338CA)),
            ],
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < topCorridors.length; i++) ...[
            _corridorRow(topCorridors[i]),
            if (i < topCorridors.length - 1) const SizedBox(height: 10),
          ],
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Grid Network Health Status:', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(6)),
                child: Text('OPTIMAL DISPATCHING', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF16A34A))),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _corridorRow(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: item['numBg'] as Color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                item['num'] as String,
                style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: item['numFg'] as Color),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['title'] as String, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                Text(item['sub'] as String, style: GoogleFonts.inter(fontSize: 10, color: const Color(0xFF64748B))),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(item['rides'] as String, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
              Text(item['tag'] as String, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: item['tagColor'] as Color)),
            ],
          ),
        ],
      ),
    );
  }

  Widget reviewAndWarningsSection(BuildContext context, DashboardCubit cubit) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 1050;
        if (isCompact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              urgentVerificationCard(context, cubit),
              const SizedBox(height: 24),
              commissionWarningsCard(context, cubit),
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: urgentVerificationCard(context, cubit),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 4,
              child: commissionWarningsCard(context, cubit),
            ),
          ],
        );
      },
    );
  }

  Widget urgentVerificationCard(BuildContext context, DashboardCubit cubit) {
    return card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.verified_user_outlined, size: 16, color: Color(0xFFD97706)),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Urgent Captain Verification Review', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                      Text('مراجعة فورية لملفات الكباتن وتراخيص المرور وفحص الأمان', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B))),
                    ],
                  ),
                ],
              ),
              pill('Queue: 28', const Color(0xFFFEF3C7), const Color(0xFFD97706)),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundColor: Color(0xFF4338CA),
                      child: Text('AS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Capt. Ahmed El-Shennawy', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                              const SizedBox(width: 6),
                              Text('كابتن أحمد الشناوي', style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B))),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text('Toyota Corolla 2022 • Plate: س ط د ٧٨٩ • Cairo Traffic Unit', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B))),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OutlinedButton(
                          onPressed: () => cubit.rejectCaptain(context, 'Ahmed El-Shennawy'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFFDC2626),
                            backgroundColor: const Color(0xFFFEE2E2),
                            side: const BorderSide(color: Color(0xFFFECACA)),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text('Reject', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () => cubit.approveCaptain(context, 'Ahmed El-Shennawy'),
                          icon: const Icon(Icons.check, size: 16),
                          label: Text('Approve Captain', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF16A34A),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _verificationCheckPill(Icons.badge_outlined, 'National ID (الرقم القومي)', '29104090106312')),
                    const SizedBox(width: 8),
                    Expanded(child: _verificationCheckPill(Icons.directions_car, 'Vehicle License (رخصة)', 'Valid to 2026/08')),
                    const SizedBox(width: 8),
                    Expanded(child: _verificationCheckPill(Icons.health_and_safety_outlined, 'Drug Test & Record (الفيش)', 'Clear / سليمة')),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _docThumb('assets/icons/Container.svg', 'National ID'),
                    const SizedBox(width: 8),
                    _docThumb('assets/icons/car.svg', 'Car Photo'),
                    const SizedBox(width: 8),
                    _docThumb('assets/icons/verified_user.svg', 'Faysh Sheet'),
                    const Spacer(),
                    InkWell(
                      onTap: () => cubit.reviewAllVerifications(context),
                      child: Text(
                        'Next in Queue: Capt. Mahmoud R... →',
                        style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF4338CA)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _verificationCheckPill(IconData icon, String title, String val) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 14, color: Color(0xFF16A34A)),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(fontSize: 9, color: const Color(0xFF64748B))),
                Text(val, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _docThumb(String iconPath, String label) {
    return Container(
      width: 70,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.image_outlined, size: 16, color: Color(0xFF64748B)),
          const SizedBox(height: 2),
          Text(label, style: GoogleFonts.inter(fontSize: 8, color: const Color(0xFF64748B))),
        ],
      ),
    );
  }

  Widget commissionWarningsCard(BuildContext context, DashboardCubit cubit) {
    return card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: const Color(0xFFFEE2E2), borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.warning_amber_rounded, size: 16, color: Color(0xFFDC2626)),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Commission Settlement Warnings', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                      Text('كباتن تجاوزوا الحد الائتماني الأسبوعي (500 ج)', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B))),
                    ],
                  ),
                ],
              ),
              pill('Limit: 500 EGP', const Color(0xFFFEE2E2), const Color(0xFFDC2626)),
            ],
          ),
          const SizedBox(height: 14),
          for (int i = 0; i < warningCaptains.length; i++) ...[
            _warningCaptainRow(context, warningCaptains[i], cubit),
            if (i < warningCaptains.length - 1) const SizedBox(height: 8),
          ],
          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('InstaPay / Fawry Auto-Deductions Active', style: GoogleFonts.inter(fontSize: 10, color: const Color(0xFF64748B))),
              InkWell(
                onTap: () => cubit.triggerBatchSettle(context),
                child: Text('Trigger Direct Batch Settle →', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF4338CA))),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _warningCaptainRow(BuildContext context, Map<String, dynamic> c, DashboardCubit cubit) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: c['circleBg'] as Color,
            child: Text(c['num'] as String, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: c['circleFg'] as Color)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c['name'] as String, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                Text(c['car'] as String, style: GoogleFonts.inter(fontSize: 10, color: const Color(0xFF64748B))),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(c['amount'] as String, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFFDC2626))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: c['badgeBg'] as Color, borderRadius: BorderRadius.circular(4)),
                child: Text(c['badge'] as String, style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: c['badgeFg'] as Color)),
              ),
            ],
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => cubit.clickDebtorAction(context, c['name'] as String, 'Message'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.chat_bubble_outline, size: 16, color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }

  Widget liveRideStreamTable(BuildContext context, DashboardState state, DashboardCubit cubit) {
    final filters = ['All Active (342)', 'Maadi-Tagamoa (118)', '6th Oct-Smart (94)', 'Zayed-Mohandessin (54)'];

    return card(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Live Ride Stream (جدول تدفق الرحلات اللحظية)', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                  Text('Real-time status of dispatched carpooling lines in Cairo & Giza', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B))),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < filters.length; i++) ...[
                    InkWell(
                      onTap: () => cubit.changeLiveRideFilter(i),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: state.liveRideFilterIndex == i ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          filters[i],
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: state.liveRideFilterIndex == i ? Colors.white : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ),
                    if (i < filters.length - 1) const SizedBox(width: 8),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text('RIDE ID & ROUTE SPINE', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text('CAPTAIN & VEHICLE', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text('DEPARTURE / ETA', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)))),
                Expanded(flex: 1, child: Text('SEATS FILL', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text('FARE / CASH', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text('TRIP STATUS', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)))),
                Expanded(flex: 1, child: Text('ACTIONS', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)))),
              ],
            ),
          ),
          const SizedBox(height: 8),
          for (int i = 0; i < liveRides.length; i++) ...[
            _liveRideRow(context, liveRides[i], cubit),
            if (i < liveRides.length - 1) const Divider(height: 1, color: Color(0xFFF1F5F9)),
          ],
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Showing 3 of 342 Active Dispatched Corridors', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B))),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                    onPressed: () => cubit.previousRidePage(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF0F172A),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text('Previous', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => cubit.nextRidePage(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4338CA),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text('Next Page', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _liveRideRow(BuildContext context, Map<String, dynamic> r, DashboardCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r['id'] as String, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF4338CA))),
                const SizedBox(height: 2),
                Text(r['routeMain'] as String, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                Text(r['routeSub'] as String, style: GoogleFonts.inter(fontSize: 10, color: const Color(0xFF64748B))),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: const Color(0xFFEEF2FF),
                  child: Text(r['avatarInitials'] as String, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF4338CA))),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r['captainName'] as String, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                      Text(r['carInfo'] as String, style: GoogleFonts.inter(fontSize: 10, color: const Color(0xFF64748B))),
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
                Text(r['depTime'] as String, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                Text(r['eta'] as String, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: r['etaColor'] as Color)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int s = 0; s < (r['seatsTotal'] as int); s++)
                  Icon(
                    Icons.event_seat,
                    size: 14,
                    color: s < (r['seatsFilled'] as int) ? const Color(0xFF4338CA) : const Color(0xFFCBD5E1),
                  ),
                const SizedBox(width: 4),
                Text('${r['seatsFilled']}/${r['seatsTotal']}', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r['fareTotal'] as String, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                Text(r['fareSub'] as String, style: GoogleFonts.inter(fontSize: 10, color: const Color(0xFF64748B))),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: r['statusBg'] as Color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  r['status'] as String,
                  style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: r['statusFg'] as Color),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: OutlinedButton(
              onPressed: () => cubit.trackRide(context, r['id'] as String),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF4338CA),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: Text('Track', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget recentActivityLedger(BuildContext context, DashboardCubit cubit) {
    return card(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.receipt_long_outlined, size: 16, color: Color(0xFF4338CA)),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recent Operational Activity Ledger (سجل النشاط التشغيلي اللحظي)', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                      Text('Chronological trace of completions, commission entries, and credential clearances', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B))),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () => cubit.exportCsvLog(context),
                child: Text('Export CSV Log', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF4338CA))),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = (constraints.maxWidth - (3 * 12)) / 4;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final item in activityLedger)
                    SizedBox(
                      width: constraints.maxWidth >= 900 ? itemWidth : (constraints.maxWidth - 12) / 2,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(color: item['tagBg'] as Color, borderRadius: BorderRadius.circular(4)),
                                  child: Text(item['tag'] as String, style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: item['tagFg'] as Color)),
                                ),
                                Text(item['time'] as String, style: GoogleFonts.inter(fontSize: 9, color: const Color(0xFF64748B))),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(item['title'] as String, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                            const SizedBox(height: 4),
                            Text(item['desc'] as String, style: GoogleFonts.inter(fontSize: 9, color: const Color(0xFF64748B)), maxLines: 2, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 8),
                            const Divider(height: 1, color: Color(0xFFE2E8F0)),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item['footerLeft'] as String, style: GoogleFonts.inter(fontSize: 9, color: const Color(0xFF64748B))),
                                Text(
                                  item['footerRight'] as String,
                                  style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: item['footerRightColor'] as Color),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CairoMapGridPainter extends CustomPainter {
  final bool isHeatmap;

  _CairoMapGridPainter({required this.isHeatmap});

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFE2E8F0);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final nilePaint = Paint()
      ..color = const Color(0xFFBFDBFE)
      ..strokeWidth = 22
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final nilePath = Path();
    nilePath.moveTo(size.width * 0.44, size.height);
    nilePath.cubicTo(
      size.width * 0.48, size.height * 0.7,
      size.width * 0.40, size.height * 0.35,
      size.width * 0.46, 0,
    );
    canvas.drawPath(nilePath, nilePaint);

    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final ringRoadPath = Path();
    ringRoadPath.addOval(Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.5),
      width: size.width * 0.75,
      height: size.height * 0.8,
    ));
    canvas.drawPath(ringRoadPath, roadPaint);

    final corridor1 = Paint()
      ..color = const Color(0xFF4338CA).withValues(alpha: 0.85)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(size.width * 0.15, size.height * 0.35), Offset(size.width * 0.45, size.height * 0.45), corridor1);
    canvas.drawLine(Offset(size.width * 0.45, size.height * 0.45), Offset(size.width * 0.85, size.height * 0.55), corridor1);

    if (isHeatmap) {
      final heatPaint = Paint()
        ..color = const Color(0xFFEF4444).withValues(alpha: 0.35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
      canvas.drawCircle(Offset(size.width * 0.46, size.height * 0.5), 45, heatPaint);
      canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.52), 35, heatPaint);
    }

    final stopPaint = Paint()..color = const Color(0xFF4338CA);
    final hubPaint = Paint()..color = const Color(0xFF0F172A);
    final carPaint = Paint()..color = const Color(0xFF16A34A);

    canvas.drawCircle(Offset(size.width * 0.15, size.height * 0.35), 6, stopPaint);
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.55), 6, hubPaint);
    canvas.drawCircle(Offset(size.width * 0.52, size.height * 0.47), 5, carPaint);
    canvas.drawCircle(Offset(size.width * 0.32, size.height * 0.41), 5, carPaint);
  }

  @override
  bool shouldRepaint(covariant _CairoMapGridPainter oldDelegate) => oldDelegate.isHeatmap != isHeatmap;
}
