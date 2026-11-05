import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../logic/choose_role_cubit.dart';
import '../logic/choose_role_state.dart';
import '../logic/register_ui_state.dart';
import 'register_screen.dart';

/// Screen 09: Choose Your Role (هتستخدم سِكّة إزاي؟)
/// Figma Node ID: `21:565`
class ChooseRoleScreen extends StatelessWidget {
  final SikkaUserRole initialRole;

  const ChooseRoleScreen({
    super.key,
    this.initialRole = SikkaUserRole.passenger,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChooseRoleCubit(initialRole: initialRole),
      child: const _ChooseRoleView(),
    );
  }
}

class _ChooseRoleView extends StatelessWidget {
  const _ChooseRoleView();

  void _onContinue(BuildContext context, SikkaUserRole selectedRole) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RegisterScreen(initialRole: selectedRole),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white.withValues(alpha: 0.95),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.textPrimary,
              size: 20,
            ),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          centerTitle: true,
          title: const Text(
            'Role Selection',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              letterSpacing: 0.2,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.brandIndigo,
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<ChooseRoleCubit, ChooseRoleState>(
            builder: (context, state) {
              final cubit = context.read<ChooseRoleCubit>();
              final isPassenger = state.selectedRole == SikkaUserRole.passenger;
              final isCaptain = state.selectedRole == SikkaUserRole.captain;

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16,
                        vertical: AppSpacing.s12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Top Sub-header Capsule from Figma
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE1E8FD),
                                borderRadius: AppRadius.radiusFull,
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.sync_alt_rounded,
                                    size: 14,
                                    color: AppColors.brandIndigoDeep,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'مرونة كاملة في الاستخدام',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.brandIndigoDeep,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: AppSpacing.s8),

                          // Heading & Subheading
                          const Text(
                            'هتستخدم سِكّة إزاي؟',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'تقدر تبدل بين الراكب والكابتن في أي وقت من حسابك بسهولة.',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                              height: 1.4,
                            ),
                          ),

                          const SizedBox(height: AppSpacing.s20),

                          // Option 1: Passenger Card (عايز أركب)
                          _buildPassengerCard(
                            isSelected: isPassenger,
                            onTap: () =>
                                cubit.selectRole(SikkaUserRole.passenger),
                          ),

                          const SizedBox(height: AppSpacing.s16),

                          // Option 2: Captain Card (عندي عربية)
                          _buildCaptainCard(
                            isSelected: isCaptain,
                            onTap: () =>
                                cubit.selectRole(SikkaUserRole.captain),
                          ),

                          const SizedBox(height: AppSpacing.s20),

                          // Notice Card from Figma
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.s12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE1E8FD),
                              borderRadius: AppRadius.radiusMd,
                              border: Border.all(
                                color: AppColors.brandIndigo.withValues(alpha: 0.15),
                              ),
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.verified_user_outlined,
                                  color: AppColors.brandIndigoDeep,
                                  size: 18,
                                ),
                                SizedBox(width: AppSpacing.s8),
                                Expanded(
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'ملحوظة: ',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              'حساب الكابتن بيحتاج مراجعة سريعة لرخصتك وبيانات العربية قبل إنشاء أول رحلة.',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.textSecondary,
                                            height: 1.4,
                                          ),
                                        ),
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
                  ),

                  // Bottom Action CTA
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.s16,
                      AppSpacing.s8,
                      AppSpacing.s16,
                      AppSpacing.s20,
                    ),
                    child: CustomButton(
                      text: 'متابعة',
                      height: 50,
                      onPressed: () => _onContinue(context, state.selectedRole),
                      prefixIcon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPassengerCard({
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.radiusLg,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(AppSpacing.s16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.brandIndigo.withValues(alpha: 0.04)
              : Colors.white,
          borderRadius: AppRadius.radiusLg,
          border: Border.all(
            color: isSelected ? AppColors.brandIndigo : const Color(0xFFE2E8F0),
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColors.brandIndigo.withValues(alpha: 0.12)
                  : const Color(0x06000000),
              blurRadius: isSelected ? 12 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Row: Radio Checkmark, Labels, Avatar Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Radio check indicator
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppColors.brandIndigo : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.brandIndigo
                          : const Color(0xFFCBD5E1),
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 16,
                        )
                      : null,
                ),

                // Center/Right Label & Avatar
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'الراكب',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.brandIndigoDeep,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'عايز أركب',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: AppSpacing.s12),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE2DFFF),
                      ),
                      child: const Icon(
                        Icons.person_pin_circle_rounded,
                        color: AppColors.brandIndigoDeep,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.s8),

            // Description
            const Text(
              'دور على رحلة في نفس سِكّتك ووفر فلوس المشوار والانتظار.',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.35,
              ),
            ),

            const SizedBox(height: AppSpacing.s12),

            // Transit Route Graphic Pill from Figma
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3FF),
                borderRadius: AppRadius.radiusSm,
              ),
              child: Row(
                children: [
                  // Departure
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.brandIndigo,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'نقطة ركوبك',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),

                  // Route Line with transit dots
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 2,
                            color: const Color(0xFFDCE2F7),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(3, (index) {
                              return Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: index == 1
                                      ? AppColors.brandViolet
                                      : AppColors.brandIndigo,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Destination
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 14,
                        color: AppColors.textPrimary,
                      ),
                      SizedBox(width: 2),
                      Text(
                        'الوصول',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.s8),

            // Value Prop Tag
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEADDFF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.discount_outlined,
                      size: 13,
                      color: Color(0xFF25005A),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'وفر حتى ٦٠٪ من تكلفة المشاوير اليومية',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF25005A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaptainCard({
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.radiusLg,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(AppSpacing.s16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.brandIndigo.withValues(alpha: 0.04)
              : Colors.white,
          borderRadius: AppRadius.radiusLg,
          border: Border.all(
            color: isSelected ? AppColors.brandIndigo : const Color(0xFFE2E8F0),
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColors.brandIndigo.withValues(alpha: 0.12)
                  : const Color(0x06000000),
              blurRadius: isSelected ? 12 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Row: Radio Checkmark, Labels, Avatar Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Radio check indicator
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppColors.brandIndigo : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.brandIndigo
                          : const Color(0xFFCBD5E1),
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 16,
                        )
                      : null,
                ),

                // Center/Right Label & Avatar
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'الكابتن',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'عندي عربية',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: AppSpacing.s12),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFDCE2F7),
                      ),
                      child: const Icon(
                        Icons.directions_car_filled_rounded,
                        color: AppColors.brandIndigoDeep,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.s8),

            // Description
            const Text(
              'شارك رحلتك اليومية ووفّر مكان لحد في سِكّتك وغطي تكلفة البنزين.',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.35,
              ),
            ),

            const SizedBox(height: AppSpacing.s12),

            // Empty Seats Graphic Pill from Figma
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3FF),
                borderRadius: AppRadius.radiusSm,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Seats indicator capsule
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppRadius.radiusFull,
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.airline_seat_recline_normal_rounded,
                          size: 14,
                          color: AppColors.brandIndigo,
                        ),
                        Icon(
                          Icons.airline_seat_recline_normal_rounded,
                          size: 14,
                          color: AppColors.brandIndigo,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '٢ متاحة',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Label
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.airline_seat_recline_extra_rounded,
                        size: 15,
                        color: AppColors.textPrimary,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'كراسي فاضية',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.s8),

            // Value Prop Tag (Yellow)
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE083),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_gas_station_rounded,
                      size: 13,
                      color: Color(0xFF231B00),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'غطي حتى ٨٠٪ من مصاريف بنزينك',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF231B00),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
