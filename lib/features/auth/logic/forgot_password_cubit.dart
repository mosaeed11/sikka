import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(const ForgotPasswordState());

  void phoneChanged(String value) {
    final cleanValue = value.trim();
    String? error;
    if (cleanValue.isNotEmpty && !_isValidEgyptianPhone(cleanValue)) {
      error = 'رقم موبايل مصري غير صحيح';
    }
    emit(state.copyWith(
      phone: cleanValue,
      phoneError: error,
      clearErrors: error == null && state.errorMessage != null,
    ));
  }

  void newPasswordChanged(String value) {
    String? error;
    if (value.isNotEmpty && value.length < 6) {
      error = 'كلمة المرور يجب أن تتكون من 6 أحرف على الأقل';
    }
    final strength = _calculatePasswordStrength(value);

    String? confirmErr = state.confirmPasswordError;
    if (state.confirmPassword.isNotEmpty && value != state.confirmPassword) {
      confirmErr = 'كلمتا المرور غير متطابقتين';
    } else if (state.confirmPassword.isNotEmpty && value == state.confirmPassword) {
      confirmErr = null;
    }

    emit(state.copyWith(
      newPassword: value,
      passwordError: error,
      confirmPasswordError: confirmErr,
      passwordStrength: strength,
    ));
  }

  void confirmPasswordChanged(String value) {
    String? error;
    if (value.isNotEmpty && value != state.newPassword) {
      error = 'كلمتا المرور غير متطابقتين';
    }
    emit(state.copyWith(
      confirmPassword: value,
      confirmPasswordError: error,
    ));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
  }

  Future<void> submitPhone() async {
    final phone = state.phone.trim();
    if (phone.isEmpty) {
      emit(state.copyWith(phoneError: 'رقم الموبايل مطلوب'));
      return;
    }
    if (!_isValidEgyptianPhone(phone)) {
      emit(state.copyWith(phoneError: 'رقم الموبايل غير صحيح'));
      return;
    }

    emit(state.copyWith(isLoading: true, clearErrors: true));

    await Future.delayed(const Duration(milliseconds: 600));

    emit(state.copyWith(
      isLoading: false,
      step: ForgotPasswordStep.resetPassword,
      // Seed initial strong password from Figma preview: Sikka2025*Cairo
      newPassword: 'Sikka2025*Cairo',
      confirmPassword: 'Sikka2025*Cairo',
      passwordStrength: 1.0,
    ));
  }

  Future<void> submitNewPassword() async {
    final newPass = state.newPassword;
    final confirm = state.confirmPassword;

    String? passErr = newPass.isEmpty
        ? 'كلمة المرور مطلوبة'
        : (newPass.length < 6
            ? 'كلمة المرور يجب أن تتكون من 6 أحرف على الأقل'
            : null);
    String? confirmErr = confirm.isEmpty
        ? 'تأكيد كلمة المرور مطلوب'
        : (newPass != confirm
            ? 'كلمتا المرور غير متطابقتين'
            : null);

    if (passErr != null || confirmErr != null) {
      emit(state.copyWith(
        passwordError: passErr,
        confirmPasswordError: confirmErr,
      ));
      return;
    }

    emit(state.copyWith(isLoading: true, clearErrors: true));

    await Future.delayed(const Duration(milliseconds: 700));

    emit(state.copyWith(
      isLoading: false,
      step: ForgotPasswordStep.success,
      isSuccess: true,
    ));
  }

  void backToPhone() {
    emit(state.copyWith(
      step: ForgotPasswordStep.phoneRequest,
      clearErrors: true,
    ));
  }

  double _calculatePasswordStrength(String password) {
    if (password.isEmpty) return 0.0;
    if (password.length < 6) return 0.25;
    double strength = 0.4;
    if (password.length >= 8) strength += 0.2;
    if (RegExp(r'[A-Z]').hasMatch(password) && RegExp(r'[a-z]').hasMatch(password)) {
      strength += 0.2;
    }
    if (RegExp(r'[0-9]').hasMatch(password)) {
      strength += 0.1;
    }
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      strength += 0.1;
    }
    return strength.clamp(0.0, 1.0);
  }

  bool _isValidEgyptianPhone(String phone) {
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 11 && digits.startsWith('01')) {
      return true;
    }
    if (digits.length == 10 && digits.startsWith('1')) {
      return true;
    }
    return false;
  }
}
