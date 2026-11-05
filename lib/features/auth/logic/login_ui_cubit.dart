import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_ui_state.dart';

class LoginUiCubit extends Cubit<LoginUiState> {
  LoginUiCubit() : super(const LoginUiState());

  void phoneChanged(String value) {
    final cleanValue = value.trim();
    String? error;
    if (cleanValue.isNotEmpty) {
      if (!_isValidEgyptianPhone(cleanValue)) {
        error = 'من فضلك أدخل رقم موبايل مصري صحيح (مثال: 01012345678)';
      }
    }
    emit(state.copyWith(
      phone: cleanValue,
      phoneError: error,
      clearErrors: error == null && state.errorMessage != null,
    ));
  }

  void passwordChanged(String value) {
    String? error;
    if (value.isNotEmpty && value.length < 6) {
      error = 'كلمة المرور يجب ألا تقل عن 6 أحرف';
    }
    emit(state.copyWith(
      password: value,
      passwordError: error,
      clearErrors: error == null && state.errorMessage != null,
    ));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleRememberMe() {
    emit(state.copyWith(rememberMe: !state.rememberMe));
  }

  Future<void> submitLogin() async {
    final phone = state.phone.trim();
    final password = state.password;

    String? phoneErr;
    String? passErr;

    if (phone.isEmpty) {
      phoneErr = 'رقم الموبايل مطلوب';
    } else if (!_isValidEgyptianPhone(phone)) {
      phoneErr = 'رقم الموبايل غير صحيح';
    }

    if (password.isEmpty) {
      passErr = 'كلمة المرور مطلوبة';
    } else if (password.length < 6) {
      passErr = 'كلمة المرور يجب ألا تقل عن 6 أحرف';
    }

    if (phoneErr != null || passErr != null) {
      emit(state.copyWith(
        phoneError: phoneErr,
        passwordError: passErr,
        isLoading: false,
      ));
      return;
    }

    emit(state.copyWith(isLoading: true, clearErrors: true));

    // Simulate local UI operation
    await Future.delayed(const Duration(milliseconds: 700));

    emit(state.copyWith(
      isLoading: false,
      isSuccess: true,
    ));
  }

  void resetSuccess() {
    emit(state.copyWith(isSuccess: false));
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
