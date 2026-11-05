import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_button.dart';
import '../logic/otp_cubit.dart';
import '../logic/otp_state.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({
    super.key,
    this.phoneNumber = '01012345678',
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());

    for (int i = 0; i < 6; i++) {
      final index = i;
      _focusNodes[index].addListener(() {
        if (_focusNodes[index].hasFocus) {
          _controllers[index].selection = TextSelection(
            baseOffset: 0,
            extentOffset: _controllers[index].text.length,
          );
          if (mounted) {
            context.read<OtpCubit>().setFocusedIndex(index);
          }
        }
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final cubit = context.read<OtpCubit>();
      for (int i = 0; i < 6; i++) {
        if (i < cubit.state.digits.length) {
          _controllers[i].text = cubit.state.digits[i];
        }
      }
      final target = cubit.state.focusedIndex.clamp(0, 5);
      _focusNodes[target].requestFocus();
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final fn in _focusNodes) {
      fn.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index, String value, OtpCubit cubit) {
    final normalized = Validators.normalizeDigits(value);

    // Handle paste of multiple digits (e.g. 6-digit OTP from SMS)
    if (normalized.length > 1) {
      final clean = normalized.replaceAll(RegExp(r'\D'), '');
      for (int i = 0; i < clean.length && (index + i) < 6; i++) {
        _controllers[index + i].text = clean[i];
        cubit.digitEntered(index + i, clean[i]);
      }
      final nextFocus = (index + clean.length).clamp(0, 5);
      _focusNodes[nextFocus].requestFocus();
      return;
    }

    if (normalized.isNotEmpty) {
      final singleChar = normalized.characters.last;
      _controllers[index].text = singleChar;
      _controllers[index].selection =
          const TextSelection.collapsed(offset: 1);
      cubit.digitEntered(index, singleChar);

      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      }
    } else {
      cubit.digitEntered(index, '');
    }
  }

  KeyEventResult _handleKeyEvent(
      FocusNode node, KeyEvent event, int index, OtpCubit cubit) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isEmpty && index > 0) {
        _controllers[index - 1].clear();
        cubit.digitEntered(index - 1, '');
        _focusNodes[index - 1].requestFocus();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtpCubit(phoneNumber: widget.phoneNumber),
      child: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          // Sync controllers if state changed externally
          for (int i = 0; i < 6; i++) {
            if (i < state.digits.length &&
                _controllers[i].text != state.digits[i]) {
              _controllers[i].text = state.digits[i];
            }
          }

          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'تم التحقق من رقم الهاتف بنجاح! (معاينة محلية)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: AppColors.success,
                duration: Duration(seconds: 2),
              ),
            );
            context.read<OtpCubit>().resetSuccess();
            Future.delayed(const Duration(milliseconds: 1200), () {
              if (context.mounted) {
                Navigator.of(context).maybePop();
              }
            });
          }
        },
        builder: (context, state) {
          final cubit = context.read<OtpCubit>();

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: AppColors.surfaceDefault,
              appBar: AppBar(
                title: const Text('التحقق من الرقم'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s16,
                    vertical: AppSpacing.s8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Top Indicators (Step badge & Security badge)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceMuted,
                              borderRadius: AppRadius.radiusFull,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.success,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  'الخطوة ٢ من ٣',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceIndigoTint,
                              borderRadius: AppRadius.radiusFull,
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.verified_user_rounded,
                                    size: 14,
                                    color: AppColors.brandIndigoDeep),
                                SizedBox(width: 4),
                                Text(
                                  'أمان وسرية تامة',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.brandIndigoDeep,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.s20),

                      // Title & Instructions (Node 21:709)
                      const Text(
                        'اتأكدنا إن الرقم بتاعك',
                        style: AppTextStyles.h2,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: AppSpacing.s8),
                      Text.rich(
                        TextSpan(
                          text:
                              'دخل الكود المكون من 6 أرقام اللي بعتناه في رسالة نصية على ',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                          children: [
                            TextSpan(
                              text: widget.phoneNumber,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s4),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => Navigator.of(context).maybePop(),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.edit_note_rounded,
                                  size: 16, color: AppColors.brandIndigo),
                              SizedBox(width: 4),
                              Text(
                                'تعديل الرقم',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.brandIndigo,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s24),

                      // 6-Digit OTP Boxes with Native Keyboard Support (LTR order)
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(6, (index) {
                            final digit = state.digits[index];
                            final hasFocus = _focusNodes[index].hasFocus;

                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 48,
                              height: 56,
                              decoration: BoxDecoration(
                                color: hasFocus
                                    ? Colors.white
                                    : AppColors.surfaceMuted,
                                borderRadius: AppRadius.radiusMd,
                                border: Border.all(
                                  color: hasFocus
                                      ? AppColors.brandIndigo
                                      : (digit.isNotEmpty
                                          ? AppColors.brandIndigo
                                              .withValues(alpha: 0.3)
                                          : Colors.transparent),
                                  width: hasFocus ? 2.0 : 1.0,
                                ),
                                boxShadow: hasFocus
                                    ? [
                                        BoxShadow(
                                          color: AppColors.brandIndigo
                                              .withValues(alpha: 0.2),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : const [
                                        BoxShadow(
                                          color: Color(0x08000000),
                                          blurRadius: 2,
                                        ),
                                      ],
                              ),
                              child: Focus(
                                onKeyEvent: (node, event) =>
                                    _handleKeyEvent(node, event, index, cubit),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Circular dot placeholder when empty and unfocused
                                    if (digit.isEmpty && !hasFocus)
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFC7C4D8),
                                        ),
                                      ),
                                    TextField(
                                      controller: _controllers[index],
                                      focusNode: _focusNodes[index],
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      cursorColor: AppColors.brandIndigo,
                                      cursorWidth: 2.0,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.zero,
                                        isDense: true,
                                        counterText: '',
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(6),
                                      ],
                                      onChanged: (val) =>
                                          _onDigitChanged(index, val, cubit),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s12),

                      // Micro feedback
                      const Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.schedule_rounded,
                                size: 14, color: AppColors.textMuted),
                            SizedBox(width: 6),
                            Text(
                              'كود التحقق هيوصلك في خلال ثواني',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (state.errorMessage != null) ...[
                        const SizedBox(height: AppSpacing.s8),
                        Center(
                          child: Text(
                            state.errorMessage!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.error,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],

                      const SizedBox(height: AppSpacing.s20),

                      // Countdown Timer & Resend Card (Node 21:749)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceMuted,
                          borderRadius: AppRadius.radiusMd,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Resend button
                            InkWell(
                              onTap: state.canResend ? cubit.resendCode : null,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: state.canResend
                                      ? AppColors.brandIndigo
                                      : AppColors.surfaceIndigoTint,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'إعادة الإرسال',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: state.canResend
                                        ? Colors.white
                                        : AppColors.textMuted,
                                  ),
                                ),
                              ),
                            ),

                            // Timer information
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'الوقت المتبقي',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    Text(
                                      'إعادة الإرسال خلال 00:${state.secondsRemaining.toString().padLeft(2, '0')} ثانية',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.surfaceIndigoTint,
                                  ),
                                  child: const Icon(
                                    Icons.hourglass_bottom_rounded,
                                    size: 16,
                                    color: AppColors.brandIndigoDeep,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s24),

                      // CTA Button
                      CustomButton(
                        text: 'تأكيد ومتابعة',
                        height: 52,
                        isLoading: state.isLoading,
                        isEnabled: state.isComplete,
                        onPressed: cubit.verifyOtp,
                        prefixIcon: const Icon(
                          Icons.check_circle_outline_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s24),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
