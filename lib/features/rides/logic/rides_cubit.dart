import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum PassengerStatus { waiting, onboard, droppedOff }

class RidePassenger {
  final String id;
  final String name;
  final LatLng pickup;
  final LatLng dropoff;
  final PassengerStatus status;
  final String? avatarUrl;
  final String? pickupLabel;

  const RidePassenger({
    required this.id,
    required this.name,
    required this.pickup,
    required this.dropoff,
    required this.status,
    this.avatarUrl,
    this.pickupLabel,
  });

  RidePassenger copyWith({
    String? id,
    String? name,
    LatLng? pickup,
    LatLng? dropoff,
    PassengerStatus? status,
    String? avatarUrl,
    String? pickupLabel,
  }) {
    return RidePassenger(
      id: id ?? this.id,
      name: name ?? this.name,
      pickup: pickup ?? this.pickup,
      dropoff: dropoff ?? this.dropoff,
      status: status ?? this.status,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      pickupLabel: pickupLabel ?? this.pickupLabel,
    );
  }
}

class TrackDriverState {
  final LatLng passengerPos;
  final LatLng? driverPos;
  final String distanceText;
  final List<RidePassenger> passengers;
  final bool arrivedAtPickup;
  final int totalSeats;
  final int currentStage;

  TrackDriverState({
    this.passengerPos = const LatLng(30.0055, 31.4280),
    this.driverPos = const LatLng(30.0131, 31.4289),
    this.distanceText = 'الكابتن على بُعد ٨٠٠ متر',
    this.passengers = const [
      RidePassenger(
        id: '1',
        name: 'سارة أحمد',
        pickup: LatLng(30.0055, 31.4280),
        dropoff: LatLng(30.0200, 31.4500),
        status: PassengerStatus.waiting,
        pickupLabel: 'أمام مدخل مترو المعادي',
      ),
      RidePassenger(
        id: '2',
        name: 'محمد علي',
        pickup: LatLng(30.0070, 31.4300),
        dropoff: LatLng(30.0250, 31.4600),
        status: PassengerStatus.onboard,
        pickupLabel: 'بوابة الجامعة الألمانية',
      ),
    ],
    this.arrivedAtPickup = false,
    this.totalSeats = 4,
    this.currentStage = 1,
  });

  List<RidePassenger> get activePassengers =>
      passengers.where((p) => p.status != PassengerStatus.droppedOff).toList();

  int get onboardCount =>
      passengers.where((p) => p.status == PassengerStatus.onboard).length;

  int get bookedSeats => passengers.length;

  bool get isFull => totalSeats > 0 && bookedSeats >= totalSeats;

  bool get canStartRide =>
      passengers.isNotEmpty &&
      passengers.every((p) => p.status != PassengerStatus.waiting);

  TrackDriverState copyWith({
    LatLng? passengerPos,
    LatLng? driverPos,
    String? distanceText,
    List<RidePassenger>? passengers,
    bool? arrivedAtPickup,
    int? totalSeats,
    int? currentStage,
  }) {
    return TrackDriverState(
      passengerPos: passengerPos ?? this.passengerPos,
      driverPos: driverPos ?? this.driverPos,
      distanceText: distanceText ?? this.distanceText,
      passengers: passengers ?? this.passengers,
      arrivedAtPickup: arrivedAtPickup ?? this.arrivedAtPickup,
      totalSeats: totalSeats ?? this.totalSeats,
      currentStage: currentStage ?? this.currentStage,
    );
  }
}

class TrackDriverCubit extends Cubit<TrackDriverState> {
  TrackDriverCubit() : super(TrackDriverState());

  void clickBack(BuildContext context) {}

  void clickHelp(BuildContext context) {}

  void changeStage(int stageIndex) {
    emit(state.copyWith(currentStage: stageIndex));
  }

  void confirmAllOnboard(BuildContext context) {}

  void confirmArrivedAtPickup(BuildContext context) {}

  void markOnboard(String passengerId) {}

  void markDroppedOff(String passengerId) {}

  void togglePassengerStatus(String passengerId) {}
}

class DriverLocationCubit extends Cubit<bool> {
  DriverLocationCubit() : super(false);

  void toggleSharing() => emit(!state);
}

class MyRidesState extends Equatable {
  final int selectedTab;

  const MyRidesState({
    this.selectedTab = 0,
  });

  MyRidesState copyWith({
    int? selectedTab,
  }) {
    return MyRidesState(
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }

  @override
  List<Object?> get props => [selectedTab];
}

class MyRidesCubit extends Cubit<MyRidesState> {
  MyRidesCubit() : super(const MyRidesState());

  void changeTab(int index) {
    emit(state.copyWith(selectedTab: index));
  }

  void retryConnection(BuildContext context) {}

  void checkMobileSettings(BuildContext context) {}

  void serverRetry(BuildContext context) {}

  void contactSupport(BuildContext context) {}

  void findNewRide(BuildContext context) {}

  void goBack(BuildContext context) {}

  void openProfile(BuildContext context) {}
}
