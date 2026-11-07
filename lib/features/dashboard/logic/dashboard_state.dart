class DashboardState {
  final int selectedNavIndex;
  final int debtorFilterIndex;
  final String searchQuery;
  final bool isArabic;
  final int selectedApplicantIndex;
  final int verificationTab;
  final bool isHeatmapEnabled;
  final int liveRideFilterIndex;
  final int liveRidePage;
  final int ridesTab;
  final String corridorSearchQuery;
  final String selectedCorridorFilter;
  final String selectedPaymentFilter;
  final bool isDeviationFilterOnly;
  final int ridesCurrentPage;

  DashboardState({
    this.selectedNavIndex = 0,
    this.debtorFilterIndex = 0,
    this.searchQuery = '',
    this.isArabic = false,
    this.selectedApplicantIndex = 0,
    this.verificationTab = 0,
    this.isHeatmapEnabled = false,
    this.liveRideFilterIndex = 0,
    this.liveRidePage = 1,
    this.ridesTab = 0,
    this.corridorSearchQuery = '',
    this.selectedCorridorFilter = 'All',
    this.selectedPaymentFilter = 'All',
    this.isDeviationFilterOnly = false,
    this.ridesCurrentPage = 1,
  });

  DashboardState copyWith({
    int? selectedNavIndex,
    int? debtorFilterIndex,
    String? searchQuery,
    bool? isArabic,
    int? selectedApplicantIndex,
    int? verificationTab,
    bool? isHeatmapEnabled,
    int? liveRideFilterIndex,
    int? liveRidePage,
    int? ridesTab,
    String? corridorSearchQuery,
    String? selectedCorridorFilter,
    String? selectedPaymentFilter,
    bool? isDeviationFilterOnly,
    int? ridesCurrentPage,
  }) {
    return DashboardState(
      selectedNavIndex: selectedNavIndex ?? this.selectedNavIndex,
      debtorFilterIndex: debtorFilterIndex ?? this.debtorFilterIndex,
      searchQuery: searchQuery ?? this.searchQuery,
      isArabic: isArabic ?? this.isArabic,
      selectedApplicantIndex:
          selectedApplicantIndex ?? this.selectedApplicantIndex,
      verificationTab: verificationTab ?? this.verificationTab,
      isHeatmapEnabled: isHeatmapEnabled ?? this.isHeatmapEnabled,
      liveRideFilterIndex: liveRideFilterIndex ?? this.liveRideFilterIndex,
      liveRidePage: liveRidePage ?? this.liveRidePage,
      ridesTab: ridesTab ?? this.ridesTab,
      corridorSearchQuery: corridorSearchQuery ?? this.corridorSearchQuery,
      selectedCorridorFilter:
          selectedCorridorFilter ?? this.selectedCorridorFilter,
      selectedPaymentFilter:
          selectedPaymentFilter ?? this.selectedPaymentFilter,
      isDeviationFilterOnly:
          isDeviationFilterOnly ?? this.isDeviationFilterOnly,
      ridesCurrentPage: ridesCurrentPage ?? this.ridesCurrentPage,
    );
  }
}
