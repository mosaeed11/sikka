import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _transitAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOutCubic),
      ),
    );

    _transitAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();

    // Auto navigate to Onboarding after splash duration
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const OnboardingScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 400),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.splashDark,
        body: Stack(
          children: [
            // Ambient glowing background orbs from Figma
            Positioned(
              top: -80,
              right: -80,
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.brandIndigo.withValues(alpha: 0.18),
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              left: -60,
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.brandViolet.withValues(alpha: 0.14),
                ),
              ),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s24,
                  vertical: AppSpacing.s20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top Live Service Badge
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: AppRadius.radiusFull,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.12),
                          ),
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
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.success,
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: AppSpacing.s8),
                            const Text(
                              'القاهرة • الجيزة',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textOnDark,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Central Brand Logo & Transit Graphic
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // SIKKA Logo image
                            Image.asset(
                              'assets/images/sikka_logo.png',
                              width: 130,
                              height: 130,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    color: AppColors.brandIndigo,
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'سِكّة',
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: AppSpacing.s16),

                            // Brand typography lockup
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'SIKKA',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textOnDark,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    '•',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white38,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'سِكّة',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.s8),
                            const Text(
                              'نفس السِكّة، نروح سوا.',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: AppSpacing.s32),

                            // Interactive Transit Track Diagram
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.05),
                                borderRadius: AppRadius.radiusMd,
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.08),
                                ),
                              ),
                              child: Column(
                                children: [
                                  AnimatedBuilder(
                                    animation: _transitAnimation,
                                    builder: (context, child) {
                                      return CustomPaint(
                                        size: const Size(double.infinity, 24),
                                        painter: _TransitLinePainter(
                                          progress: _transitAnimation.value,
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: AppSpacing.s8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.brandIndigo,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          const Text(
                                            'نقطة التجمع',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textOnDark,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'الوصول',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textOnDark,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Bottom progress indicator and slogan
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 48,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: AppRadius.radiusFull,
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) {
                                return FractionallySizedBox(
                                  widthFactor: (_controller.value * 1.0).clamp(0.1, 1.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.brandIndigo,
                                      borderRadius: AppRadius.radiusFull,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s8),
                        const Text(
                          'طريق واحد يجمعنا',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white60,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransitLinePainter extends CustomPainter {
  final double progress;

  _TransitLinePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(size.width - 6, size.height / 2);
    final end = Offset(6, size.height / 2);

    final trackPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(start, end, trackPaint);

    final activePaint = Paint()
      ..shader = const LinearGradient(
        colors: [AppColors.brandIndigo, AppColors.brandViolet],
      ).createShader(Rect.fromPoints(start, end))
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final currentX = start.dx + (end.dx - start.dx) * progress;
    canvas.drawLine(start, Offset(currentX, start.dy), activePaint);

    // Moving transit vehicle pulse
    final dotPaint = Paint()
      ..color = AppColors.accentYellow
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(currentX, start.dy), 5.5, dotPaint);

    final glowPaint = Paint()
      ..color = AppColors.accentYellow.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(currentX, start.dy), 9, glowPaint);
  }

  @override
  bool shouldRepaint(covariant _TransitLinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
