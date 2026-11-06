import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/logic/register_ui_state.dart';
import 'profile_ui_state.dart';

class ProfileUiCubit extends Cubit<ProfileUiState> {
  ProfileUiCubit({SikkaUserRole initialRole = SikkaUserRole.captain})
      : super(ProfileUiState(activeRole: initialRole));

  void switchRole(SikkaUserRole role) {
    emit(state.copyWith(activeRole: role));
  }

  void updateName(String name) {
    emit(state.copyWith(fullName: name));
  }
}
