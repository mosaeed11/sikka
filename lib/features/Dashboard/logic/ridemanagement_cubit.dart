import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ridemanagment_state.dart';

class SikkaRidesCubit extends Cubit<SikkaRidesState> {
  SikkaRidesCubit()
    : super(
        SikkaRidesLoaded(
          isRtl: true,
          selectedTab: 'Active (342)',
          rides: [
            SikkaRide(
              id: '#SK-8241',
              route:
                  'Ring Road Hub → تجمع الخامس (شارع التسعين) ← خارو المعادي',
              captain: 'نيسان صني • أحمد فوزي (⭐ 4.9)',
              departure: 'اليوم 08:30 ص',
              seats: '3 / 4 مقاعد محجوزة',
              price: '150 ج.م إجمالي',
              deviation: '0',
              payment: 'كاش بالسیم',
              status: 'في الموعد (On Schedule)',
              statusColor: Colors.green,
            ),
            SikkaRide(
              id: '#SK-8242',
              route: 'جنان لبنان المهندسين → هايبر وان زايد',
              captain: 'سيراتو أولد • محمود أيمن (⭐ 4.96)',
              departure: 'اليوم 08:45 ص',
              seats: 'اكتملت المقاعد (4/4)',
              price: '180 ج.م إجمالي',
              deviation: '+1.4 กม',
              payment: '(SIKKA Pay)',
              status: 'تحركت قبل 12 دقيقة',
              statusColor: Colors.orange,
            ),
            SikkaRide(
              id: '#SK-8243',
              route: 'Tech Corridor → قرية الذكية (البوابة 1) ← حصري 6 أكتوبر',
              captain: 'ميرسيدس C200 • أسامة كحلي (⭐ 4.88)',
              departure: 'اليوم 09:15 ص',
              seats: '2 / 2 مقاعد محجوزة',
              price: '210 ج.م إجمالي',
              deviation: '0',
              payment: 'محفظة',
              status: 'تبدأ خلال 30 دقيقة',
              statusColor: Colors.blue,
            ),
            SikkaRide(
              id: '#SK-8244',
              route: 'جامعة الأمريكية AUC → سيتي ستارز مدينة نصر',
              captain: 'تويوتا كورولا • كريم محمود (⭐ 5.0)',
              departure: 'اليوم 08:15 ص',
              seats: '3 / 3 مقاعد مكتملة',
              price: '95 ج.م إجمالي',
              deviation: '0',
              payment: 'كاش مسجل (3 ركاب)',
              status: 'مكتملة العدد',
              statusColor: Colors.amber.shade800,
            ),
            SikkaRide(
              id: '#SK-8245',
              route: 'East Cairo Line → مدينة الشروق (مدخل 2) ← خطة مدلي منصور',
              captain: 'رينو ميجان • عادل ممدوح (⭐ 4.92)',
              departure: 'اليوم 09:30 ص',
              seats: '4 / 4 مقاعد محجوزة',
              price: '160 ج.م إجمالي',
              deviation: '0',
              payment: 'محفظة',
              status: 'مجدولة لاحقاً',
              statusColor: Colors.purple,
            ),
          ],
        ),
      );

  void toggleLanguage() {
    if (state is SikkaRidesLoaded) {
      final currentState = state as SikkaRidesLoaded;
      emit(currentState.copyWith(isRtl: !currentState.isRtl));
    }
  }

  void changeTab(String tab) {
    if (state is SikkaRidesLoaded) {
      final currentState = state as SikkaRidesLoaded;
      emit(currentState.copyWith(selectedTab: tab));
    }
  }
}
