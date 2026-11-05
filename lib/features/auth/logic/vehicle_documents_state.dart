import 'package:equatable/equatable.dart';

class VehicleDocumentsState extends Equatable {
  final String brand;
  final String model;
  final String year;
  final String color;
  final String plateLetters;
  final String plateNumbers;
  final int seatsCount;
  final String vehicleType;
  final bool hasAirConditioning;
  final bool noSmoking;

  // Selected document image paths (local)
  final String? driverLicensePath;
  final String? nationalIdFrontPath;
  final String? nationalIdBackPath;

  // Errors
  final String? brandError;
  final String? modelError;
  final String? yearError;
  final String? colorError;
  final String? plateError;
  final String? documentsError;

  // Form Status
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const VehicleDocumentsState({
    this.brand = 'نيسان (Nissan)',
    this.model = 'صني (Sunny)',
    this.year = '2022',
    this.color = 'فضي معدني',
    this.plateLetters = 'أ ب ج',
    this.plateNumbers = '١٢٣٤',
    this.seatsCount = 3,
    this.vehicleType = 'سيدان عائلية مريحة',
    this.hasAirConditioning = true,
    this.noSmoking = true,
    this.driverLicensePath,
    this.nationalIdFrontPath,
    this.nationalIdBackPath,
    this.brandError,
    this.modelError,
    this.yearError,
    this.colorError,
    this.plateError,
    this.documentsError,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  bool get hasAllDocuments =>
      (driverLicensePath != null && driverLicensePath!.isNotEmpty) &&
      (nationalIdFrontPath != null && nationalIdFrontPath!.isNotEmpty) &&
      (nationalIdBackPath != null && nationalIdBackPath!.isNotEmpty);

  int get uploadedDocumentsCount {
    int count = 0;
    if (driverLicensePath != null && driverLicensePath!.isNotEmpty) count++;
    if (nationalIdFrontPath != null && nationalIdFrontPath!.isNotEmpty) count++;
    if (nationalIdBackPath != null && nationalIdBackPath!.isNotEmpty) count++;
    return count;
  }

  VehicleDocumentsState copyWith({
    String? brand,
    String? model,
    String? year,
    String? color,
    String? plateLetters,
    String? plateNumbers,
    int? seatsCount,
    String? vehicleType,
    bool? hasAirConditioning,
    bool? noSmoking,
    String? driverLicensePath,
    String? nationalIdFrontPath,
    String? nationalIdBackPath,
    bool clearDriverLicense = false,
    bool clearNationalIdFront = false,
    bool clearNationalIdBack = false,
    String? brandError,
    String? modelError,
    String? yearError,
    String? colorError,
    String? plateError,
    String? documentsError,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return VehicleDocumentsState(
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      color: color ?? this.color,
      plateLetters: plateLetters ?? this.plateLetters,
      plateNumbers: plateNumbers ?? this.plateNumbers,
      seatsCount: seatsCount ?? this.seatsCount,
      vehicleType: vehicleType ?? this.vehicleType,
      hasAirConditioning: hasAirConditioning ?? this.hasAirConditioning,
      noSmoking: noSmoking ?? this.noSmoking,
      driverLicensePath: clearDriverLicense
          ? null
          : (driverLicensePath ?? this.driverLicensePath),
      nationalIdFrontPath: clearNationalIdFront
          ? null
          : (nationalIdFrontPath ?? this.nationalIdFrontPath),
      nationalIdBackPath: clearNationalIdBack
          ? null
          : (nationalIdBackPath ?? this.nationalIdBackPath),
      brandError: brandError,
      modelError: modelError,
      yearError: yearError,
      colorError: colorError,
      plateError: plateError,
      documentsError: documentsError,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        brand,
        model,
        year,
        color,
        plateLetters,
        plateNumbers,
        seatsCount,
        vehicleType,
        hasAirConditioning,
        noSmoking,
        driverLicensePath,
        nationalIdFrontPath,
        nationalIdBackPath,
        brandError,
        modelError,
        yearError,
        colorError,
        plateError,
        documentsError,
        isLoading,
        isSuccess,
        errorMessage,
      ];
}
