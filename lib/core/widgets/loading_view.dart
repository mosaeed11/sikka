import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LoadingView extends StatelessWidget {
  final String? message;
  final Color? color;

  const LoadingView({
    super.key,
    this.message,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            strokeWidth: 3.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? AppColors.brandIndigo,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: AppSpacing.s16),
            Text(
              message!,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textMuted,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
