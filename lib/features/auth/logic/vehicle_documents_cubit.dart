import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'vehicle_documents_state.dart';

enum DocumentType {
  driverLicense,
  nationalIdFront,
  nationalIdBack,
}

class VehicleDocumentsCubit extends Cubit<VehicleDocumentsState> {
  final ImagePicker _picker = ImagePicker();

  VehicleDocumentsCubit() : super(const VehicleDocumentsState());

  void brandChanged(String value) {
    emit(state.copyWith(
      brand: value,
      brandError: value.trim().isEmpty ? 'يرجى إدخال ماركة السيارة' : null,
    ));
  }

  void modelChanged(String value) {
    emit(state.copyWith(
      model: value,
      modelError: value.trim().isEmpty ? 'يرجى إدخال موديل السيارة' : null,
    ));
  }

  void yearChanged(String value) {
    emit(state.copyWith(
      year: value,
      yearError: value.trim().isEmpty ? 'يرجى تحديد سنة الصنع' : null,
    ));
  }

  void colorChanged(String value) {
    emit(state.copyWith(
      color: value,
      colorError: value.trim().isEmpty ? 'يرجى تحديد لون السيارة' : null,
    ));
  }

  void plateLettersChanged(String value) {
    emit(state.copyWith(
      plateLetters: value,
      plateError: (value.trim().isEmpty || state.plateNumbers.trim().isEmpty)
          ? 'يرجى كتابة رقم اللوحة كاملاً'
          : null,
    ));
  }

  void plateNumbersChanged(String value) {
    emit(state.copyWith(
      plateNumbers: value,
      plateError: (state.plateLetters.trim().isEmpty || value.trim().isEmpty)
          ? 'يرجى كتابة رقم اللوحة كاملاً'
          : null,
    ));
  }

  void seatsCountChanged(int seats) {
    if (seats >= 1 && seats <= 6) {
      emit(state.copyWith(seatsCount: seats));
    }
  }

  void toggleAirConditioning() {
    emit(state.copyWith(hasAirConditioning: !state.hasAirConditioning));
  }

  void toggleNoSmoking() {
    emit(state.copyWith(noSmoking: !state.noSmoking));
  }

  Future<void> pickDocumentImage(DocumentType type, {ImageSource source = ImageSource.gallery}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        _setDocumentPath(type, pickedFile.path);
      }
    } catch (_) {
      // Local fallback / mock document path if hardware camera/picker is unavailable in environment
      _setDocumentPath(type, 'local_simulated_${type.name}.png');
    }
  }

  void removeDocumentImage(DocumentType type) {
    switch (type) {
      case DocumentType.driverLicense:
        emit(state.copyWith(clearDriverLicense: true));
        break;
      case DocumentType.nationalIdFront:
        emit(state.copyWith(clearNationalIdFront: true));
        break;
      case DocumentType.nationalIdBack:
        emit(state.copyWith(clearNationalIdBack: true));
        break;
    }
  }

  void _setDocumentPath(DocumentType type, String path) {
    switch (type) {
      case DocumentType.driverLicense:
        emit(state.copyWith(driverLicensePath: path, documentsError: null));
        break;
      case DocumentType.nationalIdFront:
        emit(state.copyWith(nationalIdFrontPath: path, documentsError: null));
        break;
      case DocumentType.nationalIdBack:
        emit(state.copyWith(nationalIdBackPath: path, documentsError: null));
        break;
    }
  }

  Future<void> submit() async {
    // Local validation
    String? brandErr = state.brand.trim().isEmpty ? 'ماركة السيارة مطلوبة' : null;
    String? modelErr = state.model.trim().isEmpty ? 'موديل السيارة مطلوب' : null;
    String? yearErr = state.year.trim().isEmpty ? 'سنة الصنع مطلوبة' : null;
    String? colorErr = state.color.trim().isEmpty ? 'اللون مطلوب' : null;
    String? plateErr;
    if (state.plateLetters.trim().isEmpty || state.plateNumbers.trim().isEmpty) {
      plateErr = 'رقم اللوحة المرورية مطلوب (حروف وأرقام)';
    }

    String? docsErr;
    if (!state.hasAllDocuments) {
      docsErr = 'يرجى إرفاق صور المستندات الثلاثة (الرخصة وبطاقتك بوجهيها) للمتابعة';
    }

    if (brandErr != null ||
        modelErr != null ||
        yearErr != null ||
        colorErr != null ||
        plateErr != null ||
        docsErr != null) {
      emit(state.copyWith(
        brandError: brandErr,
        modelError: modelErr,
        yearError: yearErr,
        colorError: colorErr,
        plateError: plateErr,
        documentsError: docsErr,
        errorMessage: 'يرجى استكمال كافة بيانات المركبة ورفع المستندات المطلوبة',
      ));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    // Simulated short local validation delay
    await Future.delayed(const Duration(milliseconds: 500));

    emit(state.copyWith(
      isLoading: false,
      isSuccess: true,
    ));
  }

  void resetSuccess() {
    emit(state.copyWith(isSuccess: false));
  }
}
