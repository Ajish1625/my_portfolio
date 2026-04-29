import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _ringController;
  late AnimationController _textController;
  late AnimationController _exitController;

  late Animation<double> _ring1;
  late Animation<double> _ring2;
  late Animation<double> _ring3;
  late Animation<double> _logoFade;
  late Animation<double> _logoScale;
  late Animation<double> _taglineFade;
  late Animation<double> _barProgress;
  late Animation<double> _exitFade;

  int _loadingPercent = 0;

  @override
  void initState() {
    super.initState();

    _ringController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _exitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _ring1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ringController,
          curve: const Interval(0.0, 0.6, curve: Curves.easeOut)),
    );
    _ring2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ringController,
          curve: const Interval(0.15, 0.75, curve: Curves.easeOut)),
    );
    _ring3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ringController,
          curve: const Interval(0.3, 0.9, curve: Curves.easeOut)),
    );

    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController,
          curve: const Interval(0.0, 0.5, curve: Curves.easeOut)),
    );
    _logoScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _textController,
          curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack)),
    );
    _taglineFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController,
          curve: const Interval(0.4, 0.8, curve: Curves.easeOut)),
    );
    _barProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController,
          curve: const Interval(0.3, 1.0, curve: Curves.easeInOut)),
    );

    _exitFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeIn),
    );

    _textController.addListener(() {
      setState(() {
        _loadingPercent = (_barProgress.value * 100).round();
      });
    });

    _runSequence();
  }

  Future<void> _runSequence() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _ringController.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    _textController.forward();
    await Future.delayed(const Duration(milliseconds: 2400));
    await _exitController.forward();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomeScreen(),
          transitionDuration: Duration.zero,
        ),
      );
    }
  }

  @override
  void dispose() {
    _ringController.dispose();
    _textController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_ringController, _textController, _exitController]),
      builder: (context, _) {
        return FadeTransition(
          opacity: _exitFade,
          child: Scaffold(
            backgroundColor: const Color(0xFF0A0A0F),
            body: Stack(
              children: [
                // Particle-like background dots
                ...List.generate(20, (i) {
                  final rand = math.Random(i * 7);
                  final x = rand.nextDouble();
                  final y = rand.nextDouble();
                  final size = rand.nextDouble() * 2 + 1;
                  final opacity = rand.nextDouble() * 0.3 + 0.05;
                  return Positioned(
                    left: x * MediaQuery.of(context).size.width,
                    top: y * MediaQuery.of(context).size.height,
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF00E5CC).withOpacity(opacity),
                      ),
                    ),
                  );
                }),

                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Rings + logo
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Ring 3 (outermost)
                            _AnimatedRing(
                              progress: _ring3.value,
                              size: 180,
                              color: const Color(0xFF00E5CC).withOpacity(0.15),
                              strokeWidth: 1,
                            ),
                            // Ring 2
                            _AnimatedRing(
                              progress: _ring2.value,
                              size: 140,
                              color: const Color(0xFF00E5CC).withOpacity(0.3),
                              strokeWidth: 1.5,
                            ),
                            // Ring 1 (innermost)
                            _AnimatedRing(
                              progress: _ring1.value,
                              size: 100,
                              color: const Color(0xFF00E5CC).withOpacity(0.6),
                              strokeWidth: 2,
                            ),

                            // Logo
                            ScaleTransition(
                              scale: _logoScale,
                              child: FadeTransition(
                                opacity: _logoFade,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'AK',
                                            style: GoogleFonts.jetBrainsMono(
                                              fontSize: 36,
                                              fontWeight: FontWeight.w800,
                                              color: const Color(0xFF00E5CC),
                                              letterSpacing: 4,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '.',
                                            style: GoogleFonts.jetBrainsMono(
                                              fontSize: 36,
                                              fontWeight: FontWeight.w800,
                                              color: const Color(0xFFFF6B35),
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
                      ),

                      const SizedBox(height: 32),

                      // Name
                      FadeTransition(
                        opacity: _logoFade,
                        child: Text(
                          'AJISH KUMAR K',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 6,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Tagline
                      FadeTransition(
                        opacity: _taglineFade,
                        child: Text(
                          'Flutter Developer  ·  Mobile App Developer',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 13,
                            color: Colors.white38,
                            letterSpacing: 1,
                          ),
                        ),
                      ),

                      const SizedBox(height: 48),

                      // Progress bar
                      FadeTransition(
                        opacity: _taglineFade,
                        child: SizedBox(
                          width: 220,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Loading portfolio',
                                    style: GoogleFonts.jetBrainsMono(
                                      fontSize: 9,
                                      color: Colors.white24,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  Text(
                                    '$_loadingPercent%',
                                    style: GoogleFonts.jetBrainsMono(
                                      fontSize: 9,
                                      color: const Color(0xFF00E5CC),
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(2),
                                child: LinearProgressIndicator(
                                  value: _barProgress.value,
                                  backgroundColor: Colors.white10,
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                    Color(0xFF00E5CC),
                                  ),
                                  minHeight: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AnimatedRing extends StatelessWidget {
  final double progress;
  final double size;
  final Color color;
  final double strokeWidth;

  const _AnimatedRing({
    required this.progress,
    required this.size,
    required this.color,
    required this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _RingPainter(
        progress: progress,
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _RingPainter({required this.progress, required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );

    canvas.drawArc(rect, -math.pi / 2, math.pi * 2 * progress, false, paint);
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.progress != progress;
}
