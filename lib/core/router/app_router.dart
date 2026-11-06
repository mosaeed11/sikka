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
import '../../features/captain/presentation/suspended_account_screen.dart';
import '../../features/captain/presentation/vehicle_screen.dart';
import '../../features/captain/presentation/verification_screen.dart';
import '../../features/notifications/presentation/notifications_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/profile/presentation/settings_screen.dart';
import '../../features/wallet/logic/payment_ui_state.dart';
import '../../features/wallet/presentation/earnings_screen.dart';
import '../../features/wallet/presentation/payment_confirmation_screen.dart';
import '../../features/wallet/presentation/payment_method_screen.dart';
import '../../features/wallet/presentation/ride_receipt_screen.dart';
import '../../features/wallet/presentation/wallet_screen.dart';

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
  static const String paymentMethod = '/payment-method';
  static const String paymentConfirmation = '/payment-confirmation';
  static const String rideReceipt = '/ride-receipt';
  static const String earningsDetails = '/earnings-details';
  static const String suspendedAccount = '/suspended-account';
  static const String vehicle = '/vehicle';
  static const String verification = '/verification';
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String wallet = '/wallet';
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



      // Payment Flow Routes
      GoRoute(
        path: AppRoutes.paymentMethod,
        builder: (context, state) => const PaymentMethodScreen(),
      ),
      GoRoute(
        path: AppRoutes.paymentConfirmation,
        builder: (context, state) {
          final method =
              state.extra as PaymentMethodType? ?? PaymentMethodType.cash;
          return PaymentConfirmationScreen(initialMethod: method);
        },
      ),
      GoRoute(
        path: AppRoutes.rideReceipt,
        builder: (context, state) {
          final data = state.extra as PaymentUiState?;
          return RideReceiptScreen(initialData: data);
        },
      ),

      // Captain Finance & Earnings Routes
      GoRoute(
        path: AppRoutes.wallet,
        builder: (context, state) => const WalletScreen(showAppBar: true),
      ),
      GoRoute(
        path: AppRoutes.earningsDetails,
        builder: (context, state) => const EarningsScreen(),
      ),
      GoRoute(
        path: AppRoutes.suspendedAccount,
        builder: (context, state) => const SuspendedAccountScreen(),
      ),

      // Profile & Role Routes
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(showAppBar: true),
      ),
      GoRoute(
        path: AppRoutes.vehicle,
        builder: (context, state) => const VehicleScreen(),
      ),
      GoRoute(
        path: AppRoutes.verification,
        builder: (context, state) => const VerificationScreen(),
      ),

      // Notifications & Settings Routes
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('المسار غير متوفر: ${state.uri}'),
      ),
    ),
  );
}
