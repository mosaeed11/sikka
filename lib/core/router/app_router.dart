import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/logic/register_ui_state.dart';
import '../../features/auth/presentation/captain_verification_intro_screen.dart';
import '../../features/auth/presentation/choose_role_screen.dart';
import '../../features/auth/presentation/forgot_password_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/onboarding_screen.dart';
import '../../features/auth/presentation/otp_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/auth/presentation/vehicle_documents_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String chooseRole = '/choose-role';
  static const String register = '/register';
  static const String vehicleDocuments = '/vehicle-documents';
  static const String captainIntro = '/captain-intro';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgot-password';
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.chooseRole,
        builder: (context, state) {
          final role = state.extra as SikkaUserRole? ?? SikkaUserRole.passenger;
          return ChooseRoleScreen(initialRole: role);
        },
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) {
          final role = state.extra as SikkaUserRole? ?? SikkaUserRole.passenger;
          return RegisterScreen(initialRole: role);
        },
      ),
      GoRoute(
        path: AppRoutes.vehicleDocuments,
        builder: (context, state) => const VehicleDocumentsScreen(),
      ),
      GoRoute(
        path: AppRoutes.captainIntro,
        builder: (context, state) => const CaptainVerificationIntroScreen(),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) {
          final phone = state.extra as String? ?? '01012345678';
          return OtpScreen(phoneNumber: phone);
        },
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('المسار غير متوفر: ${state.uri}'),
      ),
    ),
  );
}
