class DashboardState {
  final int selectedNavIndex;
  final int debtorFilterIndex;
  final String searchQuery;
  final bool isArabic;
  final int selectedApplicantIndex;
  final int verificationTab;

  DashboardState({
    this.selectedNavIndex = 5,
    this.debtorFilterIndex = 0,
    this.searchQuery = '',
    this.isArabic = false,
    this.selectedApplicantIndex = 0,
    this.verificationTab = 0,
  });

  DashboardState copyWith({
    int? selectedNavIndex,
    int? debtorFilterIndex,
    String? searchQuery,
    bool? isArabic,
    int? selectedApplicantIndex,
    int? verificationTab,
  }) {
    return DashboardState(
      selectedNavIndex: selectedNavIndex ?? this.selectedNavIndex,
      debtorFilterIndex: debtorFilterIndex ?? this.debtorFilterIndex,
      searchQuery: searchQuery ?? this.searchQuery,
      isArabic: isArabic ?? this.isArabic,
      selectedApplicantIndex:
          selectedApplicantIndex ?? this.selectedApplicantIndex,
      verificationTab: verificationTab ?? this.verificationTab,
    );
  }
}
