import 'package:flutter_bloc/flutter_bloc.dart';
import 'finance_ui_state.dart';

class FinanceUiCubit extends Cubit<FinanceUiState> {
  FinanceUiCubit() : super(const FinanceUiState());

  void setTimeFilter(FinanceTimeFilter filter) {
    switch (filter) {
      case FinanceTimeFilter.today:
        emit(state.copyWith(
          timeFilter: filter,
          netEarnings: 320.0,
          grossEarnings: 355.0,
          completedRides: 3,
          sharedKm: 65,
        ));
        break;
      case FinanceTimeFilter.thisWeek:
        emit(state.copyWith(
          timeFilter: filter,
          netEarnings: 1850.0,
          grossEarnings: 2055.0,
          completedRides: 18,
          sharedKm: 340,
        ));
        break;
      case FinanceTimeFilter.thisMonth:
        emit(state.copyWith(
          timeFilter: filter,
          netEarnings: 6840.0,
          grossEarnings: 7600.0,
          completedRides: 64,
          sharedKm: 1280,
        ));
        break;
    }
  }

  /// Toggle suspension test mode for UI demonstration
  void toggleSuspensionForDemo(bool suspend) {
    if (suspend) {
      emit(state.copyWith(outstandingCommission: 320.0));
    } else {
      emit(state.copyWith(outstandingCommission: 140.0));
    }
  }

  /// Simulate settling commission
  Future<void> settleCommission() async {
    emit(state.copyWith(isSettling: true));
    await Future.delayed(const Duration(milliseconds: 700));
    emit(state.copyWith(
      isSettling: false,
      outstandingCommission: 0.0,
      isSettledSuccessfully: true,
    ));
  }

  void resetSettlementStatus() {
    emit(state.copyWith(isSettledSuccessfully: false));
  }
}
