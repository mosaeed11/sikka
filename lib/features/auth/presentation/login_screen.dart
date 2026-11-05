import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../logic/login_ui_cubit.dart';
import '../logic/login_ui_state.dart';
import 'choose_role_screen.dart';
import 'forgot_password_screen.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginUiCubit(),
      child: BlocConsumer<LoginUiCubit, LoginUiState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'تم تسجيل الدخول بنجاح! (معاينة محلية)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: AppColors.success,
                duration: Duration(seconds: 2),
              ),
            );
            context.read<LoginUiCubit>().resetSuccess();
          }
        },
        builder: (context, state) {
          final cubit = context.read<LoginUiCubit>();

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: AppColors.surfaceDefault,
              appBar: AppBar(
                title: const Text('تسجيل الدخول'),
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
                      // Brand & Delight Header Area from Figma (Node 21:841)
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.s16),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceMuted,
                          borderRadius: AppRadius.radiusMd,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0A000000),
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Micro pill badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.brandVioletSoft,
                                      borderRadius: AppRadius.radiusFull,
                                    ),
                                    child: const Text(
                                      'نفس السِكّة، نوصل سوا',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.brandViolet,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  const Text(
                                    'أهلاً بيك في سِكّة',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  const Text(
                                    'ادخل حسابك وكمل رحلتك في شوارع القاهرة.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Sikka Logo Icon
                            Image.asset(
                              'assets/images/sikka_logo.png',
                              width: 64,
                              height: 64,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: AppColors.brandIndigo,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Center(
                                  child: Text(
                                    'سِكّة',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s20),

                      // Interactive Login Card (Node 21:863)
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.s16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: AppRadius.radiusMd,
                          border: Border.all(
                            color: AppColors.border.withValues(alpha: 0.6),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0F000000),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Phone Input Field with Egypt Prefix (+20 🇪🇬)
                            CustomTextField(
                              controller: _phoneController,
                              label: 'رقم الموبايل',
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
                                    Text(
                                      '🇪🇬',
                                      style: TextStyle(fontSize: 16),
                                    ),
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

                            // Password Input Field
                            CustomTextField(
                              controller: _passwordController,
                              label: 'كلمة المرور',
                              hintText: '••••••••',
                              obscureText: !state.isPasswordVisible,
                              keyboardType: TextInputType.visiblePassword,
                              errorText: state.passwordError,
                              onChanged: cubit.passwordChanged,
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

                            const SizedBox(height: AppSpacing.s12),

                            // Remember Me & Forgot Password Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Checkbox(
                                        value: state.rememberMe,
                                        activeColor: AppColors.brandIndigo,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        onChanged: (_) =>
                                            cubit.toggleRememberMe(),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Text(
                                      'تذكرني',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const ForgotPasswordScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'نسيت كلمة المرور؟',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.brandIndigoDeep,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: AppSpacing.s20),

                            // Login CTA Button
                            CustomButton(
                              text: 'تسجيل الدخول',
                              height: 52,
                              isLoading: state.isLoading,
                              isEnabled: state.phone.isNotEmpty &&
                                  state.password.isNotEmpty,
                              onPressed: cubit.submitLogin,
                            ),

                            const SizedBox(height: AppSpacing.s16),

                            // OTP Login Alternative
                            OutlinedButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => OtpScreen(
                                      phoneNumber: state.phone.isNotEmpty
                                          ? state.phone
                                          : '01012345678',
                                    ),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: AppColors.surfaceIndigoTint,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: AppRadius.radiusMd,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              icon: const Icon(
                                Icons.sms_outlined,
                                size: 18,
                                color: AppColors.brandIndigoDeep,
                              ),
                              label: const Text(
                                'تسجيل سريع عبر كود SMS (OTP)',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.brandIndigoDeep,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s24),

                      // Footer: Register Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'معندكش حساب؟ ',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textMuted,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const ChooseRoleScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'إنشاء حساب جديد',
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
}
