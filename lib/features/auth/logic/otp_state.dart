import 'package:equatable/equatable.dart';

class OtpState extends Equatable {
  final List<String> digits;
  final int focusedIndex;
  final int secondsRemaining;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String phoneNumber;

  const OtpState({
    this.digits = const ['', '', '', '', '', ''],
    this.focusedIndex = 0,
    this.secondsRemaining = 48,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.phoneNumber = '01012345678',
  });

  bool get canResend => secondsRemaining == 0;
  bool get isComplete => digits.every((d) => d.isNotEmpty);
  String get otpCode => digits.join();

  OtpState copyWith({
    List<String>? digits,
    int? focusedIndex,
    int? secondsRemaining,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? phoneNumber,
    bool clearError = false,
  }) {
    return OtpState(
      digits: digits ?? this.digits,
      focusedIndex: focusedIndex ?? this.focusedIndex,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [
        digits,
        focusedIndex,
        secondsRemaining,
        isLoading,
        isSuccess,
        errorMessage,
        phoneNumber,
      ];
}
