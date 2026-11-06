import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/logic/register_ui_state.dart';

/// Instantaneous Role Switcher Control
/// Matching Figma Frame `21:4465` (Node `21:4703`)
class RoleSwitcherBar extends StatelessWidget {
  final SikkaUserRole currentRole;
  final ValueChanged<SikkaUserRole> onRoleChanged;

  const RoleSwitcherBar({
    super.key,
    required this.currentRole,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isCaptain = currentRole == SikkaUserRole.captain;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: AppRadius.radiusFull,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildRoleButton(
              title: 'كابتن (صاحب سيارة)',
              icon: Icons.directions_car_rounded,
              isActive: isCaptain,
              onTap: () => onRoleChanged(SikkaUserRole.captain),
            ),
          ),
          Expanded(
            child: _buildRoleButton(
              title: 'راكب (مسافر)',
              icon: Icons.person_rounded,
              isActive: !isCaptain,
              onTap: () => onRoleChanged(SikkaUserRole.passenger),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleButton({
    required String title,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.radiusFull,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.brandIndigo : Colors.transparent,
          borderRadius: AppRadius.radiusFull,
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.brandIndigo.withValues(alpha: 0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isActive ? Colors.white : AppColors.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
