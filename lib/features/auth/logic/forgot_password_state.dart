import 'package:equatable/equatable.dart';

enum ForgotPasswordStep {
  phoneRequest,
  resetPassword,
  success,
}

class ForgotPasswordState extends Equatable {
  final ForgotPasswordStep step;
  final String phone;
  final String? phoneError;
  final String newPassword;
  final String confirmPassword;
  final String? passwordError;
  final String? confirmPasswordError;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final double passwordStrength;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const ForgotPasswordState({
    this.step = ForgotPasswordStep.phoneRequest,
    this.phone = '',
    this.phoneError,
    this.newPassword = '',
    this.confirmPassword = '',
    this.passwordError,
    this.confirmPasswordError,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.passwordStrength = 0.0,
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  ForgotPasswordState copyWith({
    ForgotPasswordStep? step,
    String? phone,
    String? phoneError,
    String? newPassword,
    String? confirmPassword,
    String? passwordError,
    String? confirmPasswordError,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    double? passwordStrength,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    bool clearErrors = false,
  }) {
    return ForgotPasswordState(
      step: step ?? this.step,
      phone: phone ?? this.phone,
      phoneError: clearErrors ? null : (phoneError ?? this.phoneError),
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      passwordError: clearErrors ? null : (passwordError ?? this.passwordError),
      confirmPasswordError: clearErrors
          ? null
          : (confirmPasswordError ?? this.confirmPasswordError),
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      passwordStrength: passwordStrength ?? this.passwordStrength,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearErrors ? null : (errorMessage ?? this.errorMessage),
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
        step,
        phone,
        phoneError,
        newPassword,
        confirmPassword,
        passwordError,
        confirmPasswordError,
        isPasswordVisible,
        isConfirmPasswordVisible,
        passwordStrength,
        isLoading,
        errorMessage,
        isSuccess,
      ];
}
