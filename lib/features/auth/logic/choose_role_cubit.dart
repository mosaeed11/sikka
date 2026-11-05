import 'package:flutter_bloc/flutter_bloc.dart';
import 'choose_role_state.dart';
import 'register_ui_state.dart';

class ChooseRoleCubit extends Cubit<ChooseRoleState> {
  ChooseRoleCubit({SikkaUserRole initialRole = SikkaUserRole.passenger})
      : super(ChooseRoleState(selectedRole: initialRole));

  void selectRole(SikkaUserRole role) {
    emit(state.copyWith(selectedRole: role));
  }
}
