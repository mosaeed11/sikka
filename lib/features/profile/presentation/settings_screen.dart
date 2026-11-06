import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

/// Screen 14: App Settings
/// Matching Figma Frame `21:4207` (Hub Card `21:4375`, Language `21:4384`, Appearance `21:4396`, Alerts `21:4408`, Footer `21:4421`)
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _instantRideAlerts = true;
  bool _shareLiveLocation = true;
  bool _soundEnabled = true;
  String _selectedLanguage = 'العربية (مصر)';
  String _selectedAppearance = 'فاتح (النهاري)';

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
            'إعدادات التطبيق',
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
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s16,
              vertical: AppSpacing.s12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Quick App Settings Hub Card (Figma Node 21:4375)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.s16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDefault,
                    borderRadius: AppRadius.radiusLg,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.tune_rounded,
                              color: AppColors.brandIndigo, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'تفضيلات الاستخدام السريعة',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.s14),

                      // Setting 1: Language Preference (Node 21:4384)
                      _buildSelectorTile(
                        icon: Icons.language_rounded,
                        title: 'لغة التطبيق',
                        value: _selectedLanguage,
                        onTap: () => _showLanguageDialog(),
                      ),

                      const Divider(height: 20, color: AppColors.border),

                      // Setting 2: Appearance Mode (Node 21:4396)
                      _buildSelectorTile(
                        icon: Icons.brightness_6_rounded,
                        title: 'وضع المظهر',
                        value: _selectedAppearance,
                        onTap: () => _showAppearanceDialog(),
                      ),

                      const Divider(height: 20, color: AppColors.border),

                      // Setting 3: Instant Ride Alerts Switch (Node 21:4408)
                      _buildSwitchTile(
                        icon: Icons.notifications_active_rounded,
                        title: 'تنبيهات الرحلات الفورية',
                        subtitle: 'إشعارك فور توفر رحلة متوافقة مع مسارك',
                        value: _instantRideAlerts,
                        onChanged: (val) {
                          setState(() => _instantRideAlerts = val);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.s16),

                // Privacy & Commute Security Section
                Container(
                  padding: const EdgeInsets.all(AppSpacing.s16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDefault,
                    borderRadius: AppRadius.radiusLg,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.security_rounded,
                              color: AppColors.brandIndigo, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'الأمان ومشاركة الموقع',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.s14),
                      _buildSwitchTile(
                        icon: Icons.share_location_rounded,
                        title: 'مشاركة التتبع المباشر أثناء الرحلة',
                        subtitle: 'مشاركة مسارك تلقائياً مع جهات اتصال الطوارئ',
                        value: _shareLiveLocation,
                        onChanged: (val) {
                          setState(() => _shareLiveLocation = val);
                        },
                      ),
                      const Divider(height: 20, color: AppColors.border),
                      _buildSwitchTile(
                        icon: Icons.volume_up_rounded,
                        title: 'أصوات التنبيهات وإشعارات التطبيق',
                        subtitle: 'تشغيل نغمة عند تأكيد المقاعد أو قبول الطلب',
                        value: _soundEnabled,
                        onChanged: (val) {
                          setState(() => _soundEnabled = val);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.s24),

                // Mini Trust & Version Footer (Figma Node 21:4421)
                Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.shield_rounded,
                              size: 14, color: AppColors.brandIndigo),
                          SizedBox(width: 4),
                          Text(
                            'سِكّة • تطبيق مشاركة الرحلات الآمن',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.brandIndigoDeep,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'الإصدار 1.0.0 (بيئة التطوير التجريبية • القاهرة)',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.s20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectorTile({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: AppRadius.radiusSm,
              ),
              child: Icon(icon, color: AppColors.brandIndigo, size: 18),
            ),
            const SizedBox(width: AppSpacing.s12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: AppRadius.radiusSm,
              ),
              child: Row(
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brandIndigoDeep,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 10,
                    color: AppColors.textMuted,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.surfaceMuted,
            borderRadius: AppRadius.radiusSm,
          ),
          child: Icon(icon, color: AppColors.brandIndigo, size: 18),
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
        Switch(
          value: value,
          activeThumbColor: AppColors.brandIndigo,
          onChanged: onChanged,
        ),
      ],
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (dialogCtx) => Directionality(
        textDirection: TextDirection.rtl,
        child: SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusLg),
          title: const Text('اختر لغة التطبيق'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                setState(() => _selectedLanguage = 'العربية (مصر)');
                Navigator.of(dialogCtx).pop();
              },
              child: const Text('العربية (مصر 🇪🇬)'),
            ),
            SimpleDialogOption(
              onPressed: () {
                setState(() => _selectedLanguage = 'English');
                Navigator.of(dialogCtx).pop();
              },
              child: const Text('English (US 🇺🇸)'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAppearanceDialog() {
    showDialog(
      context: context,
      builder: (dialogCtx) => Directionality(
        textDirection: TextDirection.rtl,
        child: SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusLg),
          title: const Text('اختر وضع المظهر'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                setState(() => _selectedAppearance = 'فاتح (النهاري)');
                Navigator.of(dialogCtx).pop();
              },
              child: const Text('فاتح (النهاري ☀️)'),
            ),
            SimpleDialogOption(
              onPressed: () {
                setState(() => _selectedAppearance = 'داكن (الليلي)');
                Navigator.of(dialogCtx).pop();
              },
              child: const Text('داكن (الليلي 🌙)'),
            ),
            SimpleDialogOption(
              onPressed: () {
                setState(() => _selectedAppearance = 'حسب إعدادات الجهاز');
                Navigator.of(dialogCtx).pop();
              },
              child: const Text('تلقائي (حسب النظام)'),
            ),
          ],
        ),
      ),
    );
  }
}
