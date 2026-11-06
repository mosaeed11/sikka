import 'package:flutter_test/flutter_test.dart';
import 'package:sikka/features/wallet/logic/payment_ui_cubit.dart';
import 'package:sikka/features/wallet/logic/payment_ui_state.dart';
import 'package:sikka/features/wallet/logic/finance_ui_cubit.dart';
import 'package:sikka/features/wallet/logic/finance_ui_state.dart';
import 'package:sikka/features/profile/logic/profile_ui_cubit.dart';
import 'package:sikka/features/auth/logic/register_ui_state.dart';

void main() {
  group('PaymentUiCubit Tests', () {
    late PaymentUiCubit cubit;

    setUp(() {
      cubit = PaymentUiCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state has default fair pricing and cash payment', () {
      expect(cubit.state.selectedMethod, PaymentMethodType.cash);
      expect(cubit.state.totalFare, 70.0);
      expect(cubit.state.isProcessing, isFalse);
      expect(cubit.state.isConfirmed, isFalse);
    });

    test('switching payment methods updates state', () {
      cubit.selectPaymentMethod(PaymentMethodType.digitalWallet);
      expect(cubit.state.selectedMethod, PaymentMethodType.digitalWallet);

      cubit.selectPaymentMethod(PaymentMethodType.cash);
      expect(cubit.state.selectedMethod, PaymentMethodType.cash);
    });

    test('confirmCheckout processes and confirms payment', () async {
      final future = cubit.confirmCheckout();
      expect(cubit.state.isProcessing, isTrue);

      await future;

      expect(cubit.state.isProcessing, isFalse);
      expect(cubit.state.isConfirmed, isTrue);
    });
  });

  group('FinanceUiCubit Tests', () {
    late FinanceUiCubit cubit;

    setUp(() {
      cubit = FinanceUiCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initializes with verified 10% platform commission and 90% captain retention', () {
      expect(cubit.state.commissionRate, 0.10);
      expect(cubit.state.captainRetentionRate, 0.90);
      expect(cubit.state.maxAllowedDebtThreshold, 250.0);
      expect(cubit.state.isSuspended, isFalse); // default 140 <= 250
    });

    test('switching time filters updates earnings metrics', () {
      cubit.setTimeFilter(FinanceTimeFilter.today);
      expect(cubit.state.timeFilter, FinanceTimeFilter.today);
      expect(cubit.state.netEarnings, 320.0);

      cubit.setTimeFilter(FinanceTimeFilter.thisMonth);
      expect(cubit.state.timeFilter, FinanceTimeFilter.thisMonth);
      expect(cubit.state.netEarnings, 6840.0);
    });

    test('suspension trigger when debt exceeds threshold', () {
      cubit.toggleSuspensionForDemo(true);
      expect(cubit.state.outstandingCommission, 320.0);
      expect(cubit.state.isSuspended, isTrue); // 320 > 250 threshold
    });

    test('settling commission clears outstanding balance', () async {
      cubit.toggleSuspensionForDemo(true);
      expect(cubit.state.isSuspended, isTrue);

      await cubit.settleCommission();

      expect(cubit.state.outstandingCommission, 0.0);
      expect(cubit.state.isSuspended, isFalse);
      expect(cubit.state.isSettledSuccessfully, isTrue);
    });
  });

  group('ProfileUiCubit Tests', () {
    late ProfileUiCubit cubit;

    setUp(() {
      cubit = ProfileUiCubit(initialRole: SikkaUserRole.passenger);
    });

    tearDown(() {
      cubit.close();
    });

    test('initial role is passenger when initialized as passenger', () {
      expect(cubit.state.activeRole, SikkaUserRole.passenger);
      expect(cubit.state.isCaptain, isFalse);
    });

    test('switchRole changes role between passenger and captain', () {
      cubit.switchRole(SikkaUserRole.captain);
      expect(cubit.state.activeRole, SikkaUserRole.captain);
      expect(cubit.state.isCaptain, isTrue);

      cubit.switchRole(SikkaUserRole.passenger);
      expect(cubit.state.activeRole, SikkaUserRole.passenger);
      expect(cubit.state.isCaptain, isFalse);
    });

    test('updateName updates full name in state', () {
      cubit.updateName('محمود حسن');
      expect(cubit.state.fullName, 'محمود حسن');
    });
  });
}
