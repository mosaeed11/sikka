import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/validators.dart';
import 'register_ui_state.dart';

class RegisterUiCubit extends Cubit<RegisterUiState> {
  RegisterUiCubit({SikkaUserRole initialRole = SikkaUserRole.passenger})
      : super(RegisterUiState(role: initialRole));

  /// Called on full name input change.
  /// Rule: Do not display errors immediately when a user starts typing.
  /// If an error is already showing, clear it immediately once the input becomes valid.
  void fullNameChanged(String value) {
    String? error = state.nameError;
    if (error != null) {
      if (Validators.isValidFullName(value)) {
        error = null;
      }
    }
    emit(state.copyWith(
      fullName: value,
      nameError: error,
    ));
  }

  /// Called on Egyptian phone input change.
  /// Rule: Do not display errors immediately while typing.
  /// Once valid, clear previous error immediately.
  void phoneChanged(String value) {
    final cleanValue = value.trim();
    String? error = state.phoneError;
    if (error != null) {
      if (Validators.isValidEgyptianPhone(cleanValue)) {
        error = null;
      }
    }
    emit(state.copyWith(
      phone: cleanValue,
      phoneError: error,
    ));
  }

  /// Called on email input change (optional field in Sikka).
  /// Once valid or empty, clear previous error immediately.
  void emailChanged(String value) {
    final cleanValue = value.trim();
    String? error = state.emailError;
    if (error != null) {
      if (Validators.isValidEmail(cleanValue, isOptional: true)) {
        error = null;
      }
    }
    emit(state.copyWith(
      email: cleanValue,
      emailError: error,
    ));
  }

  /// Called on password input change.
  /// Updates password strength indicator.
  /// If previous passwordError was showing and now valid, clear it.
  /// If previous confirmPasswordError was showing and now matches, clear it.
  void passwordChanged(String value) {
    String? passError = state.passwordError;
    if (passError != null && Validators.isValidPassword(value)) {
      passError = null;
    }

    final strength = Validators.calculatePasswordStrength(value);

    String? confirmErr = state.confirmPasswordError;
    if (confirmErr != null &&
        Validators.doPasswordsMatch(value, state.confirmPassword)) {
      confirmErr = null;
    }

    emit(state.copyWith(
      password: value,
      passwordError: passError,
      confirmPasswordError: confirmErr,
      passwordStrength: strength,
    ));
  }

  /// Called on confirm password input change.
  /// Once matching, clear previous error immediately.
  void confirmPasswordChanged(String value) {
    String? error = state.confirmPasswordError;
    if (error != null &&
        Validators.doPasswordsMatch(state.password, value)) {
      error = null;
    }
    emit(state.copyWith(
      confirmPassword: value,
      confirmPasswordError: error,
    ));
  }

  /// Validate individual field when user submits or leaves the field.
  void validateFullName() {
    emit(state.copyWith(nameError: Validators.validateFullName(state.fullName)));
  }

  void validatePhone() {
    emit(state.copyWith(phoneError: Validators.validatePhone(state.phone)));
  }

  void validateEmail() {
    emit(state.copyWith(
      emailError: Validators.validateEmail(state.email, isOptional: true),
    ));
  }

  void validatePassword() {
    emit(state.copyWith(
      passwordError: Validators.validatePassword(state.password),
    ));
  }

  void validateConfirmPassword() {
    emit(state.copyWith(
      confirmPasswordError: Validators.validateConfirmPassword(
        state.password,
        state.confirmPassword,
      ),
    ));
  }

  void roleChanged(SikkaUserRole role) {
    emit(state.copyWith(role: role));
  }

  void toggleTerms(bool? value) {
    final bool agreed = value ?? false;
    emit(state.copyWith(
      agreeToTerms: agreed,
      termsError: agreed ? null : 'يجب الموافقة على الشروط للمتابعة',
    ));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(
      isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
    ));
  }

  /// Full form submission validation
  Future<void> submitRegister() async {
    final nameErr = Validators.validateFullName(state.fullName);
    final phoneErr = Validators.validatePhone(state.phone);
    final emailErr = Validators.validateEmail(state.email, isOptional: true);
    final passErr = Validators.validatePassword(state.password);
    final confirmErr = Validators.validateConfirmPassword(
      state.password,
      state.confirmPassword,
    );
    final termsErr =
        state.agreeToTerms ? null : 'يجب الموافقة على شروط الاستخدام للمتابعة';

    if (nameErr != null ||
        phoneErr != null ||
        emailErr != null ||
        passErr != null ||
        confirmErr != null ||
        termsErr != null) {
      emit(state.copyWith(
        nameError: nameErr,
        phoneError: phoneErr,
        emailError: emailErr,
        passwordError: passErr,
        confirmPasswordError: confirmErr,
        termsError: termsErr,
        isLoading: false,
      ));
      return;
    }

    emit(state.copyWith(isLoading: true, clearErrors: true));

    // Simulated short local validation delay
    await Future.delayed(const Duration(milliseconds: 600));

    emit(state.copyWith(
      isLoading: false,
      isSuccess: true,
    ));
  }

  void resetSuccess() {
    emit(state.copyWith(isSuccess: false));
  }
}
