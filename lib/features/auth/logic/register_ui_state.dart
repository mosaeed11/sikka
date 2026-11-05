import 'package:equatable/equatable.dart';
import '../../../core/utils/validators.dart';

enum SikkaUserRole {
  passenger,
  captain,
}

const Object _sentinel = Object();

class RegisterUiState extends Equatable {
  final String fullName;
  final String phone;
  final String email;
  final String password;
  final String confirmPassword;
  final SikkaUserRole role;
  final bool agreeToTerms;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool isLoading;
  final String? nameError;
  final String? phoneError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final String? termsError;
  final double passwordStrength;
  final bool isSuccess;
  final String? errorMessage;

  const RegisterUiState({
    this.fullName = '',
    this.phone = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.role = SikkaUserRole.passenger,
    this.agreeToTerms = true,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.isLoading = false,
    this.nameError,
    this.phoneError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.termsError,
    this.passwordStrength = 0.0,
    this.isSuccess = false,
    this.errorMessage,
  });

  bool get areRequiredFieldsFilled =>
      fullName.trim().isNotEmpty &&
      phone.trim().isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      agreeToTerms;

  bool get isFormValid =>
      Validators.isValidFullName(fullName) &&
      Validators.isValidEgyptianPhone(phone) &&
      Validators.isValidEmail(email) &&
      Validators.isValidPassword(password) &&
      Validators.doPasswordsMatch(password, confirmPassword) &&
      agreeToTerms &&
      nameError == null &&
      phoneError == null &&
      emailError == null &&
      passwordError == null &&
      confirmPasswordError == null &&
      termsError == null;

  RegisterUiState copyWith({
    String? fullName,
    String? phone,
    String? email,
    String? password,
    String? confirmPassword,
    SikkaUserRole? role,
    bool? agreeToTerms,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? isLoading,
    Object? nameError = _sentinel,
    Object? phoneError = _sentinel,
    Object? emailError = _sentinel,
    Object? passwordError = _sentinel,
    Object? confirmPasswordError = _sentinel,
    Object? termsError = _sentinel,
    double? passwordStrength,
    bool? isSuccess,
    Object? errorMessage = _sentinel,
    bool clearErrors = false,
  }) {
    return RegisterUiState(
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      role: role ?? this.role,
      agreeToTerms: agreeToTerms ?? this.agreeToTerms,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      nameError: clearErrors
          ? null
          : (identical(nameError, _sentinel)
              ? this.nameError
              : nameError as String?),
      phoneError: clearErrors
          ? null
          : (identical(phoneError, _sentinel)
              ? this.phoneError
              : phoneError as String?),
      emailError: clearErrors
          ? null
          : (identical(emailError, _sentinel)
              ? this.emailError
              : emailError as String?),
      passwordError: clearErrors
          ? null
          : (identical(passwordError, _sentinel)
              ? this.passwordError
              : passwordError as String?),
      confirmPasswordError: clearErrors
          ? null
          : (identical(confirmPasswordError, _sentinel)
              ? this.confirmPasswordError
              : confirmPasswordError as String?),
      termsError: clearErrors
          ? null
          : (identical(termsError, _sentinel)
              ? this.termsError
              : termsError as String?),
      passwordStrength: passwordStrength ?? this.passwordStrength,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: clearErrors
          ? null
          : (identical(errorMessage, _sentinel)
              ? this.errorMessage
              : errorMessage as String?),
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        phone,
        email,
        password,
        confirmPassword,
        role,
        agreeToTerms,
        isPasswordVisible,
        isConfirmPasswordVisible,
        isLoading,
        nameError,
        phoneError,
        emailError,
        passwordError,
        confirmPasswordError,
        termsError,
        passwordStrength,
        isSuccess,
        errorMessage,
      ];
}
