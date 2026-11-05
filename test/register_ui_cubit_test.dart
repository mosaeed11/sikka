import 'package:flutter_test/flutter_test.dart';
import 'package:sikka/features/auth/logic/register_ui_cubit.dart';
import 'package:sikka/features/auth/logic/register_ui_state.dart';

void main() {
  group('RegisterUiCubit Tests', () {
    late RegisterUiCubit cubit;

    setUp(() {
      cubit = RegisterUiCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state has default values and passenger role', () {
      expect(cubit.state.fullName, isEmpty);
      expect(cubit.state.phone, isEmpty);
      expect(cubit.state.role, SikkaUserRole.passenger);
      expect(cubit.state.agreeToTerms, isTrue);
      expect(cubit.state.nameError, isNull);
      expect(cubit.state.phoneError, isNull);
      expect(cubit.state.isFormValid, isFalse);
    });

    test('typing does NOT trigger errors immediately', () {
      cubit.fullNameChanged('أ');
      expect(cubit.state.fullName, 'أ');
      expect(cubit.state.nameError, isNull);

      cubit.phoneChanged('010');
      expect(cubit.state.phone, '010');
      expect(cubit.state.phoneError, isNull);

      cubit.passwordChanged('123');
      expect(cubit.state.password, '123');
      expect(cubit.state.passwordError, isNull);

      cubit.confirmPasswordChanged('12');
      expect(cubit.state.confirmPassword, '12');
      expect(cubit.state.confirmPasswordError, isNull);
    });

    test('submit with invalid inputs sets errors and halts loading', () async {
      await cubit.submitRegister();

      expect(cubit.state.nameError, isNotNull);
      expect(cubit.state.phoneError, isNotNull);
      expect(cubit.state.passwordError, isNotNull);
      expect(cubit.state.confirmPasswordError, isNotNull);
      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.isSuccess, isFalse);
      expect(cubit.state.isFormValid, isFalse);
    });

    test('typing valid data into an errored field clears error immediately', () async {
      // Trigger errors by attempting to submit empty form
      await cubit.submitRegister();
      expect(cubit.state.nameError, isNotNull);
      expect(cubit.state.phoneError, isNotNull);

      // Typing incomplete name keeps error
      cubit.fullNameChanged('أحمد');
      expect(cubit.state.nameError, isNotNull);

      // Typing full 2-word name clears error immediately
      cubit.fullNameChanged('أحمد علي');
      expect(cubit.state.nameError, isNull);

      // Typing invalid phone keeps error
      cubit.phoneChanged('010123');
      expect(cubit.state.phoneError, isNotNull);

      // Typing complete Egyptian phone clears error immediately
      cubit.phoneChanged('01012345678');
      expect(cubit.state.phoneError, isNull);
    });

    test('complete valid form enables isFormValid and succeeds on submit', () async {
      cubit.fullNameChanged('محمد أحمد');
      cubit.phoneChanged('01110057671');
      cubit.emailChanged('mohammed@example.com');
      cubit.passwordChanged('password123');
      cubit.confirmPasswordChanged('password123');

      expect(cubit.state.areRequiredFieldsFilled, isTrue);
      expect(cubit.state.isFormValid, isTrue);

      await cubit.submitRegister();
      expect(cubit.state.isSuccess, isTrue);
    });

    test('role selection toggles properly between passenger and captain', () {
      expect(cubit.state.role, SikkaUserRole.passenger);
      cubit.roleChanged(SikkaUserRole.captain);
      expect(cubit.state.role, SikkaUserRole.captain);
      cubit.roleChanged(SikkaUserRole.passenger);
      expect(cubit.state.role, SikkaUserRole.passenger);
    });
  });
}
