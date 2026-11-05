import 'package:equatable/equatable.dart';

const Object _sentinel = Object();

class LoginUiState extends Equatable {
  final String phone;
  final String password;
  final bool isPasswordVisible;
  final bool isLoading;
  final String? phoneError;
  final String? passwordError;
  final String? errorMessage;
  final bool isSuccess;
  final bool rememberMe;

  const LoginUiState({
    this.phone = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.isLoading = false,
    this.phoneError,
    this.passwordError,
    this.errorMessage,
    this.isSuccess = false,
    this.rememberMe = true,
  });

  bool get isFormValid =>
      phone.isNotEmpty &&
      password.isNotEmpty &&
      phoneError == null &&
      passwordError == null;

  LoginUiState copyWith({
    String? phone,
    String? password,
    bool? isPasswordVisible,
    bool? isLoading,
    Object? phoneError = _sentinel,
    Object? passwordError = _sentinel,
    Object? errorMessage = _sentinel,
    bool? isSuccess,
    bool? rememberMe,
    bool clearErrors = false,
  }) {
    return LoginUiState(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      phoneError: clearErrors
          ? null
          : (identical(phoneError, _sentinel)
              ? this.phoneError
              : phoneError as String?),
      passwordError: clearErrors
          ? null
          : (identical(passwordError, _sentinel)
              ? this.passwordError
              : passwordError as String?),
      errorMessage: clearErrors
          ? null
          : (identical(errorMessage, _sentinel)
              ? this.errorMessage
              : errorMessage as String?),
      isSuccess: isSuccess ?? this.isSuccess,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  List<Object?> get props => [
        phone,
        password,
        isPasswordVisible,
        isLoading,
        phoneError,
        passwordError,
        errorMessage,
        isSuccess,
        rememberMe,
      ];
}
