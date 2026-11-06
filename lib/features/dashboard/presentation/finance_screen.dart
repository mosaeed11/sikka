import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidebarx/sidebarx.dart';
import '../logic/dashboard_cubit.dart';
import '../logic/dashboard_state.dart';


class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: const _FinanceScreenView(),
    );
  }
}

class _FinanceScreenView extends StatefulWidget {
  const _FinanceScreenView();

  @override
  State<_FinanceScreenView> createState() => _FinanceScreenViewState();
}

class _FinanceScreenViewState extends State<_FinanceScreenView> {
  late final SidebarXController sidebarController;

  @override
  void initState() {
    super.initState();
    sidebarController = SidebarXController(
      selectedIndex: 5,
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

  final List<Map<String, dynamic>> debtors = [
    {'name': 'Mahmoud El-Gohary', 'phone': '+20 100 847 2910', 'plate': 'س ط د ٧٨٩', 'car': 'Nissan Sunny', 'trips': '42', 'gross': '12,450', 'debt': '1,245.00', 'deadline': 'Overdue by 9 days', 'status': 'Suspended', 'isLate': true},
    {'name': 'Sherif Abdelmonem', 'phone': '+20 114 930 4421', 'plate': 'ق ه ع ٣٤٥', 'car': 'Renault Megane', 'trips': '28', 'gross': '7,900', 'debt': '790.00', 'deadline': '5 days remaining', 'status': 'Warning', 'isLate': false},
    {'name': 'Hazem Farouk', 'phone': '+20 122 301 9901', 'plate': 'ع م ن ٥٦٤', 'car': 'Toyota Corolla', 'trips': '31', 'gross': '9,120', 'debt': '912.00', 'deadline': 'Overdue by 2 days', 'status': 'Suspended', 'isLate': true},
    {'name': 'Khaled Anwar', 'phone': '+20 102 771 8329', 'plate': 'ب ر ق ١٢', 'car': 'Kia Cerato', 'trips': '18', 'gross': '4,600', 'debt': '460.00', 'deadline': 'Normal Cycle', 'status': 'Active', 'isLate': false},
  ];

  final List<Map<String, dynamic>> transactions = [
    {'id': 'TXN-884920', 'time': 'Today, 14:32\n26 Oct 2024', 'ride': '#RD-4921\nZayed → Smart Village Hub', 'captain': 'Tarek Nour', 'mode': 'cash', 'gross': '180.00', 'fee': '18.00', 'net': '162.00', 'status': 'pending'},
    {'id': 'TXN-884919', 'time': 'Today, 13:58\n26 Oct 2024', 'ride': '#RD-4918\nMaadi → New Cairo 5th Sett.', 'captain': 'Mina Wagdy', 'mode': 'electronic', 'gross': '240.00', 'fee': '24.00', 'net': '216.00', 'status': 'settled'},
    {'id': 'TXN-884918', 'time': 'Today, 13:12\n26 Oct 2024', 'ride': '#RD-4912\nNasr City → Dokki Square', 'captain': 'Hossam Hassan', 'mode': 'instapay', 'gross': '150.00', 'fee': '15.00', 'net': '135.00', 'status': 'settled'},
    {'id': 'TXN-884917', 'time': 'Today, 12:45\n26 Oct 2024', 'ride': '#RD-4908\nHeliopolis → Obour City', 'captain': 'Sherif Abdelmonem', 'mode': 'cash', 'gross': '210.00', 'fee': '21.00', 'net': '189.00', 'status': 'pending'},
    {'id': 'TXN-884916', 'time': 'Today, 11:30\n26 Oct 2024', 'ride': '#RD-4899\nMohandessin → Rehab Gate 6', 'captain': 'Karim Sami', 'mode': 'cash', 'gross': '320.00', 'fee': '32.00', 'net': '288.00', 'status': 'reconciled'},
  ];

  List<Map<String, dynamic>> _getFilteredDebtors(int filterIndex) {
    if (filterIndex == 1) {
      return debtors.where((d) => d['isLate'] == true).toList();
    } else if (filterIndex == 2) {
      return debtors.where((d) => d['status'] == 'Warning').toList();
    }
    return debtors;
  }

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
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                pageHeader(context, cubit),
                                const SizedBox(height: 28),
                                heroBanner(),
                                const SizedBox(height: 28),
                                statsRow(),
                                const SizedBox(height: 28),
                                middleCardsRow(context, cubit),
                                const SizedBox(height: 32),
                                debtorsTable(context, state, cubit),
                                const SizedBox(height: 32),
                                transactionsTable(),
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
        border: Border.all(color: Color(0xFFE2E8F0)),
      ),
      child: child,
    );
  }

  Widget pill(String text, Color bg, Color fg) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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

  Widget headerCell(int flex, String text) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
      ),
    );
  }

  Widget smallButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFE2E8F0)),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
      ),
    );
  }

  Widget sidebar(BuildContext context, DashboardCubit cubit) {
    return SidebarX(
      controller: sidebarController,
      showToggleButton: false,
      theme: SidebarXTheme(
        decoration: BoxDecoration(color: Colors.white),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
        selectedTextStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
        hoverTextStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
        hoverColor: Color(0xFFF8FAFC),
        itemTextPadding: EdgeInsets.only(left: 12),
        selectedItemTextPadding: EdgeInsets.only(left: 12),
        itemDecoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        selectedItemDecoration: BoxDecoration(
          color: Color(0xFF4338CA),
          borderRadius: BorderRadius.circular(10),
        ),
        iconTheme: IconThemeData(color: Color(0xFF64748B), size: 20),
        selectedIconTheme: IconThemeData(color: Colors.white, size: 20),
      ),
      extendedTheme: SidebarXTheme(
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
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFF4338CA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.directions_car_outlined, color: Colors.white, size: 22),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SIKKA', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                    Text('Operations Portal', style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF64748B))),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Operational Fleet', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
                  Row(
                    children: [
                      Icon(Icons.circle, size: 8, color: Color(0xFF16A34A)),
                      SizedBox(width: 4),
                      Text('Live System', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF16A34A))),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        );
      },
      footerBuilder: (context, extended) {
        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFF4338CA),
                child: Icon(Icons.person_outline, color: Colors.white, size: 18),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tamer Mostafa', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                    Text('Ops Admin (مدير تشغيل)', style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B))),
                  ],
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: Color(0xFF64748B)),
            ],
          ),
        );
      },
      items: [
        for (int i = 0; i < menuItems.length; i++)
          SidebarXItem(
            icon: menuItems[i]['icon'] is IconData
                ? menuItems[i]['icon'] as IconData
                : null,
            iconBuilder: menuItems[i]['icon'] is Widget
              ? (context, isSelected) => menuItems[i]['icon'] as Widget
                : null,
            label: menuItems[i]['label'] as String?,
            onTap: () => cubit.changeNavIndex(context, i)
          ),
      ],
    );
  }

  Widget topBar(BuildContext context, DashboardState state, DashboardCubit cubit) {
    return Container(
      height: 78,
      padding: const EdgeInsets.symmetric(horizontal: 32),
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
                hintText: 'Search users, captains, ride IDs, or nati',
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
          SizedBox(width: 20),
          CircleAvatar(
            backgroundColor: Color(0xFF4338CA),
            child: Icon(Icons.person_outline, color: Colors.white),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Operations Control', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              Text('Online', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF16A34A))),
            ],
          ),
        ],
      ),
    );
  }
  Widget pageHeader(BuildContext context, DashboardCubit cubit) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 1100;
        return Flex(
          direction: isCompact ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/finance.svg',
                          width: 12.67,
                          height: 12,
                          colorFilter: const ColorFilter.mode(Color(0xFF4338CA), BlendMode.srcIn),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Financial Governance',
                          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF4338CA)),
                        ),
                      ],
                    ),
                    Text(
                      '• الإدارة المالية وحسابات التحصيل',
                      style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Live Audit: Cycle W-44',
                        style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF16A34A)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    Text(
                      'Financial Treasury &\nCommission Ledger',
                      style: GoogleFonts.inter(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A),
                        height: 1.15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        'الدفتر المالي وعمولات\nالمنصة (%10)',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: const Color(0xFF64748B),
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (isCompact) const SizedBox(height: 16),
            Column(
              crossAxisAlignment: isCompact ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: isCompact ? WrapAlignment.start : WrapAlignment.end,
                  children: [
                    card(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.calendar_today_outlined, size: 18, color: Color(0xFF0F172A)),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Current Billing Cycle',
                                style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B)),
                              ),
                              Text(
                                '01 Oct - 26 Oct 2024',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => cubit.clickExportInvoice(context),
                      icon: const Icon(Icons.download, size: 18),
                      label: Text(
                        'Export Tax Invoice (Fawry / PDF)',
                        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF0F172A),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      )
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () => cubit.clickManualReconciliation(context),
                  icon: SvgPicture.asset(
                    'assets/icons/money.svg',
                    width: 16.5,
                    height: 16.5,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  label: Text(
                    'Manual Balance Reconciliation',
                    style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4338CA),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }



  Widget formulaBox(String title, String value, String sub, Color bg, Color valueColor) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: valueColor)),
          Text(value, style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: valueColor)),
          Text(sub, style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B))),
        ],
      ),
    );
  }

  Widget heroBanner() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Color(0xFFE0E7FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFC7D2FE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pill('Strict Transparent Protocol: 10% Flat Rate Fee', Colors.white, Color(0xFF4338CA)),
                SizedBox(height: 12),
                Text(
                  'معادلة الحسبة المالية لكباتن سِكّة',
                  style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                ),
                SizedBox(height: 10),
                Text(
                  'تطبق المنصة شفافية مطلقة: 90% من قيمة الرحلة تذهب بالكامل للكابتن دون اقتطاعات خفية. في حالة الرحلات النقدية، تظل نسبة الـ 10% مديونية كاش لصالح سِكّة يجب تسويتها أسبوعيًا لتفادي تعليق الحساب.',
                  style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
          SizedBox(width: 24),
          Expanded(
            flex: 5,
            child: card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: formulaBox('Gross Fare (إجمالي)', '100%', 'أجرة الرحلة كاملة', Color(0xFFF8FAFC), Color(0xFF0F172A)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('—', style: GoogleFonts.inter(fontSize: 20, color: Color(0xFF0F172A))),
                      ),
                      Expanded(
                        child: formulaBox('SIKKA Fee (العمولة)', '10.0%', 'رسم تشغيل وربط', Color(0xFFE0E7FF), Color(0xFF4338CA)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('=', style: GoogleFonts.inter(fontSize: 20, color: Color(0xFF0F172A))),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: formulaBox('Captain Net (صافي)', '90.0%', 'حق الكابتن المباشر', Color(0xFFDCFCE7), Color(0xFF16A34A)),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('مديونية عمولة الكاش', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFFF59E0B))),
                            SizedBox(height: 4),
                            Text('تحملها سِكّة من الكابتن بعد استلامه المبلغ كاش', style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget statCard({
    required String title,
    required Widget icon,
    required Color color,
    required Color valueColor,
    required String value,
    required String unit,
    required String arabic,
    required String bottomLeft,
    required String bottomRight,
  }) {
    return card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(title, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
              ),
              icon,
            ],
          ),
          SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(value, style: GoogleFonts.inter(fontSize: 40, fontWeight: FontWeight.bold, color: valueColor)),
                if (unit.isNotEmpty) ...[
                  SizedBox(width: 4),
                  Padding(
                    padding: EdgeInsets.only(bottom: 6),
                    child: Text(unit, style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF64748B))),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 4),
          Text(arabic, style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B))),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(bottomLeft, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF16A34A))),
              ),
              Flexible(
                child: Text(bottomRight, textAlign: TextAlign.end, style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF64748B))),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget statsRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: statCard(
            title: 'GROSS RIDE VOLUME',
            icon: SvgPicture.asset('assets/icons/route.svg', width: 16.5, height: 16.5),
            color: Color(0xFF4338CA),
            valueColor: Color(0xFF0F172A),
            value: '486,500',
            unit: '',
            arabic: 'إجمالي قيمة المشاوير المنفذة',
            bottomLeft: '+14.8% vs Last Month',
            bottomRight: '',
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: statCard(
            title: 'SIKKA 10% COMMISSION',
            icon: Icon(Icons.percent, color: Color(0xFF4338CA), size: 22),
            color: Color(0xFF4338CA),
            valueColor: Color(0xFF4338CA),
            value: '48,650',
            unit: 'EGP',
            arabic: 'إيرادات عمولة سِكّة الثابتة',
            bottomLeft: '100% Calculated',
            bottomRight: 'Zero variance',
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: statCard(
            title: 'CAPTAIN NET PAYOUTS (90%)',
            icon: Icon(Icons.account_balance, color: Color(0xFF16A34A), size: 22),
            color: Color(0xFF16A34A),
            valueColor: Color(0xFF0F172A),
            value: '437,850',
            unit: '',
            arabic: 'صافي أرباح ومستحقات الكباتن',
            bottomLeft: '89.4% Disbursed',
            bottomRight: 'Fawry/InstaPay',
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: statCard(
            title: 'OUTSTANDING CASH DEBT',
            icon: SvgPicture.asset('assets/icons/outstanding.svg', width: 14.25, height: 15.75),
            color: Color(0xFFF59E0B),
            valueColor: Color(0xFFF59E0B),
            value: '12,420',
            unit: 'EGP',
            arabic: 'عمولات كاش مستحقة التحصيل',
            bottomLeft: '14 Captains flagged',
            bottomRight: 'Overdue',
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: statCard(
            title: 'SETTLED THIS WEEK',
            icon: SvgPicture.asset('assets/icons/checkmark.svg', width: 18.33, height: 18.33),
            color: Color(0xFF16A34A),
            valueColor: Color(0xFF16A34A),
            value: '36,230',
            unit: 'EGP',
            arabic: 'المبالغ المحصلة هذا الأسبوع',
            bottomLeft: '74.5% Collected',
            bottomRight: 'Target: 95%',
          ),
        ),
      ],
    );
  }

  Widget weeklyCard() {
    return card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Weekly Settlement\nVelocity', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                    Text('مؤشر سرعة استيفاء عمولات الكاش', style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B))),
                  ],
                ),
              ),
              pill('Healthy\n(74.5%)', Color(0xFFDCFCE7), Color(0xFF16A34A)),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 110,
                height: 110,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 110,
                      height: 110,
                      child: CircularProgressIndicator(
                        value: 0.745,
                        strokeWidth: 10,
                        backgroundColor: Color(0xFFE0E7FF),
                        color: Color(0xFF4338CA),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('74.5%', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                        Text('Settled', style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF64748B))),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Cash\nInvoiced', style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF64748B))),
                        Text('48,650\nEGP', textAlign: TextAlign.end, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                      ],
                    ),
                    SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: 0.745,
                        minHeight: 8,
                        backgroundColor: Color(0xFFE0E7FF),
                        color: Color(0xFF4338CA),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('36,230\nEGP Paid', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF16A34A))),
                        Text('12,420\nEGP Due', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFFF59E0B))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time, size: 18, color: Color(0xFF64748B)),
                SizedBox(width: 8),
                Expanded(
                  child: Text('Next Auto-Freeze Trigger:\nThursday 23:59', style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF0F172A))),
                ),
                Text('Policy\nRules', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF4338CA))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget flowItem(String label, String amount, double value, Color color, Widget icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14),
      child: Column(
        children: [
          Row(
            children: [
              icon,
              SizedBox(width: 8),
              Expanded(
                child: Text(label, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
              ),
              Text(amount, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
            ],
          ),
          SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 8,
              backgroundColor: Color(0xFFE2E8F0),
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget paymentFlowCard() {
    return card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Payment Flow Ingress', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              Text('October 2024', style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF64748B))),
            ],
          ),
          Text('طرق تحصيل رحلات الركاب', style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B))),
          SizedBox(height: 16),
          flowItem('Direct Cash to Captain (كاش للكابتن)', '316,225 EGP (65%)', 0.65, Color(0xFF4338CA), SvgPicture.asset('assets/icons/money.svg', width: 14.67, height: 10.67, colorFilter: ColorFilter.mode(Color(0xFF64748B), BlendMode.srcIn))),
          flowItem('Fawry / Digital Wallets (محافظ إلكترونية)', '121,625 EGP (25%)', 0.25, Color(0xFF4338CA), Icon(Icons.credit_card, size: 18, color: Color(0xFF64748B))),
          flowItem('InstaPay & Bank Cards (إنستاباي / فيزا)', '48,650 EGP (10%)', 0.10, Color(0xFF16A34A), Icon(Icons.currency_exchange, size: 18, color: Color(0xFF64748B))),
          SizedBox(height: 4),
          Row(
            children: [
              SvgPicture.asset('assets/icons/shield_outlined.svg', width: 10.67, height: 13.33, ),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  'All digital payments automatically allocate 10% directly into SIKKA Escrow.',
                  style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget criticalCard(BuildContext context, DashboardCubit cubit) {
    return card(
      color: Color(0xFFF8FAFC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.circle, size: 10, color: Color(0xFFDC2626)),
              SizedBox(width: 6),
              Text('Critical Action Needed', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFFDC2626))),
              Spacer(),
              Text('إشعارات الحظر المالي', style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B))),
            ],
          ),
          SizedBox(height: 10),
          Text('5 Captains Over Grace\nThreshold', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          SizedBox(height: 8),
          Text(
            'تم تجاوز الحد الائتماني لعمولة الكاش (أكثر من 800 ج.م أو تأخر أسبوعين). تم إيقاف استقبال طلبات الرحلات آليًا لحين تسوية المديونية.',
            style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF64748B)),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => cubit.clickSendSms(context),
                  icon: Icon(Icons.sms_outlined, size: 16),
                  label: Text('Send SMS Payment Links'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFDC2626),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => cubit.clickReviewBlockList(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Color(0xFF0F172A),
                    padding: EdgeInsets.symmetric(vertical: 18),
                    side: BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  child: Text('Review Block List'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget middleCardsRow(BuildContext context, DashboardCubit cubit) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: weeklyCard()),
        const SizedBox(width: 20),
        Expanded(child: paymentFlowCard()),
        const SizedBox(width: 20),
        Expanded(child: criticalCard(context, cubit)),
      ],
    );
  }

  Widget filterChip(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      margin: EdgeInsets.only(left: 8),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF0F172A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: selected ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0)),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: selected ? Colors.white : const Color(0xFF64748B),
        ),
      ),
    ),
    );
  }

  Widget debtorRow(Map<String, dynamic> d, BuildContext context, DashboardCubit cubit) {
    final bool isLate = d['isLate'] == true;

    Widget statusWidget;
    if (d['status'] == 'Suspended') {
      statusWidget = pill('(Suspended)', Color(0xFFFEE2E2), Color(0xFFDC2626));
    } else if (d['status'] == 'Warning') {
      statusWidget = pill('(Warning)', Color(0xFFFEF3C7), Color(0xFFF59E0B));
    } else {
      statusWidget = pill('(Active)', Color(0xFFDCFCE7), Color(0xFF16A34A));
    }

    String actionText = 'Auto-Debit';
    if (isLate) {
      actionText = 'Reconcile';
    } else if (d['status'] == 'Warning') {
      actionText = 'Remind SMS';
    }

    return Container(
      color: isLate ? Color(0xFFFEF2F2) : Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Color(0xFFE0E7FF),
                  child: Text(
                    d['name'].substring(0, 1),
                    style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4338CA)),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(d['name'], style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                      Text(d['phone'], style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Color(0xFFE2E8F0)),
                  ),
                  child: Text(d['plate'], style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                ),
                SizedBox(width: 6),
                Expanded(
                  child: Text(d['car'], style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF64748B))),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text("${d['trips']}\nrides", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          ),
          Expanded(
            flex: 2,
            child: Text("${d['gross']}\nEGP", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "${d['debt']}\nEGP",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isLate ? Color(0xFFDC2626) : Color(0xFFF59E0B),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              d['deadline'],
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isLate ? Color(0xFFDC2626) : Color(0xFF0F172A),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(alignment: Alignment.centerLeft, child: statusWidget),
          ),
          Expanded(
            flex: 4,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => cubit.clickDebtorAction(context, d['name'] as String, 'Statement'),
                    child: smallButton('Statement'),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => cubit.clickDebtorAction(context, d['name'] as String, actionText),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: isLate ? const Color(0xFF4338CA) : const Color(0xFFE0E7FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        actionText,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isLate ? Colors.white : const Color(0xFF4338CA),
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

  Widget debtorsTable(BuildContext context, DashboardState state, DashboardCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.warning_amber_rounded, color: Color(0xFFF59E0B)),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Captain Outstanding Balances & Suspension Risk', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                Text('مديونيات عمولة الكاش ومخاطر إيقاف الحسابات المؤقت', style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF64748B))),
              ],
            ),
            const Spacer(),
            filterChip('All Debtors (14)', state.debtorFilterIndex == 0, () => cubit.changeDebtorFilter(0)),
            filterChip('Overdue Only (5)', state.debtorFilterIndex == 1, () => cubit.changeDebtorFilter(1)),
            filterChip('Near Threshold (9)', state.debtorFilterIndex == 2, () => cubit.changeDebtorFilter(2)),
          ],
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0xFFE2E8F0)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                color: Color(0xFFF1F5F9),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    headerCell(3, 'CAPTAIN & CONTACT'),
                    headerCell(2, 'VEHICLE (PLATE)'),
                    headerCell(1, 'TOTAL TRIPS'),
                    headerCell(2, 'GROSS CASH COLLECTED'),
                    headerCell(2, 'SIKKA 10% DEBT'),
                    headerCell(2, 'SETTLEMENT DEADLINE'),
                    headerCell(2, 'ACCOUNT STATUS'),
                    headerCell(4, 'ACTIONS'),
                  ],
                ),
              ),
              for (final d in _getFilteredDebtors(state.debtorFilterIndex)) debtorRow(d, context, cubit),
              Container(
                color: Color(0xFFF8FAFC),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Showing 4 of 14 captains with outstanding balance across Greater Cairo corridors',
                      style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF64748B)),
                    ),
                    Row(
                      children: [
                        smallButton('Previous'),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('1', style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF0F172A))),
                        ),
                        smallButton('Next'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget dropdownBox(String text) {
    return Container(
      width: 200,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(Icons.filter_list, size: 16, color: Color(0xFF64748B)),
          SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF0F172A)),
            ),
          ),
        ],
      ),
    );
  }

  Widget transactionRow(Map<String, dynamic> t) {
    Widget modePill;
    if (t['mode'] == 'cash') {
      modePill = pill('Cash directly to Captain', Color(0xFFEDE9FE), Color(0xFF6D28D9));
    } else if (t['mode'] == 'electronic') {
      modePill = pill('Electronic / Fawry Pay', Color(0xFFE0E7FF), Color(0xFF4338CA));
    } else {
      modePill = pill('InstaPay Transfer', Color(0xFFDCFCE7), Color(0xFF16A34A));
    }

    Widget statusPill;
    if (t['status'] == 'pending') {
      statusPill = pill('(Pending Collection)', Color(0xFFFEF3C7), Color(0xFFF59E0B));
    } else if (t['status'] == 'settled') {
      statusPill = pill('(Auto Settled)', Color(0xFFDCFCE7), Color(0xFF16A34A));
    } else {
      statusPill = pill('(Fawry Reconciled)', Color(0xFFDCFCE7), Color(0xFF16A34A));
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 22),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(t['id'], style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          ),
          Expanded(
            flex: 2,
            child: Text(t['time'], style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF64748B))),
          ),
          Expanded(
            flex: 3,
            child: Text(t['ride'], style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF64748B))),
          ),
          Expanded(
            flex: 2,
            child: Text(t['captain'], style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
          ),
          Expanded(
            flex: 2,
            child: Align(alignment: Alignment.centerLeft, child: modePill),
          ),
          Expanded(
            flex: 2,
            child: Text("${t['gross']}\nEGP", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          ),
          Expanded(
            flex: 2,
            child: Text("${t['fee']}\nEGP", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF4338CA))),
          ),
          Expanded(
            flex: 2,
            child: Text("${t['net']}\nEGP", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF16A34A))),
          ),
          Expanded(
            flex: 2,
            child: Align(alignment: Alignment.centerLeft, child: statusPill),
          ),
        ],
      ),
    );
  }

  Widget transactionsTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFE0E7FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.receipt_long, color: Color(0xFF4338CA)),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Platform Financial Transactions Ledger', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                Text('سجل العمليات التفصيلي وتوزيع حصص الـ 90% والـ 10%', style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF64748B))),
              ],
            ),
            Spacer(),
            dropdownBox('All Payment Modes (الكل)'),
            SizedBox(width: 10),
            dropdownBox('All Statuses (حالة التسوية)'),
            SizedBox(width: 10),
            OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.refresh, size: 18),
              label: Text('Refresh Log'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Color(0xFF0F172A),
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                side: BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0xFFE2E8F0)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                color: Color(0xFFF1F5F9),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    headerCell(2, 'TRANSACTION ID'),
                    headerCell(2, 'TIMESTAMP'),
                    headerCell(3, 'RIDE ID & CORRIDOR'),
                    headerCell(2, 'CAPTAIN'),
                    headerCell(2, 'PAYMENT MODE'),
                    headerCell(2, 'GROSS FARE'),
                    headerCell(2, 'SIKKA 10% FEE'),
                    headerCell(2, 'NET PAYOUT (90%)'),
                    headerCell(2, 'AUDIT STATUS'),
                  ],
                ),
              ),
              for (final t in transactions) transactionRow(t),
              Container(
                color: Color(0xFFF8FAFC),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Showing 5 of 2,491 ledger entries • Continuous Zero-Leakage Audit Enabled',
                      style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF64748B)),
                    ),
                    Row(
                      children: [
                        smallButton('Prev'),
                        SizedBox(width: 10),
                        Text('1', style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF0F172A))),
                        SizedBox(width: 10),
                        smallButton('2'),
                        SizedBox(width: 6),
                        smallButton('3'),
                        SizedBox(width: 6),
                        Text('...', style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF0F172A))),
                        SizedBox(width: 6),
                        smallButton('498'),
                        SizedBox(width: 6),
                        smallButton('Next'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}