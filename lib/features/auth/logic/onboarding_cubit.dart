import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  void setPage(int page) {
    if (page >= 0 && page < state.totalPages) {
      emit(state.copyWith(currentPage: page));
    }
  }

  void nextPage() {
    if (!state.isLastPage) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  void previousPage() {
    if (!state.isFirstPage) {
      emit(state.copyWith(currentPage: state.currentPage - 1));
    }
  }

  void skip() {
    emit(state.copyWith(currentPage: state.totalPages - 1));
  }
}
