import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final Color? fillColor;
  final bool autofocus;

  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.focusNode,
    this.prefixWidget,
    this.suffixWidget,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
    this.inputFormatters,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.fillColor,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.s4),
        ],
        Container(
          height: maxLines == 1 ? 52.0 : null,
          decoration: BoxDecoration(
            color: fillColor ?? AppColors.surfaceMuted,
            borderRadius: AppRadius.radiusMd,
            border: Border.all(
              color: errorText != null
                  ? AppColors.error
                  : AppColors.border.withValues(alpha: 0.6),
              width: 1.0,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              ?prefixWidget,
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: prefixWidget == null ? 16.0 : 8.0,
                  ),
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    obscureText: obscureText,
                    keyboardType: keyboardType,
                    textInputAction: textInputAction,
                    onChanged: onChanged,
                    onEditingComplete: onEditingComplete,
                    onSubmitted: onSubmitted,
                    readOnly: readOnly,
                    onTap: onTap,
                    maxLines: maxLines,
                    inputFormatters: inputFormatters,
                    textDirection: textDirection,
                    textAlign: textAlign,
                    autofocus: autofocus,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPlaceholder,
                        fontWeight: FontWeight.normal,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
              ?suffixWidget,
            ],
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: AppSpacing.s4),
          Text(
            errorText!,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.error,
            ),
          ),
        ] else if (helperText != null) ...[
          const SizedBox(height: AppSpacing.s4),
          Text(
            helperText!,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ],
    );
  }
}
