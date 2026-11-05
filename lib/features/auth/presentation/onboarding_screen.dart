import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../logic/onboarding_cubit.dart';
import '../logic/onboarding_state.dart';
import 'choose_role_screen.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void _navigateToRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ChooseRoleScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (_pageController.hasClients &&
              _pageController.page?.round() != state.currentPage) {
            _pageController.animateToPage(
              state.currentPage,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOutCubic,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<OnboardingCubit>();

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: AppColors.surfaceDefault,
              body: SafeArea(
                child: Column(
                  children: [
                    // Top App Bar Navigation
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16,
                        vertical: AppSpacing.s12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Skip button
                          if (!state.isLastPage)
                            InkWell(
                              onTap: cubit.skip,
                              borderRadius: AppRadius.radiusFull,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceMuted,
                                  borderRadius: AppRadius.radiusFull,
                                ),
                                child: const Text(
                                  'تخطي',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            )
                          else
                            const SizedBox(width: 60),

                          // SIKKA Brand Title / Logo
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.brandIndigo,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'سِكّة',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.brandIndigoDeep,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // PageView Area
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: cubit.setPage,
                        children: const [
                          _OnboardingPageOne(),
                          _OnboardingPageTwo(),
                          _OnboardingPageThree(),
                        ],
                      ),
                    ),

                    // Page Indicators (Dots)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(state.totalPages, (index) {
                          final bool isActive = state.currentPage == index;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 8,
                            width: isActive ? 32 : 8,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppColors.brandIndigo
                                  : AppColors.surfaceDotInactive,
                              borderRadius: AppRadius.radiusFull,
                            ),
                          );
                        }),
                      ),
                    ),

                    // Bottom Action Buttons
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.s16,
                        AppSpacing.s4,
                        AppSpacing.s16,
                        AppSpacing.s20,
                      ),
                      child: state.isLastPage
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomButton(
                                  text: 'ابدأ مع سِكّة',
                                  height: 52,
                                  onPressed: _navigateToRegister,
                                  prefixIcon: const Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.s8),
                                InkWell(
                                  onTap: _navigateToLogin,
                                  borderRadius: AppRadius.radiusMd,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal: 16.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'عندي حساب بالفعل؟ ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                        Text(
                                          'تسجيل الدخول',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.brandIndigoDeep,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomButton(
                                  text: 'التالي',
                                  height: 52,
                                  onPressed: cubit.nextPage,
                                  prefixIcon: const Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.s8),
                                CustomButton(
                                  text: 'تخطي المقدمة',
                                  height: 44,
                                  variant: CustomButtonVariant.text,
                                  onPressed: cubit.skip,
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ================= PAGE 1: رايح فين؟ =================
class _OnboardingPageOne extends StatelessWidget {
  const _OnboardingPageOne();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
      child: Column(
        children: [
          // Route Graphic Card
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.s20),
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: AppRadius.radiusLg,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Live Transit Badges
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: AppRadius.radiusFull,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0D000000),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.near_me_rounded,
                                size: 14, color: AppColors.brandIndigoDeep),
                            SizedBox(width: 4),
                            Text(
                              '٣٢ كم',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.brandIndigoDeep,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: AppRadius.radiusFull,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0D000000),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.success,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'سِكّة مباشرة',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Route Visual Timeline
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 8),
                    child: Column(
                      children: [
                        // Origin
                        _buildStopItem(
                          time: '٠٧:٤٥ ص',
                          tag: 'نقطة الركوب',
                          title: 'مدينة نصر',
                          subtitle: 'أول عباس العقاد',
                          icon: Icons.directions_car_filled_rounded,
                          iconBg: AppColors.brandIndigoDeep,
                          isStart: true,
                        ),
                        // Connecting dotted track
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 2,
                              height: 48,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColors.brandIndigoDeep,
                                    AppColors.brandIndigoDeep.withValues(alpha: 0.3),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Destination
                        _buildStopItem(
                          time: '٠٨:٣٠ ص',
                          tag: 'نقطة الوصول',
                          title: 'الشيخ زايد / ٦ أكتوبر',
                          subtitle: 'هايبر وان والقرية الذكية',
                          icon: Icons.location_on_rounded,
                          iconBg: AppColors.nightAlternative,
                          isStart: false,
                        ),
                      ],
                    ),
                  ),

                  // Bottom Match Snippet Pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppRadius.radiusMd,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0A000000),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success.withValues(alpha: 0.12),
                            borderRadius: AppRadius.radiusFull,
                          ),
                          child: const Text(
                            'وفر ٦٠٪',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColors.success,
                            ),
                          ),
                        ),
                        const Row(
                          children: [
                            Text(
                              'متوسط ٣ رحلات متطابقة يومياً',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.check_circle_rounded,
                                size: 16, color: AppColors.brandIndigo),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.s24),

          // Editorial Typography
          const Text(
            'رايح فين؟',
            style: AppTextStyles.h1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.s8),
          const Text(
            'سِكّة بتوصلك بناس رايحين نفس اتجاهك.',
            style: AppTextStyles.body,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.s12),
        ],
      ),
    );
  }

  Widget _buildStopItem({
    required String time,
    required String tag,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconBg,
    required bool isStart,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: iconBg.withValues(alpha: 0.3),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tag,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMuted,
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ================= PAGE 2: عندك كرسي فاضي؟ =================
class _OnboardingPageTwo extends StatelessWidget {
  const _OnboardingPageTwo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
      child: Column(
        children: [
          // Graphic Card
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.s20),
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: AppRadius.radiusLg,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Status Badges
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceIndigoTintLight,
                          borderRadius: AppRadius.radiusFull,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.event_seat_rounded,
                                size: 14, color: AppColors.brandIndigoDeep),
                            SizedBox(width: 4),
                            Text(
                              '٣ كراسي فاضية',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.brandIndigoDeep,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentYellowLight,
                          borderRadius: AppRadius.radiusFull,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.local_gas_station_rounded,
                                size: 14, color: AppColors.accentYellowDark),
                            SizedBox(width: 4),
                            Text(
                              'وفّر ٤٠٪ من تكلفة البنزين',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.accentYellowDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Route Simulation Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppRadius.radiusMd,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x08000000),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.brandIndigo,
                              ),
                              child: const Icon(
                                Icons.airline_seat_recline_normal_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'نقطة الانطلاق: المعادي',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    'الكابتن أحمد في الطريق • ٠٧:٣٠ ص',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceMuted,
                                borderRadius: AppRadius.radiusSm,
                              ),
                              child: const Text(
                                'كابتن موثق',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.brandIndigoDeep,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Seat representation icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildSeatIndicator(isAvailable: false, label: 'السائق'),
                            _buildSeatIndicator(isAvailable: true, label: 'كرسي ١'),
                            _buildSeatIndicator(isAvailable: true, label: 'كرسي ٢'),
                            _buildSeatIndicator(isAvailable: true, label: 'كرسي ٣'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Bottom Rule Note
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.brandIndigo.withValues(alpha: 0.08),
                      borderRadius: AppRadius.radiusMd,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shield_rounded,
                            size: 16, color: AppColors.brandIndigo),
                        SizedBox(width: 6),
                        Text(
                          'تغطية تكاليف الطريق بدون ما تخرج عن مسارك',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.brandIndigoDeep,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.s24),

          // Editorial Typography
          const Text(
            'عندك كرسي فاضي؟',
            style: AppTextStyles.h1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.s8),
          const Text(
            'شارك رحلتك مع ناس في سِكّتك وقلّل تكلفة المشوار.',
            style: AppTextStyles.body,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.s12),
        ],
      ),
    );
  }

  Widget _buildSeatIndicator({required bool isAvailable, required String label}) {
    return Column(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: isAvailable ? AppColors.surfaceMuted : AppColors.brandIndigo,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isAvailable ? AppColors.brandIndigo : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Icon(
            Icons.event_seat_rounded,
            size: 20,
            color: isAvailable ? AppColors.brandIndigo : Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

// ================= PAGE 3: لقينا حد في سِكّتك =================
class _OnboardingPageThree extends StatelessWidget {
  const _OnboardingPageThree();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
      child: Column(
        children: [
          // Graphic Stage Card
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.s20),
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: AppRadius.radiusLg,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Verified Badges
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentYellowLight,
                          borderRadius: AppRadius.radiusFull,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.bolt_rounded,
                                size: 14, color: AppColors.accentYellowDark),
                            SizedBox(width: 4),
                            Text(
                              'تطابق فوري ٩٨٪',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.accentYellowDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: AppRadius.radiusFull,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.verified_user_rounded,
                                size: 14, color: AppColors.brandIndigo),
                            SizedBox(width: 6),
                            Text(
                              'سِكّة موثقة',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Route Convergence Illustration
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppRadius.radiusMd,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x08000000),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Waypoint Pin
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceIndigoTint,
                            borderRadius: AppRadius.radiusFull,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.pin_drop_rounded,
                                  size: 14, color: AppColors.brandIndigoDeep),
                              SizedBox(width: 4),
                              Text(
                                'نقطة الالتقاء • محطة المعادي',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.brandIndigoDeep,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Match Passenger Card
                        Row(
                          children: [
                            Stack(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    'assets/images/passenger_avatar.png',
                                    width: 42,
                                    height: 42,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      width: 42,
                                      height: 42,
                                      color: AppColors.surfaceIndigoTint,
                                      child: const Icon(
                                        Icons.person_rounded,
                                        color: AppColors.brandIndigo,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      color: AppColors.success,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'سارة م. (راكبة متطابقة)',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    'تقييم ٤.٩ ★ • شاركت ٤٢ رحلة',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.brandIndigo,
                                borderRadius: AppRadius.radiusSm,
                              ),
                              child: const Text(
                                'قبول طلب',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Community Trust Pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceIndigoTint,
                      borderRadius: AppRadius.radiusFull,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.groups_rounded,
                            size: 16, color: AppColors.brandIndigoDeep),
                        SizedBox(width: 6),
                        Text(
                          'أكثر من ١٢ ألف راكب يومياً في القاهرة والجيزة',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.brandIndigoDeep,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.s24),

          // Editorial Typography
          const Text(
            'لقينا حد في سِكّتك',
            style: AppTextStyles.h1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.s8),
          const Text(
            'اختار الرحلة المناسبة، اطلب مكانك، وروحوا سوا.',
            style: AppTextStyles.body,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.s12),
        ],
      ),
    );
  }
}
