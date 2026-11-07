import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'booking_confirmation_state.dart';

class BookingConfirmationCubit extends Cubit<BookingConfirmationState> {
  BookingConfirmationCubit() : super(const BookingConfirmationState());

  void changeTab(int tabIndex) {
    emit(state.copyWith(selectedTab: tabIndex));
  }

  void keepTrip(BuildContext context) {}

  void confirmCancellation(BuildContext context) {}

  void retryBooking(BuildContext context) {}

  void contactSupport(BuildContext context) {}
}
