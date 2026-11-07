import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/ridemanagement_cubit.dart';
import '../logic/ridemanagment_state.dart';

void main() {
  runApp(const SikkaRidesApp());
}

class SikkaRidesApp extends StatelessWidget {
  const SikkaRidesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SikkaRidesCubit(),
      child: BlocBuilder<SikkaRidesCubit, SikkaRidesState>(
        builder: (context, _) {
          return MaterialApp(
            title: 'Sikka Rides Dashboard',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Segoe UI',
              scaffoldBackgroundColor: const Color(0xFFF8FAFC),
            ),
            home: const RidesScreen(),
          );
        },
      ),
    );
  }
}

class RidesScreen extends StatelessWidget {
  const RidesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SikkaRidesCubit, SikkaRidesState>(
      builder: (context, state) {
        final s = state as SikkaRidesLoaded;
        final cubit = context.read<SikkaRidesCubit>();

        return Directionality(
          textDirection: s.isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            body: Row(
              children: [
                // Sidebar
                _buildSidebar(s),

                // Main Content
                Expanded(
                  child: Column(
                    children: [
                      _buildHeader(s, cubit),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTopFiltersBar(s, cubit),
                              const SizedBox(height: 20),
                              _buildRidesTable(s),
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

  Widget _buildSidebar(SikkaRidesLoaded state) {
    return Container(
      width: 220,
      color: const Color(0xFF1E293B),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SIKKA |||||',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 30),
          _sidebarItem(
            Icons.dashboard,
            state.isRtl ? 'لوحة التحكم' : 'Dashboard',
            false,
          ),
          _sidebarItem(
            Icons.people_outline,
            state.isRtl ? 'الكباتن' : 'Captains',
            false,
          ),
          _sidebarItem(
            Icons.verified_user_outlined,
            state.isRtl ? 'التحقق' : 'Verification',
            false,
            badge: '18',
          ),
          _sidebarItem(
            Icons.route_outlined,
            state.isRtl ? 'الرحلات' : 'Rides',
            true,
          ),
          _sidebarItem(
            Icons.account_balance_wallet_outlined,
            state.isRtl ? 'المالية' : 'Finance',
            false,
          ),
          _sidebarItem(
            Icons.bar_chart_outlined,
            state.isRtl ? 'التقارير' : 'Reports',
            false,
          ),
          _sidebarItem(
            Icons.settings_outlined,
            state.isRtl ? 'الإعدادات' : 'Settings',
            false,
          ),
        ],
      ),
    );
  }

  Widget _sidebarItem(
    IconData icon,
    String title,
    bool isActive, {
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
            ? Chip(
                label: Text(
                  badge,
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
                backgroundColor: Colors.orange,
                padding: EdgeInsets.zero,
              )
            : null,
      ),
    );
  }

  Widget _buildHeader(SikkaRidesLoaded state, SikkaRidesCubit cubit) {
    return Container(
      height: 64,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 38,
              child: TextField(
                decoration: InputDecoration(
                  hintText: state.isRtl
                      ? 'بحث برقم الرحلة، الكابتن، أو المسار...'
                      : 'Search Corridor, Captain...',
                  prefixIcon: const Icon(Icons.search, size: 18),
                  contentPadding: EdgeInsets.zero,
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
        ],
      ),
    );
  }

  Widget _buildTopFiltersBar(SikkaRidesLoaded state, SikkaRidesCubit cubit) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            spacing: 10,
            children: [
              _statusChip('Active (342)', Colors.blue, state, cubit),
              _statusChip('Upcoming (84)', Colors.purple, state, cubit),
              _statusChip('Fully Booked (215)', Colors.orange, state, cubit),
              _statusChip('Completed (1,290)', Colors.green, state, cubit),
            ],
          ),
          Row(
            children: [
              const Text(
                'Strict Fixed Waypoint Mode • Zero Detour Tolerated: Max 2.5km',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusChip(
    String label,
    Color color,
    SikkaRidesLoaded state,
    SikkaRidesCubit cubit,
  ) {
    bool isSelected = state.selectedTab == label;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
      selected: isSelected,
      selectedColor: color,
      backgroundColor: color.withOpacity(0.1),
      onSelected: (_) => cubit.changeTab(label),
    );
  }

  Widget _buildRidesTable(SikkaRidesLoaded state) {
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
          const Text(
            'Active Carpool Corridors Stream (عرض 5 من إجمالي 342 رحلة مطابقة)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 20,
              columns: const [
                DataColumn(label: Text('RIDE ID & CORRIDOR')),
                DataColumn(label: Text('CAPTAIN')),
                DataColumn(label: Text('DEPARTURE')),
                DataColumn(label: Text('SEAT & PASSENGERS')),
                DataColumn(label: Text('PRICE / FARE')),
                DataColumn(label: Text('ROUTE DEVIATION')),
                DataColumn(label: Text('PAYMENT')),
                DataColumn(label: Text('STATUS')),
              ],
              rows: state.rides.map((ride) {
                return DataRow(
                  cells: [
                    DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ride.id,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            ride.route,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Text(ride.captain, style: const TextStyle(fontSize: 11)),
                    ),
                    DataCell(
                      Text(
                        ride.departure,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(ride.seats, style: const TextStyle(fontSize: 11)),
                    ),
                    DataCell(
                      Text(
                        ride.price,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        ride.deviation,
                        style: const TextStyle(fontSize: 11, color: Colors.red),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          ride.payment,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: ride.statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          ride.status,
                          style: TextStyle(
                            color: ride.statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
