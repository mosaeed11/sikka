import 'package:equatable/equatable.dart';

class BookingConfirmationState extends Equatable {
  final int selectedTab;
  final int usedCancellations;
  final int maxFreeCancellations;
  final double userRating;

  const BookingConfirmationState({
    this.selectedTab = 2,
    this.usedCancellations = 2,
    this.maxFreeCancellations = 5,
    this.userRating = 4.9,
  });

  BookingConfirmationState copyWith({
    int? selectedTab,
    int? usedCancellations,
    int? maxFreeCancellations,
    double? userRating,
  }) {
    return BookingConfirmationState(
      selectedTab: selectedTab ?? this.selectedTab,
      usedCancellations: usedCancellations ?? this.usedCancellations,
      maxFreeCancellations: maxFreeCancellations ?? this.maxFreeCancellations,
      userRating: userRating ?? this.userRating,
    );
  }

  @override
  List<Object?> get props => [
        selectedTab,
        usedCancellations,
        maxFreeCancellations,
        userRating,
      ];
}
