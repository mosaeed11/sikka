import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../logic/register_ui_cubit.dart';
import '../logic/register_ui_state.dart';
import 'login_screen.dart';
import 'otp_screen.dart';
import 'vehicle_documents_screen.dart';

class RegisterScreen extends StatefulWidget {
  final SikkaUserRole initialRole;

  const RegisterScreen({
    super.key,
    this.initialRole = SikkaUserRole.passenger,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterUiCubit(initialRole: widget.initialRole),
      child: BlocConsumer<RegisterUiCubit, RegisterUiState>(
        listener: (context, state) {
          if (state.isSuccess) {
            context.read<RegisterUiCubit>().resetSuccess();
            if (state.role == SikkaUserRole.passenger) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'تم تسجيل البيانات! جاري الانتقال للتحقق من الرقم...',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: AppColors.success,
                  duration: Duration(seconds: 2),
                ),
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => OtpScreen(
                    phoneNumber: state.phone.isNotEmpty
                        ? state.phone
                        : '01012345678',
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'تم تسجيل البيانات الأساسية! جاري الانتقال لبيانات العربية...',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: AppColors.success,
                  duration: Duration(seconds: 2),
                ),
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const VehicleDocumentsScreen(),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          final cubit = context.read<RegisterUiCubit>();

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: AppColors.surfaceDefault,
              appBar: AppBar(
                title: const Text('إنشاء حساب'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s16,
                    vertical: AppSpacing.s8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Welcoming Badge & Heading
                      Center(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceMuted,
                                borderRadius: AppRadius.radiusFull,
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.diversity_3_rounded,
                                      size: 16,
                                      color: AppColors.brandIndigoDeep),
                                  SizedBox(width: 6),
                                  Text(
                                    'مجتمع السِكّة المشتركة',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.brandIndigoDeep,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'اعمل حسابك في سِكّة',
                              style: AppTextStyles.h2,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'خطوة واحدة ونبدأ الرحلة سوا، بأمان وسهولة وتوفير.',
                              style: AppTextStyles.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s20),

                      // Account Role Selection Cards (Passenger vs Captain)
                      const Text(
                        'هتستخدم سِكّة إزاي؟',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildRoleCard(
                              isSelected: state.role == SikkaUserRole.passenger,
                              title: 'عايز أركب',
                              subtitle: 'راكب متطابق',
                              icon: Icons.person_pin_circle_rounded,
                              onTap: () =>
                                  cubit.roleChanged(SikkaUserRole.passenger),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.s12),
                          Expanded(
                            child: _buildRoleCard(
                              isSelected: state.role == SikkaUserRole.captain,
                              title: 'عندي عربية',
                              subtitle: 'كابتن الرحلة',
                              icon: Icons.directions_car_filled_rounded,
                              onTap: () =>
                                  cubit.roleChanged(SikkaUserRole.captain),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.s20),

                      // Form Container
                      // 1. Full Name Field
                      CustomTextField(
                        controller: _nameController,
                        label: 'الاسم بالكامل',
                        helperText: 'كما في بطاقة الرقم القومي',
                        hintText: 'مثال: أحمد عبد الرحمن',
                        errorText: state.nameError,
                        onChanged: cubit.fullNameChanged,
                        onSubmitted: (_) => cubit.validateFullName(),
                        suffixWidget: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.0),
                          child: Icon(Icons.badge_outlined,
                              size: 18, color: AppColors.textMuted),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s16),

                      // 2. Egyptian Phone Field
                      CustomTextField(
                        controller: _phoneController,
                        label: 'رقم الموبايل',
                        hintText: '010 1234 5678',
                        keyboardType: TextInputType.phone,
                        errorText: state.phoneError,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.left,
                        onChanged: cubit.phoneChanged,
                        onSubmitted: (_) => cubit.validatePhone(),
                        prefixWidget: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: const BoxDecoration(
                            color: AppColors.surfaceMuted,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(AppRadius.md),
                              bottomRight: Radius.circular(AppRadius.md),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('🇪🇬', style: TextStyle(fontSize: 16)),
                              SizedBox(width: 4),
                              Text(
                                '+20',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s16),

                      // 3. Optional Email Field
                      CustomTextField(
                        controller: _emailController,
                        label: 'البريد الإلكتروني',
                        helperText: 'اختياري للإيصالات الإلكترونية',
                        hintText: 'name@example.com',
                        keyboardType: TextInputType.emailAddress,
                        errorText: state.emailError,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.left,
                        onChanged: cubit.emailChanged,
                        onSubmitted: (_) => cubit.validateEmail(),
                        suffixWidget: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.0),
                          child: Icon(Icons.alternate_email_rounded,
                              size: 18, color: AppColors.textMuted),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s16),

                      // 4. Password Field with Strength Indicator
                      CustomTextField(
                        controller: _passwordController,
                        label: 'كلمة المرور',
                        hintText: '••••••••',
                        obscureText: !state.isPasswordVisible,
                        errorText: state.passwordError,
                        onChanged: cubit.passwordChanged,
                        onSubmitted: (_) => cubit.validatePassword(),
                        suffixWidget: IconButton(
                          icon: Icon(
                            state.isPasswordVisible
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            color: AppColors.textMuted,
                            size: 20,
                          ),
                          onPressed: cubit.togglePasswordVisibility,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s6),
                      // Strength indicator bars
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: state.passwordStrength > 0.2
                                    ? (state.passwordStrength > 0.6
                                        ? AppColors.success
                                        : AppColors.warning)
                                    : AppColors.border,
                                borderRadius: AppRadius.radiusFull,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: state.passwordStrength > 0.5
                                    ? (state.passwordStrength > 0.7
                                        ? AppColors.success
                                        : AppColors.warning)
                                    : AppColors.border,
                                borderRadius: AppRadius.radiusFull,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: state.passwordStrength >= 0.8
                                    ? AppColors.success
                                    : AppColors.border,
                                borderRadius: AppRadius.radiusFull,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'أدخل 6 أحرف على الأقل مع أرقام ورموز لزيادة الأمان',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s16),

                      // 5. Confirm Password Field
                      CustomTextField(
                        controller: _confirmPasswordController,
                        label: 'تأكيد كلمة المرور',
                        hintText: '••••••••',
                        obscureText: !state.isConfirmPasswordVisible,
                        errorText: state.confirmPasswordError,
                        textInputAction: TextInputAction.done,
                        onChanged: cubit.confirmPasswordChanged,
                        onSubmitted: (_) => cubit.submitRegister(),
                        suffixWidget: IconButton(
                          icon: Icon(
                            state.isConfirmPasswordVisible
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            color: AppColors.textMuted,
                            size: 20,
                          ),
                          onPressed: cubit.toggleConfirmPasswordVisibility,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s16),

                      // Agreement Checkbox
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: state.agreeToTerms,
                              activeColor: AppColors.brandIndigo,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              onChanged: cubit.toggleTerms,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: 'أوافق على ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textPrimary,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'شروط الاستخدام',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.brandIndigoDeep,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(text: ' و '),
                                  TextSpan(
                                    text: 'سياسة الخصوصية',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.brandIndigoDeep,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(text: ' لسِكّة.'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (state.termsError != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          state.termsError!,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.error,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],

                      const SizedBox(height: AppSpacing.s16),

                      // Privacy Delight Callout Card (Node 21:1368)
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.s12),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceMuted,
                          borderRadius: AppRadius.radiusMd,
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.lock_person_rounded,
                              color: AppColors.brandIndigoDeep,
                              size: 22,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'جميع بياناتك مشفرة ومحمية، ولن يتم مشاركة رقم هاتفك إلا مع ركاب رحلتك المؤكدين فقط.',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: AppColors.textSecondary,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s20),

                      // Primary Action CTA
                      CustomButton(
                        text: state.role == SikkaUserRole.passenger
                            ? 'إنشاء الحساب والمتابعة'
                            : 'متابعة بيانات العربية والوثائق',
                        height: 52,
                        isLoading: state.isLoading,
                        isEnabled: !state.isLoading &&
                            (state.isFormValid || state.areRequiredFieldsFilled),
                        onPressed: cubit.submitRegister,
                        prefixIcon: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s20),

                      // Footer Link to Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'عندك حساب بالفعل؟ ',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textMuted,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.brandIndigoDeep,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.s20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRoleCard({
    required bool isSelected,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.radiusMd,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.brandIndigo.withValues(alpha: 0.08)
              : AppColors.surfaceMuted,
          borderRadius: AppRadius.radiusMd,
          border: Border.all(
            color: isSelected ? AppColors.brandIndigo : Colors.transparent,
            width: 1.8,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.brandIndigo.withValues(alpha: 0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.brandIndigo : AppColors.surfaceDefault,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : AppColors.brandIndigo,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? AppColors.brandIndigoDeep
                          : AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: isSelected
                          ? AppColors.brandIndigo
                          : AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
