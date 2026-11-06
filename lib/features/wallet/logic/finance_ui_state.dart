import 'package:equatable/equatable.dart';

enum FinanceTimeFilter {
  today,
  thisWeek,
  thisMonth,
}

class FinanceTripLedgerItem extends Equatable {
  final String id;
  final String routeTitle;
  final String dateText;
  final double grossFare;
  final double commissionDeducted;
  final bool isSettled;

  const FinanceTripLedgerItem({
    required this.id,
    required this.routeTitle,
    required this.dateText,
    required this.grossFare,
    required this.commissionDeducted,
    this.isSettled = false,
  });

  @override
  List<Object?> get props => [
        id,
        routeTitle,
        dateText,
        grossFare,
        commissionDeducted,
        isSettled,
      ];
}

class FinanceUiState extends Equatable {
  final FinanceTimeFilter timeFilter;
  final double netEarnings;
  final double grossEarnings;
  final double outstandingCommission;
  final double maxAllowedDebtThreshold;
  final int completedRides;
  final int sharedKm;
  final double commissionRate; // 10%
  final double captainRetentionRate; // 90%
  final List<FinanceTripLedgerItem> recentTrips;
  final bool isSettling;
  final bool isSettledSuccessfully;

  const FinanceUiState({
    this.timeFilter = FinanceTimeFilter.thisWeek,
    this.netEarnings = 1850.0,
    this.grossEarnings = 2055.0,
    this.outstandingCommission = 140.0,
    this.maxAllowedDebtThreshold = 250.0,
    this.completedRides = 18,
    this.sharedKm = 340,
    this.commissionRate = 0.10, // 10%
    this.captainRetentionRate = 0.90, // 90%
    this.recentTrips = const [
      FinanceTripLedgerItem(
        id: 'SK-TX-101',
        routeTitle: 'المعادي ➔ التجمع الخامس',
        dateText: 'اليوم، ٨:٣٠ ص',
        grossFare: 150.0,
        commissionDeducted: 15.0,
        isSettled: false,
      ),
      FinanceTripLedgerItem(
        id: 'SK-TX-102',
        routeTitle: 'الشيخ زايد ➔ القرية الذكية',
        dateText: 'أمس، ٧:٤٥ ص',
        grossFare: 90.0,
        commissionDeducted: 9.0,
        isSettled: false,
      ),
      FinanceTripLedgerItem(
        id: 'SK-TX-103',
        routeTitle: 'مدينة نصر ➔ المعادي',
        dateText: 'الثلاثاء، ٥:١٥ م',
        grossFare: 80.0,
        commissionDeducted: 8.0,
        isSettled: true,
      ),
    ],
    this.isSettling = false,
    this.isSettledSuccessfully = false,
  });

  bool get isSuspended => outstandingCommission > maxAllowedDebtThreshold;

  FinanceUiState copyWith({
    FinanceTimeFilter? timeFilter,
    double? netEarnings,
    double? grossEarnings,
    double? outstandingCommission,
    double? maxAllowedDebtThreshold,
    int? completedRides,
    int? sharedKm,
    double? commissionRate,
    double? captainRetentionRate,
    List<FinanceTripLedgerItem>? recentTrips,
    bool? isSettling,
    bool? isSettledSuccessfully,
  }) {
    return FinanceUiState(
      timeFilter: timeFilter ?? this.timeFilter,
      netEarnings: netEarnings ?? this.netEarnings,
      grossEarnings: grossEarnings ?? this.grossEarnings,
      outstandingCommission:
          outstandingCommission ?? this.outstandingCommission,
      maxAllowedDebtThreshold:
          maxAllowedDebtThreshold ?? this.maxAllowedDebtThreshold,
      completedRides: completedRides ?? this.completedRides,
      sharedKm: sharedKm ?? this.sharedKm,
      commissionRate: commissionRate ?? this.commissionRate,
      captainRetentionRate: captainRetentionRate ?? this.captainRetentionRate,
      recentTrips: recentTrips ?? this.recentTrips,
      isSettling: isSettling ?? this.isSettling,
      isSettledSuccessfully:
          isSettledSuccessfully ?? this.isSettledSuccessfully,
    );
  }

  @override
  List<Object?> get props => [
        timeFilter,
        netEarnings,
        grossEarnings,
        outstandingCommission,
        maxAllowedDebtThreshold,
        completedRides,
        sharedKm,
        commissionRate,
        captainRetentionRate,
        recentTrips,
        isSettling,
        isSettledSuccessfully,
      ];
}
