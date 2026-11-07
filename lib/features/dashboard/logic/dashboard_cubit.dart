import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../presentation/dashboard_screen.dart';
import '../presentation/finance_screen.dart';
import '../presentation/rides_screen.dart';
import '../presentation/verification_screen.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({int initialNavIndex = 0})
      : super(DashboardState(selectedNavIndex: initialNavIndex));

  void changeNavIndex(BuildContext context, int index) {
    if (state.selectedNavIndex == index) return;

    emit(state.copyWith(selectedNavIndex: index));

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const VerificationScreen()),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RidesScreen()),
      );
    } else if (index == 5) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const FinanceScreen()),
      );
    }
  }

  void selectApplicant(int index) {
    emit(state.copyWith(selectedApplicantIndex: index));
  }

  void changeVerificationTab(int tabIndex) {
    emit(state.copyWith(verificationTab: tabIndex));
  }

  void approveCaptain(BuildContext context, String captainName) {}

  void rejectCaptain(BuildContext context, String captainName) {}

  void inspectDocument(BuildContext context, String docTitle) {}

  void changeDebtorFilter(int filterIndex) {
    emit(state.copyWith(debtorFilterIndex: filterIndex));
  }

  void updateSearch(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void toggleLanguage(BuildContext context) {
    final nextLang = !state.isArabic;
    emit(state.copyWith(isArabic: nextLang));
  }

  void clickNotifications(BuildContext context) {}

  void clickExportInvoice(BuildContext context) {}

  void clickManualReconciliation(BuildContext context) {}

  void clickSendSms(BuildContext context) {}

  void clickReviewBlockList(BuildContext context) {}

  void clickDebtorAction(BuildContext context, String captainName, String action) {}

  void broadcastNotice(BuildContext context) {}

  void toggleHeatmap() {
    emit(state.copyWith(isHeatmapEnabled: !state.isHeatmapEnabled));
  }

  void refreshGrid(BuildContext context) {}

  void reviewAllVerifications(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const VerificationScreen()),
    );
  }

  void changeLiveRideFilter(int filterIndex) {
    emit(state.copyWith(liveRideFilterIndex: filterIndex));
  }

  void triggerBatchSettle(BuildContext context) {}

  void trackRide(BuildContext context, String rideId) {}

  void exportCsvLog(BuildContext context) {}

  void previousRidePage() {
    if (state.liveRidePage > 1) {
      emit(state.copyWith(liveRidePage: state.liveRidePage - 1));
    }
  }

  void nextRidePage() {
    emit(state.copyWith(liveRidePage: state.liveRidePage + 1));
  }

  void changeRideTab(int index) {
    emit(state.copyWith(ridesTab: index));
  }

  void updateCorridorSearch(String query) {
    emit(state.copyWith(corridorSearchQuery: query));
  }

  void filterByCorridor(String corridor) {
    emit(state.copyWith(selectedCorridorFilter: corridor));
  }

  void filterByPayment(String paymentMethod) {
    emit(state.copyWith(selectedPaymentFilter: paymentMethod));
  }

  void toggleDeviationFilter() {
    emit(state.copyWith(isDeviationFilterOnly: !state.isDeviationFilterOnly));
  }

  void clickRideDetails(BuildContext context, String rideId) {}

  void changeRidesPage(int page) {
    emit(state.copyWith(ridesCurrentPage: page));
  }
}
