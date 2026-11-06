import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_ui_state.dart';

class PaymentUiCubit extends Cubit<PaymentUiState> {
  PaymentUiCubit() : super(const PaymentUiState());

  void selectPaymentMethod(PaymentMethodType method) {
    emit(state.copyWith(selectedMethod: method));
  }

  void setUserRating(int rating) {
    emit(state.copyWith(userRating: rating.clamp(1, 5)));
  }

  Future<void> confirmCheckout() async {
    emit(state.copyWith(isProcessing: true));
    await Future.delayed(const Duration(milliseconds: 600));
    emit(state.copyWith(
      isProcessing: false,
      isConfirmed: true,
    ));
  }

  void resetConfirmation() {
    emit(state.copyWith(isConfirmed: false));
  }
}
