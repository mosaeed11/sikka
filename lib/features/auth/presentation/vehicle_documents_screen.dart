import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../logic/vehicle_documents_cubit.dart';
import '../logic/vehicle_documents_state.dart';
import 'captain_verification_intro_screen.dart';

/// Screen: Vehicle Information & Documents (بيانات العربية والمستندات)
/// Dedicated registration step for Car Owner / Captain
class VehicleDocumentsScreen extends StatefulWidget {
  const VehicleDocumentsScreen({super.key});

  @override
  State<VehicleDocumentsScreen> createState() => _VehicleDocumentsScreenState();
}

class _VehicleDocumentsScreenState extends State<VehicleDocumentsScreen> {
  late final TextEditingController _brandController;
  late final TextEditingController _modelController;
  late final TextEditingController _yearController;
  late final TextEditingController _colorController;
  late final TextEditingController _plateLettersController;
  late final TextEditingController _plateNumbersController;

  @override
  void initState() {
    super.initState();
    _brandController = TextEditingController(text: 'نيسان (Nissan)');
    _modelController = TextEditingController(text: 'صني (Sunny)');
    _yearController = TextEditingController(text: '2022');
    _colorController = TextEditingController(text: 'فضي معدني');
    _plateLettersController = TextEditingController(text: 'أ ب ج');
    _plateNumbersController = TextEditingController(text: '١٢٣٤');
  }

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _colorController.dispose();
    _plateLettersController.dispose();
    _plateNumbersController.dispose();
    super.dispose();
  }

  void _showImageSourcePicker(
    BuildContext context,
    VehicleDocumentsCubit cubit,
    DocumentType docType,
    String docTitle,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'إرفاق $docTitle',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'اختر طريقة رفع المستند بصورة واضحة:',
                  style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
                const SizedBox(height: AppSpacing.s16),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(sheetContext).pop();
                          cubit.pickDocumentImage(
                            docType,
                            source: ImageSource.camera,
                          );
                        },
                        borderRadius: AppRadius.radiusMd,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceMuted,
                            borderRadius: AppRadius.radiusMd,
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: const Column(
                            children: [
                              Icon(
                                Icons.camera_alt_rounded,
                                size: 28,
                                color: AppColors.brandIndigo,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'التقاط بالكاميرا',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.s12),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(sheetContext).pop();
                          cubit.pickDocumentImage(
                            docType,
                            source: ImageSource.gallery,
                          );
                        },
                        borderRadius: AppRadius.radiusMd,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceMuted,
                            borderRadius: AppRadius.radiusMd,
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: const Column(
                            children: [
                              Icon(
                                Icons.photo_library_rounded,
                                size: 28,
                                color: AppColors.brandIndigo,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'معرض الصور',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.s8),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VehicleDocumentsCubit(),
      child: BlocConsumer<VehicleDocumentsCubit, VehicleDocumentsState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: AppColors.error,
              ),
            );
          }

          if (state.isSuccess) {
            context.read<VehicleDocumentsCubit>().resetSuccess();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CaptainVerificationIntroScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<VehicleDocumentsCubit>();

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: AppColors.surfaceDefault,
              appBar: AppBar(
                title: const Text('بيانات العربية والوثائق'),
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
                actions: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE1E8FD),
                          borderRadius: AppRadius.radiusFull,
                        ),
                        child: const Text(
                          'خطوة ٢ من ٢',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.brandIndigoDeep,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s16,
                          vertical: AppSpacing.s8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Progress bar
                            _buildProgressStepIndicator(),

                            const SizedBox(height: AppSpacing.s16),

                            // Egyptian License Plate Card Preview
                            _buildLicensePlateGraphic(state),

                            const SizedBox(height: AppSpacing.s20),

                            // Section 1 Header: Vehicle Specs
                            _buildSectionHeader(
                              title: 'بيانات العربية الأساسية',
                              subtitle: 'الماركة والموديل وسنة الصنع واللوحات',
                              icon: Icons.directions_car_filled_rounded,
                            ),

                            const SizedBox(height: AppSpacing.s12),

                            // Brand & Model inputs
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: _brandController,
                                    label: 'ماركة السيارة',
                                    hintText: 'مثال: نيسان',
                                    errorText: state.brandError,
                                    onChanged: cubit.brandChanged,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.s12),
                                Expanded(
                                  child: CustomTextField(
                                    controller: _modelController,
                                    label: 'الموديل',
                                    hintText: 'مثال: صني',
                                    errorText: state.modelError,
                                    onChanged: cubit.modelChanged,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: AppSpacing.s12),

                            // Year & Color inputs
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: _yearController,
                                    label: 'سنة الصنع',
                                    hintText: 'مثال: 2022',
                                    keyboardType: TextInputType.number,
                                    errorText: state.yearError,
                                    onChanged: cubit.yearChanged,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.s12),
                                Expanded(
                                  child: CustomTextField(
                                    controller: _colorController,
                                    label: 'اللون الخارجي',
                                    hintText: 'مثال: فضي معدني',
                                    errorText: state.colorError,
                                    onChanged: cubit.colorChanged,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: AppSpacing.s12),

                            // Plate Letters & Numbers Inputs
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: _plateLettersController,
                                    label: 'حروف اللوحة',
                                    hintText: 'مثال: أ ب ج',
                                    errorText: state.plateError,
                                    onChanged: cubit.plateLettersChanged,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.s12),
                                Expanded(
                                  child: CustomTextField(
                                    controller: _plateNumbersController,
                                    label: 'أرقام اللوحة',
                                    hintText: 'مثال: ١٢٣٤',
                                    keyboardType: TextInputType.number,
                                    onChanged: cubit.plateNumbersChanged,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: AppSpacing.s20),

                            // Available Seats Count Selector
                            _buildSeatsSelector(state, cubit),

                            const SizedBox(height: AppSpacing.s16),

                            // In-Car Comfort Amenities
                            _buildAmenitiesBox(state, cubit),

                            const SizedBox(height: AppSpacing.s24),

                            // Section 2 Header: Required Documents
                            _buildSectionHeader(
                              title: 'المستندات المطلوبة للتحقق',
                              subtitle:
                                  'الرخصة الشخصية وبطاقة الرقم القومي (الوجهين)',
                              icon: Icons.document_scanner_rounded,
                              badge: '${state.uploadedDocumentsCount} من ٣ مرفوعة',
                            ),

                            if (state.documentsError != null) ...[
                              const SizedBox(height: AppSpacing.s8),
                              Container(
                                padding: const EdgeInsets.all(AppSpacing.s10),
                                decoration: BoxDecoration(
                                  color: AppColors.error.withValues(alpha: 0.1),
                                  borderRadius: AppRadius.radiusSm,
                                  border: Border.all(
                                    color: AppColors.error.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.info_outline_rounded,
                                      size: 16,
                                      color: AppColors.error,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        state.documentsError!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.error,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],

                            const SizedBox(height: AppSpacing.s12),

                            // Document 1: Driver License
                            _buildDocumentUploadCard(
                              context: context,
                              cubit: cubit,
                              docType: DocumentType.driverLicense,
                              title: 'صورة رخصة القيادة الشخصية',
                              subtitle: 'سارية المفعول وبصورة واضحة لجميع البيانات',
                              icon: Icons.badge_rounded,
                              filePath: state.driverLicensePath,
                            ),

                            const SizedBox(height: AppSpacing.s12),

                            // Document 2: National ID Front
                            _buildDocumentUploadCard(
                              context: context,
                              cubit: cubit,
                              docType: DocumentType.nationalIdFront,
                              title: 'بطاقة الرقم القومي (الوجه الأمامي)',
                              subtitle: 'الاسم والصورة والرقم القومي بالكامل',
                              icon: Icons.credit_card_rounded,
                              filePath: state.nationalIdFrontPath,
                            ),

                            const SizedBox(height: AppSpacing.s12),

                            // Document 3: National ID Back
                            _buildDocumentUploadCard(
                              context: context,
                              cubit: cubit,
                              docType: DocumentType.nationalIdBack,
                              title: 'بطاقة الرقم القومي (الوجه الخلفي)',
                              subtitle: 'العنوان وتاريخ سريان بطاقة الرقم القومي',
                              icon: Icons.flip_to_back_rounded,
                              filePath: state.nationalIdBackPath,
                            ),

                            const SizedBox(height: AppSpacing.s20),

                            // Trust & Safety notice card
                            Container(
                              padding: const EdgeInsets.all(AppSpacing.s12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F3FF),
                                borderRadius: AppRadius.radiusMd,
                              ),
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.lock_outline_rounded,
                                    size: 18,
                                    color: AppColors.brandIndigo,
                                  ),
                                  SizedBox(width: AppSpacing.s8),
                                  Expanded(
                                    child: Text(
                                      'بياناتك ومستنداتك تخضع لأعلى معايير التشفير والسرية ولا يتم مشاركتها إلا لأغراض التحقق الأمني المعتمد في سِكّة.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: AppSpacing.s24),
                          ],
                        ),
                      ),
                    ),

                    // Bottom Action Button
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.s16,
                        AppSpacing.s8,
                        AppSpacing.s16,
                        AppSpacing.s20,
                      ),
                      child: CustomButton(
                        text: 'متابعة لمراجعة الحساب',
                        isLoading: state.isLoading,
                        height: 52,
                        onPressed: cubit.submit,
                        prefixIcon: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressStepIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.radiusMd,
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          // Step 1: Personal info (Done)
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.success,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 14),
              ),
              const SizedBox(width: 6),
              const Text(
                'البيانات الأساسية',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),

          // Divider
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 2,
                color: AppColors.brandIndigo,
              ),
            ),
          ),

          // Step 2: Vehicle & Docs (Active)
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.brandIndigo,
                ),
                child: const Center(
                  child: Text(
                    '٢',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'العربية والوثائق',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brandIndigoDeep,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLicensePlateGraphic(VehicleDocumentsState state) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3FF),
        borderRadius: AppRadius.radiusMd,
        border: Border.all(color: const Color(0xFFDCE2F7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.verified_rounded,
                    size: 16,
                    color: AppColors.success,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'معاينة اللوحة المرورية الرسمية',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.radiusFull,
                ),
                child: const Text(
                  'ملاكي • القاهرة',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.s12),

          // Egyptian License Plate Graphic Box from Figma
          Center(
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFF141B2B), width: 1.5),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Blue top header bar
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E3A8A),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(4)),
                    ),
                    child: const Text(
                      'مـصـر • EGYPT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),

                  // Lower Plate section with Arabic letters and numbers
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 6.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          state.plateLetters.isNotEmpty
                              ? state.plateLetters
                              : 'أ ب ج',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                            letterSpacing: 2,
                          ),
                        ),
                        Container(
                          width: 1.5,
                          height: 22,
                          color: const Color(0xFFCBD5E1),
                        ),
                        Text(
                          state.plateNumbers.isNotEmpty
                              ? state.plateNumbers
                              : '١٢٣٤',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String subtitle,
    required IconData icon,
    String? badge,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFE2DFFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.brandIndigoDeep, size: 20),
            ),
            const SizedBox(width: AppSpacing.s10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
        if (badge != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE1E8FD),
              borderRadius: AppRadius.radiusFull,
            ),
            child: Text(
              badge,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.brandIndigoDeep,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSeatsSelector(
    VehicleDocumentsState state,
    VehicleDocumentsCubit cubit,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.radiusMd,
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'عدد الكراسي المتاحة للركاب',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F3FF),
                  borderRadius: AppRadius.radiusFull,
                ),
                child: Text(
                  '${state.seatsCount} ركاب + الكابتن',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.brandIndigoDeep,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'حدد كم راكب تقدر تاخدهم في المشوار في الكنبة الخلفية أو جنب الكابتن:',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.s12),
          Row(
            children: [1, 2, 3, 4].map((count) {
              final isSelected = state.seatsCount == count;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: InkWell(
                    onTap: () => cubit.seatsCountChanged(count),
                    borderRadius: AppRadius.radiusSm,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.brandIndigo
                            : const Color(0xFFF8FAFC),
                        borderRadius: AppRadius.radiusSm,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.brandIndigo
                              : const Color(0xFFCBD5E1),
                          width: isSelected ? 1.5 : 1.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.airline_seat_recline_normal_rounded,
                            size: 18,
                            color: isSelected ? Colors.white : AppColors.textPrimary,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$count',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color:
                                  isSelected ? Colors.white : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenitiesBox(
    VehicleDocumentsState state,
    VehicleDocumentsCubit cubit,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.radiusMd,
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'تجهيزات وراحة المشوار',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.s8),
          InkWell(
            onTap: cubit.toggleAirConditioning,
            child: Row(
              children: [
                Checkbox(
                  value: state.hasAirConditioning,
                  onChanged: (_) => cubit.toggleAirConditioning(),
                  activeColor: AppColors.brandIndigo,
                ),
                const Icon(
                  Icons.ac_unit_rounded,
                  size: 18,
                  color: AppColors.brandIndigo,
                ),
                const SizedBox(width: 8),
                const Text(
                  'تكييف هواء يعمل بكفاءة وتبريد قوي',
                  style: TextStyle(fontSize: 13, color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: cubit.toggleNoSmoking,
            child: Row(
              children: [
                Checkbox(
                  value: state.noSmoking,
                  onChanged: (_) => cubit.toggleNoSmoking(),
                  activeColor: AppColors.brandIndigo,
                ),
                const Icon(
                  Icons.smoke_free_rounded,
                  size: 18,
                  color: AppColors.brandIndigo,
                ),
                const SizedBox(width: 8),
                const Text(
                  'ممنوع التدخين داخل السيارة للحفاظ على راحة الركاب',
                  style: TextStyle(fontSize: 13, color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentUploadCard({
    required BuildContext context,
    required VehicleDocumentsCubit cubit,
    required DocumentType docType,
    required String title,
    required String subtitle,
    required IconData icon,
    required String? filePath,
  }) {
    final bool hasFile = filePath != null && filePath.isNotEmpty;
    final bool isLocalFile = hasFile && File(filePath).existsSync();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.radiusMd,
        border: Border.all(
          color: hasFile ? AppColors.success : const Color(0xFFE2E8F0),
          width: hasFile ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: hasFile
                      ? AppColors.success.withValues(alpha: 0.12)
                      : const Color(0xFFF1F3FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  hasFile ? Icons.check_circle_rounded : icon,
                  color: hasFile ? AppColors.success : AppColors.brandIndigo,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.s12),

          // Upload or Preview Area
          if (!hasFile)
            InkWell(
              onTap: () =>
                  _showImageSourcePicker(context, cubit, docType, title),
              borderRadius: AppRadius.radiusSm,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: AppRadius.radiusSm,
                  border: Border.all(
                    color: const Color(0xFFCBD5E1),
                    style: BorderStyle.solid,
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 20,
                      color: AppColors.brandIndigo,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'اضغط لرفع المستند (كاميرا / استوديو)',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.brandIndigoDeep,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(AppSpacing.s10),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: AppRadius.radiusSm,
              ),
              child: Row(
                children: [
                  // Image thumbnail preview
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      width: 52,
                      height: 52,
                      color: const Color(0xFFE2E8F0),
                      child: isLocalFile
                          ? Image.file(
                              File(filePath),
                              fit: BoxFit.cover,
                            )
                          : const Icon(
                              Icons.image_rounded,
                              color: AppColors.success,
                              size: 28,
                            ),
                    ),
                  ),

                  const SizedBox(width: AppSpacing.s12),

                  // File Info
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 14,
                              color: AppColors.success,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'تم إرفاق المستند بنجاح',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          'جاهز للمراجعة والتوثيق',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Actions: Change & Remove
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: 'تغيير الصورة',
                        icon: const Icon(
                          Icons.edit_outlined,
                          size: 18,
                          color: AppColors.brandIndigo,
                        ),
                        onPressed: () => _showImageSourcePicker(
                          context,
                          cubit,
                          docType,
                          title,
                        ),
                      ),
                      IconButton(
                        tooltip: 'حذف',
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          size: 18,
                          color: AppColors.error,
                        ),
                        onPressed: () => cubit.removeDocumentImage(docType),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
