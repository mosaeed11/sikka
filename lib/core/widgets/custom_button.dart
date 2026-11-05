import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum CustomButtonVariant {
  primary,
  secondary,
  outline,
  text,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final CustomButtonVariant variant;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? width;
  final double height;
  final double borderRadius;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.variant = CustomButtonVariant.primary,
    this.prefixIcon,
    this.suffixIcon,
    this.width = double.infinity,
    this.height = 52.0,
    this.borderRadius = AppRadius.md,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final bool active = isEnabled && !isLoading && onPressed != null;

    Color backgroundColor;
    Color textColor;
    Border? border;
    List<BoxShadow>? shadows;

    switch (variant) {
      case CustomButtonVariant.primary:
        backgroundColor = active ? AppColors.brandIndigo : AppColors.brandIndigo.withValues(alpha: 0.5);
        textColor = Colors.white;
        shadows = active
            ? [
                BoxShadow(
                  color: AppColors.brandIndigo.withValues(alpha: 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null;
        break;
      case CustomButtonVariant.secondary:
        backgroundColor = active ? AppColors.surfaceMuted : AppColors.surfaceMuted.withValues(alpha: 0.5);
        textColor = active ? AppColors.brandIndigoDeep : AppColors.textMuted;
        break;
      case CustomButtonVariant.outline:
        backgroundColor = Colors.transparent;
        textColor = active ? AppColors.brandIndigo : AppColors.textMuted;
        border = Border.all(
          color: active ? AppColors.brandIndigo : AppColors.border,
          width: 1.5,
        );
        break;
      case CustomButtonVariant.text:
        backgroundColor = Colors.transparent;
        textColor = active ? AppColors.brandIndigoDeep : AppColors.textMuted;
        break;
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
        boxShadow: shadows,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: active ? onPressed : null,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(textColor),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (prefixIcon != null) ...[
                        prefixIcon!,
                        const SizedBox(width: AppSpacing.s8),
                      ],
                      Text(
                        text,
                        style: textStyle ??
                            TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                      ),
                      if (suffixIcon != null) ...[
                        const SizedBox(width: AppSpacing.s8),
                        suffixIcon!,
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
