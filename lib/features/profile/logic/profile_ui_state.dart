import 'package:equatable/equatable.dart';
import '../../auth/logic/register_ui_state.dart';

class ProfileUiState extends Equatable {
  final SikkaUserRole activeRole;
  final String fullName;
  final String phoneNumber;
  final double rating;
  final int totalRides;
  final bool isNationalIdVerified;
  final bool isCaptainApproved;
  final String vehicleName;

  const ProfileUiState({
    this.activeRole = SikkaUserRole.captain,
    this.fullName = 'محمد عبد الرحمن',
    this.phoneNumber = '01012345678',
    this.rating = 4.95,
    this.totalRides = 48,
    this.isNationalIdVerified = true,
    this.isCaptainApproved = true,
    this.vehicleName = 'تويوتا كورولا ٢٠٢٢',
  });

  bool get isCaptain => activeRole == SikkaUserRole.captain;

  ProfileUiState copyWith({
    SikkaUserRole? activeRole,
    String? fullName,
    String? phoneNumber,
    double? rating,
    int? totalRides,
    bool? isNationalIdVerified,
    bool? isCaptainApproved,
    String? vehicleName,
  }) {
    return ProfileUiState(
      activeRole: activeRole ?? this.activeRole,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      rating: rating ?? this.rating,
      totalRides: totalRides ?? this.totalRides,
      isNationalIdVerified: isNationalIdVerified ?? this.isNationalIdVerified,
      isCaptainApproved: isCaptainApproved ?? this.isCaptainApproved,
      vehicleName: vehicleName ?? this.vehicleName,
    );
  }

  @override
  List<Object?> get props => [
        activeRole,
        fullName,
        phoneNumber,
        rating,
        totalRides,
        isNationalIdVerified,
        isCaptainApproved,
        vehicleName,
      ];
}
