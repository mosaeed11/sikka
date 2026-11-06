class CaptainState {
  final int selectedTab;
  final String badgeText;
  final String accountTitle;
  final String accountDescription;
  final bool canCreateRide;

  CaptainState({
    this.selectedTab = 0,
    this.badgeText = 'حالات معلقة',
    this.accountTitle = 'لسه حسابك مش متحقق',
    this.accountDescription =
        'لازم نراجع بياناتك ورخصتك قبل ما تبدأ مشاركة رحلاتك على الطريق عشان نضمن أمان كل الركاب',
    this.canCreateRide = false,
  });
}
