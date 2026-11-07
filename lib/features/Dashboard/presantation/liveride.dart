import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const SikkaDashboardApp());
}

abstract class SikkaDashboardState {}

class SikkaDashboardInitial extends SikkaDashboardState {}

class DashboardRide {
  final String routeMain;
  final String routeSub;
  final String captName;
  final String captCar;
  final String dep;
  final String eta;
  final String seats;
  final String fare;
  final String status;
  final Color statusColor;

  const DashboardRide({
    required this.routeMain,
    required this.routeSub,
    required this.captName,
    required this.captCar,
    required this.dep,
    required this.eta,
    required this.seats,
    required this.fare,
    required this.status,
    required this.statusColor,
  });
}

class SikkaDashboardLoaded extends SikkaDashboardState {
  final bool isRtl;
  final String selectedFilter;
  final bool isCaptainApproved;
  final List<DashboardRide> rides;

  SikkaDashboardLoaded({
    required this.isRtl,
    required this.selectedFilter,
    required this.isCaptainApproved,
    required this.rides,
  });

  SikkaDashboardLoaded copyWith({
    bool? isRtl,
    String? selectedFilter,
    bool? isCaptainApproved,
    List<DashboardRide>? rides,
  }) {
    return SikkaDashboardLoaded(
      isRtl: isRtl ?? this.isRtl,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      isCaptainApproved: isCaptainApproved ?? this.isCaptainApproved,
      rides: rides ?? this.rides,
    );
  }
}


class SikkaDashboardCubit extends Cubit<SikkaDashboardState> {
  SikkaDashboardCubit()
    : super(
        SikkaDashboardLoaded(
          isRtl: true,
          selectedFilter: 'All Active (342)',
          isCaptainApproved: false,
          rides: [
            DashboardRide(
              routeMain: 'Degla, Maadi → New Cairo Teseen',
              routeSub: 'SK-8921 • دجلة المعادي إلى التجمع',
              captName: 'Youssef Mansour',
              captCar: 'YM • Kia Cerato',
              dep: '08:15 AM',
              eta: 'ETA 08:48 AM (On Track)',
              seats: '3/4',
              fare: '120 EGP Total (40 EGP/seat)',
              status: 'Live Transit',
              statusColor: Colors.green,
            ),
            DashboardRide(
              routeMain: 'Hyper One Zayed → Smart Village Hub',
              routeSub: 'SK-8924 • هايبر وان الشيخ زايد إلى القرية الذكية',
              captName: 'Nouran Allam',
              captCar: 'NA • MG 5',
              dep: '08:30 AM',
              eta: 'ETA 08:52 AM (On Track)',
              seats: '4/4 Full',
              fare: '140 EGP Total (35 EGP/seat In-App)',
              status: 'Full',
              statusColor: Colors.blue,
            ),
            DashboardRide(
              routeMain: 'Heliopolis Merghany → Tagamoa 1',
              routeSub: 'SK-8929 • شارع الميرغني إلى التجمع الأول',
              captName: 'Mostafa Kamal',
              captCar: 'MK • Chery Arrizo 5',
              dep: '08:45 AM',
              eta: 'Boarding at Pick Point',
              seats: '2/4',
              fare: '90 EGP Total (45 EGP/seat)',
              status: 'Waiting',
              statusColor: Colors.amber,
            ),
          ],
        ),
      );

  void toggleLanguage() {
    if (state is SikkaDashboardLoaded) {
      final currentState = state as SikkaDashboardLoaded;
      emit(currentState.copyWith(isRtl: !currentState.isRtl));
    }
  }

  void changeRideFilter(String newFilter) {
    if (state is SikkaDashboardLoaded) {
      final currentState = state as SikkaDashboardLoaded;
      emit(currentState.copyWith(selectedFilter: newFilter));
    }
  }

  void toggleCaptainApproval() {
    if (state is SikkaDashboardLoaded) {
      final currentState = state as SikkaDashboardLoaded;
      emit(
        currentState.copyWith(
          isCaptainApproved: !currentState.isCaptainApproved,
        ),
      );
    }
  }

  void refreshDashboardData() {
    if (state is SikkaDashboardLoaded) {
      final currentState = state as SikkaDashboardLoaded;
      emit(currentState.copyWith());
    }
  }
}

// 
class SikkaDashboardApp extends StatelessWidget {
  const SikkaDashboardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SikkaDashboardCubit(),
      child: BlocBuilder<SikkaDashboardCubit, SikkaDashboardState>(
        builder: (context, state) {
          bool isRtl = true;
          if (state is SikkaDashboardLoaded) {
            isRtl = state.isRtl;
          }

          return MaterialApp(
            title: 'Sikka Operations Dashboard',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Segoe UI',
              scaffoldBackgroundColor: const Color(0xFFF8FAFC),
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF2563EB),
                primary: const Color(0xFF2563EB),
              ),
            ),
            home: const DashboardScreen(),
          );
        },
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SikkaDashboardCubit, SikkaDashboardState>(
      builder: (context, state) {
        if (state is! SikkaDashboardLoaded) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final cubit = context.read<SikkaDashboardCubit>();

        return Directionality(
          textDirection: state.isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            backgroundColor: const Color(0xFFF1F5F9),
            body: Row(
              children: [
                _buildSidebar(state),
                Expanded(
                  child: Column(
                    children: [
                      _buildHeader(context, state, cubit),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildMetricsRow(state),
                              const SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: _buildCorridorMapCard(state, cubit),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    flex: 5,
                                    child: _buildTopCorridorsCard(state),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: _buildCaptainVerificationCard(
                                      state,
                                      cubit,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    flex: 6,
                                    child: _buildCommissionWarningsCard(state),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              _buildLiveRideStreamCard(state, cubit),
                              const SizedBox(height: 20),
                              _buildActivityLedgerCard(state),
                            ],
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
      },
    );
  }

  Widget _buildSidebar(SikkaDashboardLoaded state) {
    return Container(
      width: 230,
      color: const Color(0xFF1E293B),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.directions_car,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'SIKKA |||||',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          _sidebarNavItem(
            Icons.dashboard,
            state.isRtl ? 'لوحة التحكم' : 'Dashboard',
            isActive: true,
          ),
          _sidebarNavItem(
            Icons.people_outline,
            state.isRtl ? 'المستخدمين' : 'Users',
          ),
          _sidebarNavItem(
            Icons.badge_outlined,
            state.isRtl ? 'الكباتن' : 'Captains',
          ),
          _sidebarNavItem(
            Icons.verified_user_outlined,
            state.isRtl ? 'التحقق' : 'Verification',
            badge: '28',
          ),
          _sidebarNavItem(
            Icons.route_outlined,
            state.isRtl ? 'الرحلات' : 'Rides',
          ),
          _sidebarNavItem(
            Icons.account_balance_wallet_outlined,
            state.isRtl ? 'المالية' : 'Finance',
          ),
          _sidebarNavItem(
            Icons.bar_chart_outlined,
            state.isRtl ? 'التقارير' : 'Reports',
          ),
          _sidebarNavItem(
            Icons.settings_outlined,
            state.isRtl ? 'الإعدادات' : 'Settings',
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF334155),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.blue,
                  child: Text(
                    'TM',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.isRtl ? 'تامر مصطفى' : 'Tamer Mostafa',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        state.isRtl ? 'مسؤول العمليات' : 'Ops Admin',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
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
    );
  }

  Widget _sidebarNavItem(
    IconData icon,
    String title, {
    bool isActive = false,
    String? badge,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF2563EB) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          icon,
          color: isActive ? Colors.white : Colors.blueGrey.shade200,
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.blueGrey.shade100,
            fontSize: 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: badge != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange.shade700,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    SikkaDashboardLoaded state,
    SikkaDashboardCubit cubit,
  ) {
    return Container(
      height: 64,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            state.isRtl
                ? 'لوحة التحكم العامة - Operations Dispatch'
                : 'Admin Operations Dashboard',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              height: 38,
              child: TextField(
                decoration: InputDecoration(
                  hintText: state.isRtl
                      ? 'بحث عن مستخدمين، كباتن، رحلات...'
                      : 'Search users, captains, ride IDs...',
                  prefixIcon: const Icon(Icons.search, size: 18),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF8FAFC),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          OutlinedButton.icon(
            onPressed: () => cubit.toggleLanguage(),
            icon: const Icon(Icons.language, size: 16),
            label: Text(state.isRtl ? 'English' : 'العربية'),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          Chip(
            avatar: const CircleAvatar(
              backgroundColor: Colors.green,
              radius: 4,
            ),
            label: Text(
              state.isRtl ? 'متصل' : 'Online',
              style: const TextStyle(fontSize: 12),
            ),
            backgroundColor: Colors.green.shade50,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsRow(SikkaDashboardLoaded state) {
    return Row(
      children: [
        Expanded(
          child: _metricCard(
            state.isRtl ? 'إجمالي المستخدمين' : 'TOTAL USERS',
            '14,820',
            'Pass: 11,400 | Capt: 3,420',
            Icons.people,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _metricCard(
            state.isRtl ? 'كباتن الأسطول' : 'FLEET CAPTAINS',
            '3,420',
            '2,890 Active | 410 Off',
            Icons.directions_car,
            Colors.green.shade700,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _metricCard(
            state.isRtl ? 'التحقق المعلق' : 'VERIFICATION NEEDED',
            '28',
            'Avg Wait: 22 mins',
            Icons.pending_actions,
            Colors.amber.shade700,
            isAlert: true,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _metricCard(
            state.isRtl ? 'الرحلات النشطة' : 'ACTIVE RIDES',
            '342',
            'In Transit: 342 | 97.4% On-Time',
            Icons.navigation,
            Colors.indigo,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _metricCard(
            state.isRtl ? 'إجمالي العمولة' : 'COMMISSION (EGP)',
            '48,650 EGP',
            'Weekly 10% Fee | 4k Pending',
            Icons.account_balance_wallet,
            Colors.teal,
          ),
        ),
      ],
    );
  }

  Widget _metricCard(
    String title,
    String mainValue,
    String subText,
    IconData icon,
    Color color, {
    bool isAlert = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isAlert ? Colors.amber.shade300 : const Color(0xFFE2E8F0),
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
              Icon(icon, size: 18, color: color),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            mainValue,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isAlert ? Colors.amber.shade900 : Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subText,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildCorridorMapCard(
    SikkaDashboardLoaded state,
    SikkaDashboardCubit cubit,
  ) {
    return Container(
      height: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                state.isRtl
                    ? 'خريطة المحاور المباشرة القاهرة والجيزة'
                    : 'Cairo & Giza Corridor Real-Time Grid',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => cubit.refreshDashboardData(),
                icon: const Icon(Icons.refresh, size: 14),
                label: Text(state.isRtl ? 'تحديث (5ث)' : 'Refresh (5s)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2FE),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map, size: 48, color: Colors.blue),
                        SizedBox(height: 6),
                        Text(
                          'Interactive Cairo Live Traffic & Corridor Map',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      color: Colors.white70,
                      child: const Text(
                        'Peak Flow: Ring Road -> New Cairo',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopCorridorsCard(SikkaDashboardLoaded state) {
    return Container(
      height: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                state.isRtl
                    ? 'المحاور الأكثر نشاطاً'
                    : 'Top Arterial Corridors',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  state.isRtl ? '4 طرق رئيسية' : '4 Major Routes',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                _corridorListItem(
                  state,
                  '01',
                  'المعادي ↔ التجمع الخامس',
                  'Maadi Ring Rd → New Cairo South 90th',
                  '118 rides',
                  '98% Capacity',
                  Colors.blue,
                ),
                _corridorListItem(
                  state,
                  '02',
                  'الهرم / 6 أكتوبر ↔ القرية الذكية',
                  'Haram / 6th Oct → Smart Village',
                  '94 rides',
                  'Normal Flow',
                  Colors.green,
                ),
                _corridorListItem(
                  state,
                  '03',
                  'مصر الجديدة ↔ التجمع',
                  'Heliopolis Roxky → AUC / Choueifat',
                  '76 rides',
                  '+8m Delay',
                  Colors.orange,
                ),
                _corridorListItem(
                  state,
                  '04',
                  'الشيخ زايد ↔ المهندسين',
                  'Sheikh Zayed HyperOne → Lebanon Sq',
                  '54 rides',
                  'Corridor OK',
                  Colors.purple,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _corridorListItem(
    SikkaDashboardLoaded state,
    String num,
    String nameAr,
    String nameEn,
    String rides,
    String status,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: color,
            child: Text(
              num,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.isRtl ? nameAr : nameEn,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  rides,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Text(
            status,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaptainVerificationCard(
    SikkaDashboardLoaded state,
    SikkaDashboardCubit cubit,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                state.isRtl
                    ? 'مراجعة توثيق الكباتن العاجلة'
                    : 'Urgent Captain Verification Review',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Chip(
                label: Text(
                  state.isRtl ? 'الانتظار: 28' : 'Queue: 28',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
                backgroundColor: Colors.orange.shade800,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Capt. Ahmed El-Shennawy',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      state.isRtl
                          ? 'كابتن أحمد الشناوي | Toyota Corolla 2022'
                          : 'Toyota Corolla 2022 • Plate: (س ر ج 1928)',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const Text(
                      'Cairo Traffic Unit • License Valid to 2026/08',
                      style: TextStyle(fontSize: 11, color: Colors.blue),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () => cubit.toggleCaptainApproval(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: state.isCaptainApproved
                          ? Colors.grey
                          : Colors.green.shade600,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      state.isCaptainApproved
                          ? (state.isRtl ? 'تم القبول' : 'Approved')
                          : (state.isRtl ? 'قبول الكابتن' : 'Approve Captain'),
                    ),
                  ),
                  const SizedBox(height: 4),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: Text(state.isRtl ? 'رفض' : 'Reject'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _docCheckItem(
                state.isRtl ? 'البطاقة القومية' : 'National ID',
                true,
              ),
              _docCheckItem(
                state.isRtl ? 'رخصة السيارة' : 'Vehicle License',
                true,
              ),
              _docCheckItem(state.isRtl ? 'فحص المخدرات' : 'Drug Test', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _docCheckItem(String label, bool isDone) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDone ? Colors.green.shade50 : Colors.amber.shade50,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(
              isDone ? Icons.check_circle : Icons.warning,
              size: 14,
              color: isDone ? Colors.green : Colors.amber.shade900,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommissionWarningsCard(SikkaDashboardLoaded state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                state.isRtl
                    ? 'تحذيرات تسوية العمولات'
                    : 'Commission Settlement Warnings',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                state.isRtl ? 'الحد: 500 ج.م' : 'Limit: 500 EGP',
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _warningRow(
            'كريم عادل Karim Adel',
            'Nissan Sunny • Maadi Sector',
            '620 EGP',
            'Due 3 days',
            Colors.red,
          ),
          _warningRow(
            'حسن الغزالي Hassan El-Ghazaly',
            'Hyundai Elantra • 6th October',
            '540 EGP',
            'Suspended',
            Colors.orange,
          ),
          _warningRow(
            'شريف فايد Sherif Fayed',
            'Kia Cerato • New Cairo',
            '485 EGP',
            'Near Limit',
            Colors.amber.shade800,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  state.isRtl
                      ? 'خصم تلقائي InstaPay / Fawry'
                      : 'InstaPay / Fawry Auto Deductions',
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  state.isRtl
                      ? 'بدء التسوية المباشرة'
                      : 'Trigger Direct Batch Settle',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _warningRow(
    String name,
    String details,
    String egp,
    String status,
    Color statusColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                details,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                egp,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 10,
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLiveRideStreamCard(
    SikkaDashboardLoaded state,
    SikkaDashboardCubit cubit,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                state.isRtl
                    ? 'البث المباشر للرحلات (Live Ride Stream)'
                    : 'Live Ride Stream',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 15),
              Wrap(
                spacing: 8,
                children:
                    [
                      'All Active (342)',
                      'Seats Full (210)',
                      'Has Seats (98)',
                      'Boarding (34)',
                    ].map((filter) {
                      bool isSelected = state.selectedFilter == filter;
                      return ChoiceChip(
                        label: Text(
                          filter,
                          style: TextStyle(
                            fontSize: 11,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: const Color(0xFF1E293B),
                        onSelected: (val) => cubit.changeRideFilter(filter),
                      );
                    }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 24,
              columns: const [
                DataColumn(label: Text('RIDE ID & ROUTE')),
                DataColumn(label: Text('CAPTAIN & VEHICLE')),
                DataColumn(label: Text('DEPARTURE / ETA')),
                DataColumn(label: Text('SEATS FILL')),
                DataColumn(label: Text('FARE / CASH')),
                DataColumn(label: Text('TRIP STATUS')),
                DataColumn(label: Text('ACTIONS')),
              ],
              rows: state.rides
                  .map(
                    (ride) => _buildDataRow(
                      ride.routeMain,
                      ride.routeSub,
                      ride.captName,
                      ride.captCar,
                      ride.dep,
                      ride.eta,
                      ride.seats,
                      ride.fare,
                      ride.status,
                      ride.statusColor,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(
    String routeMain,
    String routeSub,
    String captName,
    String captCar,
    String dep,
    String eta,
    String seats,
    String fare,
    String status,
    Color statusColor,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                routeMain,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                routeSub,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                captName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                captCar,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dep,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
              Text(
                eta,
                style: const TextStyle(fontSize: 10, color: Colors.green),
              ),
            ],
          ),
        ),
        DataCell(
          Text(seats, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(Text(fare, style: const TextStyle(fontSize: 11))),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ),
        DataCell(
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              visualDensity: VisualDensity.compact,
            ),
            child: const Text('Track', style: TextStyle(fontSize: 11)),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityLedgerCard(SikkaDashboardLoaded state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                state.isRtl
                    ? 'سجل الأنشطة التشغيلية الحديثة (Operational Ledger)'
                    : 'Recent Operational Activity Ledger',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download, size: 14),
                label: Text(state.isRtl ? 'تصدير ملف CSV' : 'Export CSV Log'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _ledgerItem(
                  'Ride Completed',
                  '1 min ago',
                  'Ring Road Segment (Munib → New Cairo)',
                  'Capt. Tarek completed drop-off for 3 passengers. Trip Fare: 150 EGP (+15 EGP SIKKA Fee)',
                  Colors.green,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ledgerItem(
                  'Cash Recorded',
                  '3 mins ago',
                  'Cash Payment: 50 EGP (Mohandessin)',
                  'Passenger Salma paid cash. 10% platform commission debited to Capt. wallet.',
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ledgerItem(
                  'Captain Approved',
                  '6 mins ago',
                  'Captain Omar F. Clearance Granted',
                  'National ID & Nissan Sentra registration verified. SMS automatically sent.',
                  Colors.purple,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ledgerItem(
                  'New Route Published',
                  '9 mins ago',
                  'Zayed Arkan → Smart Village Line',
                  'Capt. Dina published 3 empty seats for 09:15 AM schedule. Match Score: 98%',
                  Colors.teal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _ledgerItem(
    String tag,
    String time,
    String title,
    String desc,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                time,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
