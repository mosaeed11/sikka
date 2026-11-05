import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../logic/forgot_password_cubit.dart';
import '../logic/forgot_password_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final TextEditingController _phoneController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state.step == ForgotPasswordStep.resetPassword &&
              _newPasswordController.text.isEmpty &&
              state.newPassword.isNotEmpty) {
            _newPasswordController.text = state.newPassword;
            _confirmPasswordController.text = state.confirmPassword;
          }

          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'تم حفظ كلمة المرور بنجاح! يمكنك الآن تسجيل الدخول.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: AppColors.success,
                duration: Duration(seconds: 2),
              ),
            );
            Future.delayed(const Duration(milliseconds: 1500), () {
              if (context.mounted) {
                Navigator.of(context).maybePop();
              }
            });
          }
        },
        builder: (context, state) {
          final cubit = context.read<ForgotPasswordCubit>();
          final isStepOne = state.step == ForgotPasswordStep.phoneRequest;

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: AppColors.surfaceDefault,
              appBar: AppBar(
                title: const Text('استعادة كلمة المرور'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                  onPressed: () {
                    if (!isStepOne) {
                      cubit.backToPhone();
                    } else {
                      Navigator.of(context).maybePop();
                    }
                  },
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
                      // Progress & Route Indicator Header (Node 21:390)
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.s12),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceMuted,
                          borderRadius: AppRadius.radiusMd,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x08000000),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.brandIndigoDeep,
                                  ),
                                  child: const Icon(
                                    Icons.lock_reset_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'استعادة سِكّتك',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    Text(
                                      isStepOne
                                          ? 'خطوة ١ من ٢: تأكيد الهوية'
                                          : 'خطوة ٢ من ٢: كلمة المرور الجديدة',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Step indicators
                            Row(
                              children: [
                                Container(
                                  width: isStepOne ? 24 : 8,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: isStepOne
                                        ? AppColors.brandIndigoDeep
                                        : AppColors.surfaceDotInactive,
                                    borderRadius: AppRadius.radiusFull,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Container(
                                  width: !isStepOne ? 24 : 8,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: !isStepOne
                                        ? AppColors.brandIndigoDeep
                                        : AppColors.surfaceDotInactive,
                                    borderRadius: AppRadius.radiusFull,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s16),

                      // Animated View Switching between Step 1 and Step 2
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 300),
                        crossFadeState: isStepOne
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        firstChild: _buildStepOne(context, cubit, state),
                        secondChild: _buildStepTwo(context, cubit, state),
                      ),
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

  // ================= STEP 1: Phone Request Form =================
  Widget _buildStepOne(
    BuildContext context,
    ForgotPasswordCubit cubit,
    ForgotPasswordState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Security Badge & Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.brandVioletSoft,
                borderRadius: AppRadius.radiusFull,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shield_outlined,
                      size: 14, color: AppColors.brandViolet),
                  SizedBox(width: 4),
                  Text(
                    'حماية وتأمين الحساب',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brandViolet,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text('نسيت كلمة المرور؟', style: AppTextStyles.h2),
        const SizedBox(height: 4),
        const Text(
          'ولا يهمك، دخل رقم موبايلك وهنبعتلك كود تأكيد علشان تعمل كلمة مرور جديدة وتكمل مشاويرك على طول.',
          style: AppTextStyles.bodySmall,
        ),

        const SizedBox(height: AppSpacing.s16),

        // Visual Journey Illustration Banner (Node 21:417)
        ClipRRect(
          borderRadius: AppRadius.radiusMd,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/forgot_password_banner.png',
                width: double.infinity,
                height: 130,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 130,
                  color: AppColors.surfaceMuted,
                  child: const Center(
                    child: Icon(Icons.route_rounded,
                        size: 40, color: AppColors.brandIndigo),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.nightAlternative.withValues(alpha: 0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.lock_clock_rounded,
                          color: Colors.white, size: 14),
                      SizedBox(width: 6),
                      Text(
                        'تشفير فوري لبيانات الدخول والمشاوير',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.s20),

        // Egyptian Phone Input Field
        CustomTextField(
          controller: _phoneController,
          label: 'رقم الموبايل المسجل',
          hintText: '010 1234 5678',
          keyboardType: TextInputType.phone,
          errorText: state.phoneError,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.left,
          onChanged: cubit.phoneChanged,
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

        const SizedBox(height: AppSpacing.s24),

        // CTA Button
        CustomButton(
          text: 'إرسال كود التحقق',
          height: 52,
          isLoading: state.isLoading,
          isEnabled: state.phone.isNotEmpty,
          onPressed: cubit.submitPhone,
        ),

        const SizedBox(height: AppSpacing.s16),

        Center(
          child: InkWell(
            onTap: () => Navigator.of(context).maybePop(),
            child: const Text(
              'تذكرت كلمة المرور؟ تسجيل الدخول',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.brandIndigoDeep,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ================= STEP 2: Reset Password Card =================
  Widget _buildStepTwo(
    BuildContext context,
    ForgotPasswordCubit cubit,
    ForgotPasswordState state,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.radiusLg,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with Verification Success Pill (Node 21:484)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.brandVioletSoft,
                  borderRadius: AppRadius.radiusFull,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_rounded,
                        size: 14, color: AppColors.brandViolet),
                    SizedBox(width: 4),
                    Text(
                      'تم التحقق من الكود 4920',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.brandViolet,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded,
                    size: 20, color: AppColors.textMuted),
                onPressed: cubit.backToPhone,
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('اعمل كلمة مرور جديدة', style: AppTextStyles.h2),
          const SizedBox(height: 4),
          const Text(
            'اختار كلمة مرور قوية وسهلة تفتكرها لمشاويرك الجاية.',
            style: AppTextStyles.bodySmall,
          ),

          const SizedBox(height: AppSpacing.s20),

          // New Password Field
          CustomTextField(
            controller: _newPasswordController,
            label: 'كلمة المرور الجديدة',
            hintText: '••••••••',
            obscureText: !state.isPasswordVisible,
            errorText: state.passwordError,
            onChanged: cubit.newPasswordChanged,
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
          const SizedBox(height: 6),

          // Password Strength Bar & Label (Node 21:506: "قوية جداً")
          Row(
            children: [
              const Text(
                'قوية جداً',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Row(
                  children: List.generate(4, (i) {
                    final isActive = state.passwordStrength > (i * 0.25);
                    return Expanded(
                      child: Container(
                        height: 5,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.success
                              : AppColors.surfaceDotInactive,
                          borderRadius: AppRadius.radiusFull,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.s16),

          // Confirm Password Field
          CustomTextField(
            controller: _confirmPasswordController,
            label: 'تأكيد كلمة المرور الجديدة',
            hintText: '••••••••',
            obscureText: !state.isConfirmPasswordVisible,
            errorText: state.confirmPasswordError,
            onChanged: cubit.confirmPasswordChanged,
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

          const SizedBox(height: AppSpacing.s24),

          // Save Password CTA
          CustomButton(
            text: 'حفظ كلمة المرور وتسجيل الدخول',
            height: 52,
            isLoading: state.isLoading,
            isEnabled: state.newPassword.isNotEmpty &&
                state.confirmPassword.isNotEmpty &&
                state.passwordError == null &&
                state.confirmPasswordError == null,
            onPressed: cubit.submitNewPassword,
          ),
        ],
      ),
    );
  }
}
