import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidebarx/sidebarx.dart';
import '../logic/dashboard_cubit.dart';
import '../logic/dashboard_state.dart';
import 'package:flutter_svg/svg.dart';


class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(initialNavIndex: 3),
      child: const _VerificationScreenView(),
    );
  }
}

class _VerificationScreenView extends StatefulWidget {
  const _VerificationScreenView();

  @override
  State<_VerificationScreenView> createState() => _VerificationScreenViewState();
}

class _VerificationScreenViewState extends State<_VerificationScreenView> {
  late final SidebarXController sidebarController;

  @override
  void initState() {
    super.initState();
    sidebarController = SidebarXController(
      selectedIndex: 3,
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
    {'icon': SvgPicture.asset('assets/icons/finance.svg', colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn)), 'label': 'Finance'},
    {'icon': SvgPicture.asset('assets/icons/reports.svg'), 'label': 'Reports'},
    {'icon': SvgPicture.asset('assets/icons/settings.svg'), 'label': 'Settings'},
  ];

  final List<Map<String, dynamic>> applicants = [
    {'name': 'عمر خالد الشناوي', 'phone': '+20 109 458 3921', 'time': '12m ago', 'isNew': true, 'car': 'هيونداي إلنترا CN7', 'carInfo': 'رمادي ميتاليك • موديل 2022', 'plate': 'أ ب ج // ٩٢٥٤', 'note': 'الهوية والفيش مطابق', 'noteType': 'ok', 'rightText': 'Ready to decide →', 'selected': true},
    {'name': 'شريف مصطفى الباز', 'phone': '+20 114 883 2019', 'time': '34m ago', 'isNew': false, 'car': 'كيا سيراتو فيس ليفت', 'carInfo': 'أبيض لؤلؤي • موديل 2021', 'plate': 'س ر د // ٤١٨٢', 'note': 'الرخصة بحاجة لفحص فني', 'noteType': 'warn', 'rightText': '4 مستندات', 'selected': false},
    {'name': 'رانيا أحمد عبد الله', 'phone': '+20 122 931 7701', 'time': '1h ago', 'isNew': false, 'car': 'تويوتا كورولا هجين', 'carInfo': 'فضي • موديل 2023', 'plate': 'م ن و // ٧٥١٩', 'note': 'تم التحقق الأمني', 'noteType': 'ok', 'rightText': 'سكة سيدان مُوفِر', 'selected': false},
    {'name': 'كريم محمود حجازي', 'phone': '+20 100 522 8410', 'time': '2h ago', 'isNew': false, 'car': 'نيسان صني', 'carInfo': 'أسود • موديل 2022', 'plate': 'ق ط ف // ٦٣٨١', 'note': 'مستند فحص الغاز مرفق', 'noteType': 'info', 'rightText': 'معتمد كود 04', 'selected': false},
    {'name': 'ياسر عبد الفتاح الشيمي', 'phone': '+20 111 639 0048', 'time': '3h ago', 'isNew': false, 'car': 'Super Saloon', 'carInfo': 'رمادي • موديل 2020', 'plate': 'د ن س // ٢٠٩٤', 'note': 'جاري فحص المستندات', 'noteType': 'info', 'rightText': '4 مستندات', 'selected': false},
  ];

  final List<Map<String, String>> checklist = [
    {'ar': 'أحزمة أمان كاملة', 'en': 'Seatbelts Operational'},
    {'ar': 'تكييف هواء ممتاز', 'en': 'AC Verified Functional'},
    {'ar': 'سنة الصنع حديثة', 'en': '2022 (Model > 2016)'},
    {'ar': 'مطابقة رقم الشاسيه', 'en': 'VIN Match Verified'},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final cubit = context.read<DashboardCubit>();
        final currentApplicant = applicants[state.selectedApplicantIndex.clamp(0, applicants.length - 1)];

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
                                statsRow(),
                                const SizedBox(height: 24),
                                headerCard(context, state, cubit),
                                const SizedBox(height: 24),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(flex: 4, child: applicantQueue(context, state, cubit)),
                                    const SizedBox(width: 24),
                                    Expanded(
                                      flex: 6,
                                      child: Column(
                                        children: [
                                          profileCard(currentApplicant),
                                          const SizedBox(height: 24),
                                          inspectionMatrix(),
                                          const SizedBox(height: 24),
                                          checklistCard(),
                                          const SizedBox(height: 24),
                                          decisionCard(context, currentApplicant, cubit),
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

  Widget imageBox(String label, {double height = 140, bool showEye = true}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Color(0xFF475569),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Center(child: Icon(Icons.image_outlined, color: Colors.white54, size: 36)),
          Positioned(
            left: 8,
            bottom: 8,
            child: Text(label, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
          ),
          if (showEye)
            Positioned(
              right: 8,
              bottom: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.visibility_outlined, color: Colors.white, size: 16),
              ),
            ),
        ],
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
            iconBuilder: (selected, hovered) => menuItems[i]['icon'] is Widget ? (menuItems[i]['icon'] as Widget) : const SizedBox(),
            label: menuItems[i]['label'] as String?,
            onTap: () => cubit.changeNavIndex(context, i),
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

  Widget statCard({
    required String title,
    required String value,
    required String bottomLeft,
    required Color bottomLeftColor,
    required double progress,
    required Color progressColor,
    Widget? badge,
    Widget? rightIcon,
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
              ?badge,
              ?rightIcon,
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    style: GoogleFonts.inter(fontSize: 38, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    bottomLeft,
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: bottomLeftColor),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Color(0xFFE2E8F0),
              color: progressColor,
            ),
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
            title: 'AWAITING VERIFICATION',
            value: '28',
            bottomLeft: '~ 18 min SLA',
            bottomLeftColor: Color(0xFFF59E0B),
            progress: 0.4,
            progressColor: Color(0xFF4338CA),
            badge: pill('● Urgent', Color(0xFFFEF3C7), Color(0xFFF59E0B)),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: statCard(
            title: 'DAILY THROUGHPUT',
            value: '114',
            bottomLeft: '+18.4% vs yesterday',
            bottomLeftColor: Color(0xFF16A34A),
            progress: 0.75,
            progressColor: Color(0xFF16A34A),
            rightIcon: SizedBox(
              width: 16.5,
              height: 15.75,
              child: SvgPicture.asset('assets/icons/correct.svg'),
            )
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: statCard(
            title: 'ACTIVE FLEET SIZE',
            value: '2,890',
            bottomLeft: 'القاهرة والجيزة الكبرى',
            bottomLeftColor: Color(0xFF64748B),
            progress: 0.9,
            progressColor: Color(0xFF4338CA),
            rightIcon: Icon(Icons.directions_car_outlined, color: Color(0xFF4338CA), size: 22),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: statCard(
            title: 'REJECTION RATE',
            value: '4.8%',
            bottomLeft: '142 مرفوض',
            bottomLeftColor: Color(0xFFDC2626),
            progress: 0.12,
            progressColor: Color(0xFFDC2626),
            rightIcon: SizedBox(
              width: 12,
              height: 15,
            child: SvgPicture.asset('assets/icons/shield.svg'),
            )
          ),
        ),
      ],
    );
  }

  Widget tab(String en, String count, String ar, bool selected, Color countBg, Color countFg, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      margin: EdgeInsets.only(right: 4),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: selected ? Color(0xFFE2E8F0) : Colors.transparent),
      ),
      child: Row(
        children: [
          Text(
            en,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: selected ? Color(0xFF4338CA) : Color(0xFF64748B),
            ),
          ),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: countBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(count, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: countFg)),
          ),
          SizedBox(width: 8),
          Text(ar, style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B))),
        ],
      ),
    ),
    );
  }

  Widget headerCard(BuildContext context, DashboardState state, DashboardCubit cubit) {
    return card(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        pill('PORTAL VERIFICATION', Color(0xFFE0E7FF), Color(0xFF4338CA)),
                        SizedBox(width: 10),
                        Text('نظام التدقيق الرقمي المباشر', style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF64748B))),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Captain Verification\nQueue',
                          style: GoogleFonts.inter(fontSize: 34, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                        ),
                        SizedBox(width: 16),
                        Text('مراجعة وتوثيق | الكباتن', style: GoogleFonts.inter(fontSize: 18, color: Color(0xFF64748B))),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'بحث بالاسم، الهاتف، أو اللوحة...',
                              hintStyle: GoogleFonts.inter(fontSize: 13, color: Color(0xFF64748B)),
                              prefixIcon: Icon(Icons.search, color: Color(0xFF64748B)),
                              filled: true,
                              fillColor: Color(0xFFF1F5F9),
                              contentPadding: EdgeInsets.symmetric(vertical: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('All Vehicles (كل الطرازات)', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.calendar_today_outlined, size: 18, color: Color(0xFF0F172A)),
                            SizedBox(width: 8),
                            Text('Today (اليوم)', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    tab('Pending Review', '28', 'قيد المراجعة', state.verificationTab == 0, Color(0xFF4338CA), Colors.white, () => cubit.changeVerificationTab(0)),
                    tab('Approved Fleet', '2,890', 'معتمد', state.verificationTab == 1, Colors.transparent, Color(0xFF16A34A), () => cubit.changeVerificationTab(1)),
                    tab('Rejected', '142', 'مرفوض', state.verificationTab == 2, Colors.transparent, Color(0xFFDC2626), () => cubit.changeVerificationTab(2)),
                  ],
                ),
              ),
              Spacer(),
              Icon(Icons.circle, size: 10, color: Color(0xFF16A34A)),
              SizedBox(width: 6),
              Text('Live Auto-Syncing Queue', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
            ],
          ),
        ],
      ),
    );
  }

  Widget applicantItem(Map<String, dynamic> a, bool selected) {

    Widget noteIcon = SvgPicture.asset('assets/icons/info.svg', width: 13.33, height: 13.33,);
    if (a['noteType'] == 'ok') {
      noteIcon = SvgPicture.asset('assets/icons/verified_user.svg', width: 10.67, height: 13.33);
    } else if (a['noteType'] == 'warn') {
      noteIcon = SvgPicture.asset('assets/icons/warning.svg', width: 14.67, height: 12.67);
    }

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: selected ? Color(0xFFE0E7FF) : Colors.white,
        borderRadius: BorderRadius.circular(12),

      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (selected)
            Positioned(
              left: -14,
              top: -10,
              bottom: -10,
              child: Container(
                width: 4,
                decoration: BoxDecoration(
                  color: Color(0xFF4338CA),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Color(0xFFCBD5E1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.person, color: Colors.white, size: 30),
                      ),
                      Positioned(
                        right: -4,
                        bottom: -4,
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Color(0xFFF59E0B),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(Icons.hourglass_bottom, size: 9, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(a['name'], style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                            ),
                            if (a['isNew'] == true) ...[
                              SizedBox(width: 6),
                              pill('New', Colors.white, Color(0xFF4338CA)),
                            ],
                          ],
                        ),
                        Text(a['phone'], style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF64748B))),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: selected ? Colors.white : Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(a['time'], style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: selected ? Colors.white : Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a['car'], style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                          Text(a['carInfo'], style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B))),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Color(0xFFE0E7FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(a['plate'], style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF4338CA))),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  noteIcon,
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(a['note'], style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600)),
                  ),
                  Text(
                    a['rightText'],
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                      color: selected ? Color(0xFF4338CA) : Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget applicantQueue(BuildContext context, DashboardState state, DashboardCubit cubit) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Row(
              children: [
                const Icon(Icons.library_add_outlined, color: Color(0xFF4338CA), size: 22),
                const SizedBox(width: 8),
                Text('Applicant Queue', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                const SizedBox(width: 8),
                Expanded(
                  child: Text('طابور الفحص', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B))),
                ),
                Text('Showing 5 of 28', style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                for (int i = 0; i < applicants.length; i++)
                  GestureDetector(
                    onTap: () => cubit.selectApplicant(i),
                    child: applicantItem(applicants[i], i == state.selectedApplicantIndex),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profileCard(Map<String, dynamic> currentApplicant) {
    return card(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 50),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(currentApplicant['name'] as String, style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                        SizedBox(width: 10),
                        pill('Face Match Verified', Color(0xFFDCFCE7), Color(0xFF16A34A)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'الرقم القومي: 29208150104938   •   المحافظة: الجيزة (الشيخ زايد)',
                      style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF64748B)),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'تاريخ التقديم: اليوم 10:42 AM',
                      style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('مستوى التوافق\nالأمني', textAlign: TextAlign.end, style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B))),
                  SizedBox(height: 6),
                  pill('98.5%', Color(0xFFDCFCE7), Color(0xFF16A34A)),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/bus.svg', width: 15, height: 12,),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'مسار التنقل الأساسي: زايد / أكتوبر ← التجمع الخامس (شارع التسعين)',
                    style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
                  ),
                ),
                Text('معدل المقاعد: 3 مقاعد', style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget docCard({
    required String titleAr,
    required String titleEn,
    required IconData icon,
    Widget? iconWidget,
    required String pillText,
    required Color pillBg,
    required Color pillFg,
    required Widget body,
    required String footerLeft,
    required String footerRight,
    required Color footerRightColor,
  }) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFFE2E8F0)),
                ),
                child: iconWidget ?? Icon(icon, size: 20, color: Color(0xFF4338CA)),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titleAr, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                    Text(titleEn, style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B))),
                  ],
                ),
              ),
              pill(pillText, pillBg, pillFg),
            ],
          ),
          SizedBox(height: 12),
          body,
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(footerLeft, style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B))),
              ),
              SizedBox(width: 8),
              Flexible(
                child: Text(footerRight, textAlign: TextAlign.end, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: footerRightColor)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget inspectionMatrix() {
    return card(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.fact_check_outlined, color: Color(0xFF4338CA), size: 22),
              SizedBox(width: 8),
              Text('Document Inspection Matrix', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              SizedBox(width: 8),
              Expanded(
                child: Text('(المستندات الأربعة المطلوبة)', style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B))),
              ),
              Icon(Icons.check_circle_outline, size: 18, color: Color(0xFF16A34A)),
              SizedBox(width: 4),
              Text('4 / 4 Verified', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF16A34A))),
            ],
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: docCard(
                  titleAr: 'بطاقة الرقم القومي (الوجهين)',
                  titleEn: 'Egyptian National ID',
                  icon: Icons.badge_outlined,
                  pillText: 'مطابق وموثوق ✓',
                  pillBg: Color(0xFFDCFCE7),
                  pillFg: Color(0xFF16A34A),
                  body: imageBox('سارية حتى 2031'),
                  footerLeft: 'تطابق الاسم الرباعي: 100%',
                  footerRight: 'فيش جنائي: خالٍ من السوابق',
                  footerRightColor: Color(0xFF16A34A),
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: docCard(
                  titleAr: 'رخصة القيادة الشخصية',
                  titleEn: 'Personal Driver License',
                  icon: Icons.directions_car_outlined,
                  pillText: 'مطابق ✓',
                  pillBg: Color(0xFFDCFCE7),
                  pillFg: Color(0xFF16A34A),
                  body: imageBox('سارية حتى 2026/09'),
                  footerLeft: 'درجة ثالثة خاصة',
                  footerRight: 'وحدة مرور: 6 أكتوبر',
                  footerRightColor: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: docCard(
                  titleAr: 'رخصة تسيير المركبة والفحص',
                  titleEn: 'Vehicle Registration Card',
                  icon: Icons.description_outlined,
                  iconWidget: SvgPicture.asset('assets/icons/description.svg', width: 20, height: 20, colorFilter: ColorFilter.mode(Color(0xFF4338CA), BlendMode.srcIn)),
                  pillText: 'مطابق ✓',
                  pillBg: Color(0xFFDCFCE7),
                  pillFg: Color(0xFF16A34A),
                  body: imageBox('رقم الشاسيه مطابق'),
                  footerLeft: 'المالك المباشر: نعم',
                  footerRight: 'تاريخ الفحص: 2024',
                  footerRightColor: Color(0xFF64748B),
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: docCard(
                  titleAr: 'فحص صور السيارة واللوحات',
                  titleEn: 'Vehicle & Plate Angles',
                  icon: Icons.photo_camera_outlined,
                  pillText: '4 صور',
                  pillBg: Color(0xFF4338CA),
                  pillFg: Colors.white,
                  body: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: imageBox('أمامي', height: 62, showEye: false)),
                          SizedBox(width: 6),
                          Expanded(child: imageBox('خلفي', height: 62, showEye: false)),
                        ],
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(child: imageBox('الصالون', height: 62, showEye: false)),
                          SizedBox(width: 6),
                          Expanded(child: imageBox('اللوحة', height: 62, showEye: false)),
                        ],
                      ),
                    ],
                  ),
                  footerLeft: 'حالة الصالون: ممتاز (Clean)',
                  footerRight: 'مطابقة اللوحات ✓',
                  footerRightColor: Color(0xFF16A34A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget checklistCard() {
    return card(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.checklist, color: Color(0xFF16A34A), size: 22),
              SizedBox(width: 8),
              Text('Vehicle Safety & Quality Checklist', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              SizedBox(width: 8),
              Expanded(
                child: Text('(معايير السلامة والجودة)', style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B))),
              ),
              Text('4 من 4 معايير معتمدة', style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B))),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              for (int i = 0; i < checklist.length; i++) ...[
                if (i > 0) SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: Color(0xFF2563EB),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(Icons.check, size: 13, color: Colors.white),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(checklist[i]['ar']!, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                              Text(checklist[i]['en']!, style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget decisionCard(BuildContext context, Map<String, dynamic> currentApplicant, DashboardCubit cubit) {
    final captainName = currentApplicant['name'] as String;

    return card(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Operations Verification\nDecision', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                    const SizedBox(height: 6),
                    Text('اتخاذ قرار الفحص الفوري لنظام الرحلات التشاركية المباشر', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B))),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () => cubit.rejectCaptain(context, captainName),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE2E2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.cancel_outlined, color: Color(0xFFDC2626), size: 20),
                        const SizedBox(width: 8),
                        Text('رفض الطلب\n(Reject)', textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFFDC2626))),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 4,
                child: GestureDetector(
                  onTap: () => cubit.approveCaptain(context, captainName),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4338CA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.verified_outlined, color: Colors.white, size: 22),
                        const SizedBox(width: 8),
                        Text('اعتماد الكابتن وتفعيل\nالحساب (Approve)', textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.fact_check_outlined, size: 18, color: Color(0xFF4338CA)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Reviewed by Operations Team with zero automation overrides.',
                    style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF64748B)),
                  ),
                ),
                Text('Admin ID: TM-9042', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                SizedBox(width: 10),
                Icon(Icons.circle, size: 6, color: Color(0xFF16A34A)),
                SizedBox(width: 4),
                Text('Cairo Ops Server Sync', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF16A34A))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}