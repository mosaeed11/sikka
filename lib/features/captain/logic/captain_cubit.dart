import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'captain_state.dart';

class CaptainCubit extends Cubit<CaptainState> {
  CaptainCubit() : super(CaptainState());

  void changeTab(int index) {
    if (index == 0) {
      emit(CaptainState(
        selectedTab: 0,
        badgeText: 'حالات معلقة',
        accountTitle: 'لسه حسابك مش متحقق',
        accountDescription:
            'لازم نراجع بياناتك ورخصتك قبل ما تبدأ مشاركة رحلاتك على الطريق عشان نضمن أمان كل الركاب',
        canCreateRide: false,
      ));
    } else if (index == 1) {
      emit(CaptainState(
        selectedTab: 1,
        badgeText: 'حساب موقوف',
        accountTitle: 'الحساب موقوف بسبب مديونية',
        accountDescription:
            'يرجى سداد المديونية المستحقة على الحساب لتتمكن من استئناف استقبال الرحلات بشكل طبيعي.',
        canCreateRide: false,
      ));
    } else if (index == 2) {
      emit(CaptainState(
        selectedTab: 2,
        badgeText: 'حالات الدفع',
        accountTitle: 'سجل ومتابعة المعاملات المالية',
        accountDescription:
            'يمكنك مراجعة جميع المدفوعات والتحصيلات والمستحقات الخاصة بحسابك من هنا.',
        canCreateRide: false,
      ));
    }
  }

  void clickBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  void clickUploadDocuments(BuildContext context) {}

  void clickCreateRide(BuildContext context) {}
}
