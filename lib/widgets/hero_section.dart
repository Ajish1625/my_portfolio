import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:math' as math;

class HeroSection extends StatefulWidget {
  final VoidCallback onExplore;
  const HeroSection({super.key, required this.onExplore});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 1.0, curve: Curves.easeOut)),
    );
    _slideIn = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic)),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _heroContent(BuildContext context, Size size) {
    return FadeTransition(
      opacity: _fadeIn,
      child: SlideTransition(
        position: _slideIn,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF00E5CC), width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '> FLUTTER DEVELOPER',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11,
                  color: const Color(0xFF00E5CC),
                  letterSpacing: 3,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Ajish',
              style: GoogleFonts.playfairDisplay(
                fontSize: size.width > 700 ? 72 : 52,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1.0,
              ),
            ),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF00E5CC), Color(0xFF0096FF)],
              ).createShader(bounds),
              child: Text(
                'Kumar K',
                style: GoogleFonts.playfairDisplay(
                  fontSize: size.width > 700 ? 72 : 52,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text(
                  'I build ',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 18,
                    color: Colors.white60,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'cross-platform apps.',
                      textStyle: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        color: const Color(0xFF00E5CC),
                        fontWeight: FontWeight.w600,
                      ),
                      speed: const Duration(milliseconds: 80),
                    ),
                    TypewriterAnimatedText(
                      'beautiful UIs.',
                      textStyle: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        color: const Color(0xFFFF6B35),
                        fontWeight: FontWeight.w600,
                      ),
                      speed: const Duration(milliseconds: 80),
                    ),
                    TypewriterAnimatedText(
                      'Flutter magic.',
                      textStyle: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        color: const Color(0xFFB388FF),
                        fontWeight: FontWeight.w600,
                      ),
                      speed: const Duration(milliseconds: 80),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '4+ years crafting robust mobile experiences\nfor iOS & Android with Flutter & Dart.',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                color: Colors.white38,
                height: 1.7,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                _CTAButton(label: 'View My Work', isPrimary: true, onTap: widget.onExplore),
                const SizedBox(width: 16),
                _CTAButton(label: 'Get In Touch', isPrimary: false, onTap: widget.onExplore),
              ],
            ),
            const SizedBox(height: 52),
            Row(
              children: [
                _StatChip(value: '4+', label: 'Years Exp.'),
                const SizedBox(width: 32),
                _StatChip(value: '6+', label: 'Projects'),
                const SizedBox(width: 32),
                _StatChip(value: '35%', label: 'Perf. Gains'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        children: [
          Positioned(
            top: size.height * 0.15,
            right: -100,
            child: _GlowOrb(color: const Color(0xFF00E5CC), size: 350),
          ),
          Positioned(
            bottom: size.height * 0.1,
            left: -80,
            child: _GlowOrb(color: const Color(0xFFFF6B35), size: 220),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 80,
              left: 32,
              right: 32,
            ),
            child: size.width > 700
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _heroContent(context, size)),
                const SizedBox(width: 48),
                FadeTransition(
                  opacity: _fadeIn,
                  child: const _ProfileImage(),
                ),
              ],
            )
                : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: FadeTransition(
                      opacity: _fadeIn,
                      child: const _ProfileImage(),
                    ),
                  ),
                  const SizedBox(height: 36),
                  _heroContent(context, size),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _fadeIn,
              child: Column(
                children: [
                  Text(
                    'SCROLL',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 10,
                      color: Colors.white24,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const _ScrollDot(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Profile Image ──────────────────────────────────────────────────────────────

class _ProfileImage extends StatefulWidget {
  const _ProfileImage();

  @override
  State<_ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<_ProfileImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  List<Widget> _accentDots() {
    final positions = [
      const Offset(0, -145),
      const Offset(145, 0),
      const Offset(0, 145),
      const Offset(-145, 0),
    ];
    final colors = [
      const Color(0xFF00E5CC),
      const Color(0xFFFF6B35),
      const Color(0xFFB388FF),
      const Color(0xFF00E5CC),
    ];
    return List.generate(4, (i) {
      return Transform.translate(
        offset: positions[i],
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors[i],
            boxShadow: [
              BoxShadow(color: colors[i].withOpacity(0.8), blurRadius: 8),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (_, __) {
        return SizedBox(
          width: 300,
          height: 300,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer pulsing glow
              Container(
                width: 290,
                height: 290,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00E5CC)
                          .withOpacity(0.08 + _pulse.value * 0.12),
                      blurRadius: 40 + _pulse.value * 30,
                      spreadRadius: 10 + _pulse.value * 10,
                    ),
                  ],
                ),
              ),
              // Rotating gradient ring
              Transform.rotate(
                angle: _pulse.value * math.pi * 2,
                child: Container(
                  width: 272,
                  height: 272,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      colors: [
                        Color(0xFF00E5CC),
                        Color(0xFF0096FF),
                        Color(0xFFB388FF),
                        Color(0x0000E5CC),
                      ],
                    ),
                  ),
                ),
              ),
              // Dark gap ring
              Container(
                width: 264,
                height: 264,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF0A0A0F),
                ),
              ),
              // Photo
              ClipOval(
                child: Image.asset(
                  'assets/images/ajish.jpg',
                  width: 254,
                  height: 254,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              // Accent dots
              ..._accentDots(),
            ],
          ),
        );
      },
    );
  }
}

// ── Supporting widgets ─────────────────────────────────────────────────────────

class _GlowOrb extends StatelessWidget {
  final Color color;
  final double size;
  const _GlowOrb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withOpacity(0.15),
            color.withOpacity(0.05),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}

class _CTAButton extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;
  const _CTAButton({required this.label, required this.isPrimary, required this.onTap});

  @override
  State<_CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<_CTAButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? (_hovered ? const Color(0xFF00E5CC) : const Color(0xFF00E5CC).withOpacity(0.9))
                : Colors.transparent,
            border: Border.all(
              color: widget.isPrimary ? const Color(0xFF00E5CC) : Colors.white30,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: widget.isPrimary ? const Color(0xFF0A0A0F) : Colors.white60,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String value;
  final String label;
  const _StatChip({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.playfairDisplay(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF00E5CC),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 9,
            color: Colors.white38,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}

class _ScrollDot extends StatefulWidget {
  const _ScrollDot();

  @override
  State<_ScrollDot> createState() => _ScrollDotState();
}

class _ScrollDotState extends State<_ScrollDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Transform.translate(
        offset: Offset(0, math.sin(_controller.value * math.pi * 2) * 4),
        child: Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Color(0xFF00E5CC),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}