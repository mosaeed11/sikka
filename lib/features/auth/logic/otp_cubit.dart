import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  Timer? _timer;

  OtpCubit({String? phoneNumber})
      : super(OtpState(
          phoneNumber: phoneNumber ?? '01012345678',
          // Seed with Figma's 4 digits preview: 4, 9, 2, 1
          digits: const ['4', '9', '2', '1', '', ''],
          focusedIndex: 4,
        )) {
    startCountdown();
  }

  void startCountdown() {
    _timer?.cancel();
    emit(state.copyWith(secondsRemaining: 48));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining > 0) {
        emit(state.copyWith(secondsRemaining: state.secondsRemaining - 1));
      } else {
        timer.cancel();
      }
    });
  }

  void digitEntered(int index, String digit) {
    if (digit.isEmpty || digit.length > 1) return;
    final newDigits = List<String>.from(state.digits);
    newDigits[index] = digit;

    int nextIndex = index + 1;
    if (nextIndex >= 6) nextIndex = 5;

    emit(state.copyWith(
      digits: newDigits,
      focusedIndex: nextIndex,
      clearError: true,
    ));

    if (newDigits.every((d) => d.isNotEmpty)) {
      verifyOtp();
    }
  }

  void onKeypadNumberPressed(String number) {
    final newDigits = List<String>.from(state.digits);
    // Find first empty slot, or replace at focusedIndex
    int targetIndex = state.focusedIndex;
    if (targetIndex < 6) {
      newDigits[targetIndex] = number;
      int next = targetIndex + 1;
      if (next >= 6) next = 5;
      emit(state.copyWith(
        digits: newDigits,
        focusedIndex: next,
        clearError: true,
      ));

      if (newDigits.every((d) => d.isNotEmpty)) {
        verifyOtp();
      }
    }
  }

  void onKeypadBackspacePressed() {
    final newDigits = List<String>.from(state.digits);
    int targetIndex = state.focusedIndex;

    // If current index has a digit, clear it
    if (newDigits[targetIndex].isNotEmpty) {
      newDigits[targetIndex] = '';
      emit(state.copyWith(digits: newDigits, clearError: true));
    } else if (targetIndex > 0) {
      // Otherwise move back and clear previous
      targetIndex = targetIndex - 1;
      newDigits[targetIndex] = '';
      emit(state.copyWith(
        digits: newDigits,
        focusedIndex: targetIndex,
        clearError: true,
      ));
    }
  }

  void setFocusedIndex(int index) {
    if (index >= 0 && index < 6) {
      emit(state.copyWith(focusedIndex: index));
    }
  }

  void resendCode() {
    if (!state.canResend) return;
    startCountdown();
  }

  Future<void> verifyOtp() async {
    if (!state.isComplete) {
      emit(state.copyWith(errorMessage: 'من فضلك أدخل كود التحقق المكون من 6 أرقام'));
      return;
    }

    emit(state.copyWith(isLoading: true, clearError: true));

    await Future.delayed(const Duration(milliseconds: 700));

    emit(state.copyWith(
      isLoading: false,
      isSuccess: true,
    ));
  }

  void resetSuccess() {
    emit(state.copyWith(isSuccess: false));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
