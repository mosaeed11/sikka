import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/route_spine_widget.dart';

enum NotificationFilter {
  all,
  rides,
  finance,
  system,
}

class SikkaNotificationItem {
  final String id;
  final String title;
  final String message;
  final String timeAgo;
  final NotificationFilter category;
  bool isRead;
  final String? routeOrigin;
  final String? routeDestination;
  final String? ctaLabel;
  final String? ctaRoute;
  final bool isJoinRequest;

  SikkaNotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.category,
    this.isRead = false,
    this.routeOrigin,
    this.routeDestination,
    this.ctaLabel,
    this.ctaRoute,
    this.isJoinRequest = false,
  });
}

/// Screen 11: Notifications Feed
/// Matching Figma Frame `21:4207` (Header `21:4210`, Filters `21:4223`, Stream `21:4239`)
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  NotificationFilter _selectedFilter = NotificationFilter.all;

  late List<SikkaNotificationItem> _notifications;

  @override
  void initState() {
    super.initState();
    // 4 Distinct Notification Items matching Figma Node 21:4239
    _notifications = [
      // Item 1: Matching Ride Convergence (Unread/Actionable, Node 21:4240)
      SikkaNotificationItem(
        id: 'NOTIF-1',
        title: 'رحلة متوافقة مع مسارك اليوم!',
        message:
            'كابتن أحمد يتحرك بعد ٢٠ دقيقة من المعادي إلى التجمع الخامس ولديه مقعدين شاغرين.',
        timeAgo: 'منذ ١٠ دقائق',
        category: NotificationFilter.rides,
        isRead: false,
        routeOrigin: 'المعادي، شارع النصر',
        routeDestination: 'التجمع الخامس، التسعين الشمالي',
        ctaLabel: 'عرض تفاصيل الرحلة والدفع',
        ctaRoute: '/payment-method',
      ),
      // Item 2: Captain Request (Unread/Actionable, Node 21:4283)
      SikkaNotificationItem(
        id: 'NOTIF-2',
        title: 'طلب انضمام جديد لرحلتك!',
        message:
            'عمر ومحمد طلبا حجز مقعدين في رحلتك القادمة غداً إلى القرية الذكية.',
        timeAgo: 'منذ نصف ساعة',
        category: NotificationFilter.rides,
        isRead: false,
        isJoinRequest: true,
      ),
      // Item 3: Financial Receipt (Read, Node 21:4327)
      SikkaNotificationItem(
        id: 'NOTIF-3',
        title: 'إيصال مشوار تم تسجيله واعتماده',
        message:
            'تم تسجيل استلام ٧٠ ج.م نقداً من رحلتك الأخيرة، وتم خصم ١٠٪ عمولة سِكّة (٧ ج.م) بنجاح.',
        timeAgo: 'منذ ساعتين',
        category: NotificationFilter.finance,
        isRead: true,
        ctaLabel: 'عرض الإيصال الرقمي',
        ctaRoute: '/ride-receipt',
      ),
      // Item 4: Captain Verification Approved (Read, Node 21:4353)
      SikkaNotificationItem(
        id: 'NOTIF-4',
        title: 'تهانينا! تم توثيق حساب الكابتن بنجاح',
        message:
            'تمت مراجعة رخصة القيادة والسيارة والفيش. يمكنك الآن إنشاء أول رحلة ككابتن ومشاركة مقاعدك.',
        timeAgo: 'أمس',
        category: NotificationFilter.system,
        isRead: true,
        ctaLabel: 'عرض حالة التوثيق',
        ctaRoute: '/verification',
      ),
    ];
  }

  void _markAllAsRead() {
    setState(() {
      for (final n in _notifications) {
        n.isRead = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم تحديد جميع الإشعارات كمقروءة.'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  List<SikkaNotificationItem> get _filteredNotifications {
    if (_selectedFilter == NotificationFilter.all) return _notifications;
    return _notifications
        .where((n) => n.category == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.surfaceSoft,
        appBar: AppBar(
          backgroundColor: AppColors.surfaceDefault,
          elevation: 0,
          title: const Text(
            'الإشعارات والتنبيهات',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
            onPressed: () => context.pop(),
          ),
          actions: [
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text(
                'تحديد الكل كمقروء',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brandIndigo,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Segmented Scrollable Filter Pills (Figma Node 21:4223)
              Container(
                color: AppColors.surfaceDefault,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s16,
                  vertical: AppSpacing.s10,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('الكل', NotificationFilter.all),
                      const SizedBox(width: 8),
                      _buildFilterChip('رحلات', NotificationFilter.rides),
                      const SizedBox(width: 8),
                      _buildFilterChip('المالية', NotificationFilter.finance),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                          'تنبيهات الحساب', NotificationFilter.system),
                    ],
                  ),
                ),
              ),

              const Divider(height: 1, color: AppColors.border),

              // Notifications Stream List (Node 21:4239)
              Expanded(
                child: _filteredNotifications.isEmpty
                    ? const Center(
                        child: Text(
                          'لا توجد إشعارات في هذا القسم.',
                          style: TextStyle(color: AppColors.textMuted),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(AppSpacing.s16),
                        itemCount: _filteredNotifications.length,
                        itemBuilder: (context, index) {
                          final item = _filteredNotifications[index];
                          return _buildNotificationCard(item);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, NotificationFilter filter) {
    final isSelected = _selectedFilter == filter;

    return InkWell(
      onTap: () => setState(() => _selectedFilter = filter),
      borderRadius: AppRadius.radiusFull,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.brandIndigo
              : AppColors.surfaceMuted,
          borderRadius: AppRadius.radiusFull,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard(SikkaNotificationItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.s12),
      padding: const EdgeInsets.all(AppSpacing.s14),
      decoration: BoxDecoration(
        color: item.isRead
            ? AppColors.surfaceDefault
            : const Color(0xFFF8FAFC),
        borderRadius: AppRadius.radiusLg,
        border: Border.all(
          color: item.isRead
              ? AppColors.border
              : AppColors.brandIndigo.withValues(alpha: 0.3),
          width: item.isRead ? 1 : 1.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x04000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Unread indicator dot
              if (!item.isRead) ...[
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(top: 5, left: 8),
                  decoration: const BoxDecoration(
                    color: AppColors.brandIndigo,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
              // Category Icon
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _getCategoryColor(item.category)
                      .withValues(alpha: 0.12),
                  borderRadius: AppRadius.radiusMd,
                ),
                child: Icon(
                  _getCategoryIcon(item.category),
                  color: _getCategoryColor(item.category),
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.s10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight:
                            item.isRead ? FontWeight.bold : FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.timeAgo,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.message,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              height: 1.45,
            ),
          ),

          // Visual Route Spine Insight (Node 21:4255)
          if (item.routeOrigin != null && item.routeDestination != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(AppSpacing.s10),
              decoration: BoxDecoration(
                color: AppColors.surfaceSoft,
                borderRadius: AppRadius.radiusMd,
                border: Border.all(color: AppColors.border),
              ),
              child: RouteSpineWidget(
                originTitle: item.routeOrigin!,
                destinationTitle: item.routeDestination!,
                isCompact: true,
              ),
            ),
          ],

          // Join Request Action Buttons (Node 21:4311)
          if (item.isJoinRequest) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandIndigo,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.radiusSm,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    onPressed: () {
                      setState(() => item.isRead = true);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم قبول طلب الراكب بنجاح!'),
                          backgroundColor: AppColors.success,
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: const Text('قبول الطلب'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textMuted,
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.radiusSm,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    onPressed: () {
                      setState(() => item.isRead = true);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم رفض الطلب.'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: const Text('رفض'),
                  ),
                ),
              ],
            ),
          ],

          // Single Action Button (Node 21:4272 / 21:4345)
          if (item.ctaLabel != null && !item.isJoinRequest) ...[
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  setState(() => item.isRead = true);
                  if (item.ctaRoute != null) {
                    context.push(item.ctaRoute!);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.ctaLabel!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.brandIndigo,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 12,
                      color: AppColors.brandIndigo,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getCategoryColor(NotificationFilter category) {
    switch (category) {
      case NotificationFilter.rides:
        return AppColors.brandIndigo;
      case NotificationFilter.finance:
        return AppColors.success;
      case NotificationFilter.system:
        return AppColors.brandViolet;
      case NotificationFilter.all:
        return AppColors.brandIndigo;
    }
  }

  IconData _getCategoryIcon(NotificationFilter category) {
    switch (category) {
      case NotificationFilter.rides:
        return Icons.directions_car_rounded;
      case NotificationFilter.finance:
        return Icons.payments_rounded;
      case NotificationFilter.system:
        return Icons.notifications_active_rounded;
      case NotificationFilter.all:
        return Icons.notifications_rounded;
    }
  }
}
