import 'package:equatable/equatable.dart';

enum PaymentMethodType {
  cash,
  digitalWallet,
}

class PaymentUiState extends Equatable {
  final PaymentMethodType selectedMethod;
  final String originTitle;
  final String originSubtitle;
  final String destinationTitle;
  final String destinationSubtitle;
  final double distanceKm;
  final int durationMin;
  final double baseFare;
  final double platformFee;
  final double totalFare;
  final String captainName;
  final double captainRating;
  final int captainRidesCount;
  final String captainVehicle;
  final String receiptId;
  final String formattedDate;
  final bool isProcessing;
  final bool isConfirmed;
  final int userRating;

  const PaymentUiState({
    this.selectedMethod = PaymentMethodType.cash,
    this.originTitle = 'المعادي، شارع النصر',
    this.originSubtitle = 'نقطة الركوب (أمام جراند مول)',
    this.destinationTitle = 'التجمع الخامس، التسعين الشمالي',
    this.destinationSubtitle = 'نقطة النزول (محطة فريش)',
    this.distanceKm = 22.0,
    this.durationMin = 35,
    this.baseFare = 65.0,
    this.platformFee = 5.0,
    this.totalFare = 70.0,
    this.captainName = 'أحمد سامي',
    this.captainRating = 4.9,
    this.captainRidesCount = 124,
    this.captainVehicle = 'تويوتا كورولا • رمادي فيراني',
    this.receiptId = '#SK-94821',
    this.formattedDate = 'اليوم، ٨:٣٠ ص',
    this.isProcessing = false,
    this.isConfirmed = false,
    this.userRating = 5,
  });

  PaymentUiState copyWith({
    PaymentMethodType? selectedMethod,
    String? originTitle,
    String? originSubtitle,
    String? destinationTitle,
    String? destinationSubtitle,
    double? distanceKm,
    int? durationMin,
    double? baseFare,
    double? platformFee,
    double? totalFare,
    String? captainName,
    double? captainRating,
    int? captainRidesCount,
    String? captainVehicle,
    String? receiptId,
    String? formattedDate,
    bool? isProcessing,
    bool? isConfirmed,
    int? userRating,
  }) {
    return PaymentUiState(
      selectedMethod: selectedMethod ?? this.selectedMethod,
      originTitle: originTitle ?? this.originTitle,
      originSubtitle: originSubtitle ?? this.originSubtitle,
      destinationTitle: destinationTitle ?? this.destinationTitle,
      destinationSubtitle: destinationSubtitle ?? this.destinationSubtitle,
      distanceKm: distanceKm ?? this.distanceKm,
      durationMin: durationMin ?? this.durationMin,
      baseFare: baseFare ?? this.baseFare,
      platformFee: platformFee ?? this.platformFee,
      totalFare: totalFare ?? this.totalFare,
      captainName: captainName ?? this.captainName,
      captainRating: captainRating ?? this.captainRating,
      captainRidesCount: captainRidesCount ?? this.captainRidesCount,
      captainVehicle: captainVehicle ?? this.captainVehicle,
      receiptId: receiptId ?? this.receiptId,
      formattedDate: formattedDate ?? this.formattedDate,
      isProcessing: isProcessing ?? this.isProcessing,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      userRating: userRating ?? this.userRating,
    );
  }

  @override
  List<Object?> get props => [
        selectedMethod,
        originTitle,
        originSubtitle,
        destinationTitle,
        destinationSubtitle,
        distanceKm,
        durationMin,
        baseFare,
        platformFee,
        totalFare,
        captainName,
        captainRating,
        captainRidesCount,
        captainVehicle,
        receiptId,
        formattedDate,
        isProcessing,
        isConfirmed,
        userRating,
      ];
}
