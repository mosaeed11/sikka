import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/logic/register_ui_state.dart';
import '../logic/profile_ui_cubit.dart';
import '../logic/profile_ui_state.dart';
import 'widgets/role_switcher_bar.dart';

/// Screen 01 & 05: User Profile & Role
/// Matching Figma Frame `21:4465` (Master Card `21:4668`, Role Switcher `21:4703`, 4 Setting Groups)
class ProfileScreen extends StatelessWidget {
  final bool showAppBar;

  const ProfileScreen({
    super.key,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileUiCubit(),
      child: _ProfileView(showAppBar: showAppBar),
    );
  }
}

class _ProfileView extends StatelessWidget {
  final bool showAppBar;

  const _ProfileView({required this.showAppBar});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.surfaceSoft,
        appBar: showAppBar
            ? AppBar(
                backgroundColor: AppColors.surfaceDefault,
                elevation: 0,
                title: const Text(
                  'الملف الشخصي',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                centerTitle: true,
              )
            : null,
        body: SafeArea(
          child: BlocBuilder<ProfileUiCubit, ProfileUiState>(
            builder: (context, state) {
              final cubit = context.read<ProfileUiCubit>();

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s16,
                  vertical: AppSpacing.s12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Top User Profile Master Card (Figma Node 21:4668)
                    _buildMasterCard(context, state, cubit),

                    const SizedBox(height: AppSpacing.s16),

                    // Role Dynamic Context Alert (Node 21:4469)
                    _buildRoleContextBanner(context, state),

                    const SizedBox(height: AppSpacing.s16),

                    // Group 1: بيانات الحساب (Node 21:4482)
                    _buildSettingsGroup(
                      title: 'بيانات الحساب الأساسية',
                      items: [
                        _buildSettingsTile(
                          icon: Icons.person_outline_rounded,
                          title: 'تعديل البيانات الشخصية',
                          subtitle: state.fullName,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('تعديل البيانات متاح محلياً.'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                        _buildSettingsTile(
                          icon: Icons.phone_android_rounded,
                          title: 'رقم الهاتف المسجل',
                          subtitle: state.phoneNumber,
                          onTap: () {},
                        ),
                        _buildSettingsTile(
                          icon: Icons.badge_outlined,
                          title: 'الرقم القومي',
                          subtitle: 'موثق ومطابق رسمياً ✅',
                          onTap: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.s16),

                    // Group 2: الكابتن والعربية (Node 21:4523)
                    _buildSettingsGroup(
                      title: 'بيانات الكابتن والمركبة',
                      items: [
                        _buildSettingsTile(
                          icon: Icons.directions_car_filled_rounded,
                          title: 'بيانات ومواصفات العربية',
                          subtitle: state.vehicleName,
                          trailingBadge: 'معتمدة',
                          onTap: () => context.push('/vehicle'),
                        ),
                        _buildSettingsTile(
                          icon: Icons.verified_user_rounded,
                          title: 'حالة التوثيق والمستندات',
                          subtitle: 'جميع الأوراق سارية ومكتملة',
                          trailingBadge: 'موثق',
                          onTap: () => context.push('/verification'),
                        ),
                        _buildSettingsTile(
                          icon: Icons.account_balance_wallet_rounded,
                          title: 'المحفظة والإيرادات المالية',
                          subtitle: 'سجل الأرباح وعمولة سِكّة (١٠٪)',
                          onTap: () => context.push('/wallet'),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.s16),

                    // Group 3: الرحلات والمدفوعات (Node 21:4568)
                    _buildSettingsGroup(
                      title: 'الرحلات والمدفوعات',
                      items: [
                        _buildSettingsTile(
                          icon: Icons.history_rounded,
                          title: 'سجل رحلاتي السابقة',
                          subtitle: '${state.totalRides} مشوار مشترك مكتمل',
                          onTap: () {},
                        ),
                        _buildSettingsTile(
                          icon: Icons.payment_rounded,
                          title: 'خيارات وطرق الدفع',
                          subtitle: 'كاش مباشرة للكابتن / الدفع الرقمي',
                          onTap: () => context.push('/payment-method'),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.s16),

                    // Group 4: التطبيق والإعدادات (Node 21:4612)
                    _buildSettingsGroup(
                      title: 'التطبيق والتفضيلات',
                      items: [
                        _buildSettingsTile(
                          icon: Icons.notifications_none_rounded,
                          title: 'الإشعارات والتنبيهات',
                          subtitle: 'تنبيهات الرحلات المطابقة والمالية',
                          onTap: () => context.push('/notifications'),
                        ),
                        _buildSettingsTile(
                          icon: Icons.settings_outlined,
                          title: 'إعدادات التطبيق والمظهر',
                          subtitle: 'اللغة، الوضع الليلي، والتنبيهات',
                          onTap: () => context.push('/settings'),
                        ),
                        _buildSettingsTile(
                          icon: Icons.headset_mic_outlined,
                          title: 'المساعدة والدعم الفني',
                          subtitle: 'تواصل معنا في أي وقت',
                          onTap: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.s24),

                    // Destructive Footer Action: Logout (Node 21:4653)
                    OutlinedButton.icon(
                      icon: const Icon(Icons.logout_rounded,
                          color: AppColors.error, size: 20),
                      label: const Text(
                        'تسجيل الخروج من الحساب',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.error,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFFECACA)),
                        backgroundColor: const Color(0xFFFEF2F2),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.radiusMd,
                        ),
                      ),
                      onPressed: () => _showLogoutDialog(context),
                    ),

                    const SizedBox(height: AppSpacing.s20),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMasterCard(
    BuildContext context,
    ProfileUiState state,
    ProfileUiCubit cubit,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDefault,
        borderRadius: AppRadius.radiusLg,
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              // Avatar with micro update badge (Node 21:4696)
              Stack(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.brandIndigoLight
                        .withValues(alpha: 0.25),
                    child: const Icon(
                      Icons.person_rounded,
                      color: AppColors.brandIndigo,
                      size: 36,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: AppColors.brandIndigo,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: 11,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.s14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          state.fullName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.verified_rounded,
                          size: 16,
                          color: AppColors.brandIndigo,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      state.phoneNumber,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              // Rating Pill Badge (Node 21:4688)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceMuted,
                  borderRadius: AppRadius.radiusSm,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: AppColors.accentYellow,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      state.rating.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.s16),

          // Instantaneous Role Switcher Control (Node 21:4703)
          RoleSwitcherBar(
            currentRole: state.activeRole,
            onRoleChanged: (newRole) {
              cubit.switchRole(newRole);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    newRole == SikkaUserRole.captain
                        ? 'تم التبديل إلى وضع الكابتن بنجاح.'
                        : 'تم التبديل إلى وضع الراكب بنجاح.',
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),

          const SizedBox(height: AppSpacing.s12),

          // Live Performance Pulse Strip (Node 21:4716)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s12,
              vertical: AppSpacing.s8,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceSoft,
              borderRadius: AppRadius.radiusMd,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPulseStat(
                  label: 'المشاوير المكتملة',
                  value: '${state.totalRides}',
                ),
                Container(width: 1, height: 20, color: AppColors.border),
                _buildPulseStat(
                  label: 'معدل الالتزام',
                  value: '٩٨٪',
                ),
                Container(width: 1, height: 20, color: AppColors.border),
                _buildPulseStat(
                  label: 'مستوى الثقة',
                  value: 'فائق (مستوى ٣)',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPulseStat({required String label, required String value}) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.brandIndigoDeep,
          ),
        ),
      ],
    );
  }

  Widget _buildRoleContextBanner(BuildContext context, ProfileUiState state) {
    final isCaptain = state.isCaptain;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s12),
      decoration: BoxDecoration(
        color: isCaptain
            ? AppColors.surfaceIndigoTintLight
            : const Color(0xFFF0FDF4),
        borderRadius: AppRadius.radiusMd,
        border: Border.all(
          color: isCaptain
              ? AppColors.brandIndigo.withValues(alpha: 0.15)
              : AppColors.success.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isCaptain ? Icons.drive_eta_rounded : Icons.hiking_rounded,
            color: isCaptain ? AppColors.brandIndigo : AppColors.success,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.s10),
          Expanded(
            child: Text(
              isCaptain
                  ? 'أنت تتصفح حالياً بـ "وضع الكابتن": يمكنك إنشاء ومشاركة مسارات سيارتك واستقبال طلبات الركاب بعمولة ١٠٪ فقط.'
                  : 'أنت تتصفح حالياً بـ "وضع الراكب": يمكنك تصفح الرحلات المتاحة والاشتراك في المسارات المتوافقة بدون عمولات إضافية.',
              style: TextStyle(
                fontSize: 12,
                color: isCaptain
                    ? AppColors.brandIndigoDeep
                    : const Color(0xFF166534),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup({
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceDefault,
            borderRadius: AppRadius.radiusLg,
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    String? trailingBadge,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s16,
          vertical: AppSpacing.s12,
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: AppRadius.radiusMd,
              ),
              child: Icon(icon, color: AppColors.brandIndigo, size: 20),
            ),
            const SizedBox(width: AppSpacing.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            if (trailingBadge != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: AppRadius.radiusFull,
                ),
                child: Text(
                  trailingBadge,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.success,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
            const Icon(
              Icons.arrow_back_ios_rounded,
              size: 14,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogCtx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusLg),
          title: const Text(
            'تسجيل الخروج',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'هل أنت متأكد من رغبتك في تسجيل الخروج من حسابك في سِكّة؟',
            style: TextStyle(fontSize: 13),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(dialogCtx).pop();
                context.go('/login');
              },
              child: const Text('تسجيل الخروج'),
            ),
          ],
        ),
      ),
    );
  }
}
