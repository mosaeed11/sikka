import 'package:flutter/material.dart';

abstract class SikkaRidesState {}

class SikkaRide {
  final String id;
  final String route;
  final String captain;
  final String departure;
  final String seats;
  final String price;
  final String deviation;
  final String payment;
  final String status;
  final Color statusColor;

  const SikkaRide({
    required this.id,
    required this.route,
    required this.captain,
    required this.departure,
    required this.seats,
    required this.price,
    required this.deviation,
    required this.payment,
    required this.status,
    required this.statusColor,
  });
}

class SikkaRidesLoaded extends SikkaRidesState {
  final bool isRtl;
  final String selectedTab;
  final List<SikkaRide> rides;

  SikkaRidesLoaded({
    required this.isRtl,
    required this.selectedTab,
    required this.rides,
  });

  SikkaRidesLoaded copyWith({
    bool? isRtl,
    String? selectedTab,
    List<SikkaRide>? rides,
  }) {
    return SikkaRidesLoaded(
      isRtl: isRtl ?? this.isRtl,
      selectedTab: selectedTab ?? this.selectedTab,
      rides: rides ?? this.rides,
    );
  }
}
