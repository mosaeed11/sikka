import 'package:equatable/equatable.dart';
import 'register_ui_state.dart';

class ChooseRoleState extends Equatable {
  final SikkaUserRole selectedRole;
  final bool isSubmitting;

  const ChooseRoleState({
    this.selectedRole = SikkaUserRole.passenger,
    this.isSubmitting = false,
  });

  ChooseRoleState copyWith({
    SikkaUserRole? selectedRole,
    bool? isSubmitting,
  }) {
    return ChooseRoleState(
      selectedRole: selectedRole ?? this.selectedRole,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [selectedRole, isSubmitting];
}
