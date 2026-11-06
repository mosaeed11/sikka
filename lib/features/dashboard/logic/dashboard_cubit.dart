import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../presentation/finance_screen.dart';
import '../presentation/verification_screen.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({int initialNavIndex = 5})
      : super(DashboardState(selectedNavIndex: initialNavIndex));

  void changeNavIndex(BuildContext context, int index) {
    if (state.selectedNavIndex == index) return;

    emit(state.copyWith(selectedNavIndex: index));

    if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const VerificationScreen()),
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
}
