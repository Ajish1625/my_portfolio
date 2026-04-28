import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey heroKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  int _activeSection = 0;

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final sections = [heroKey, aboutKey, experienceKey, skillsKey, projectsKey, contactKey];
    final sectionNames = ['Home', 'About', 'Experience', 'Skills', 'Projects', 'Contact'];

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Stack(
        children: [
          // Background grid
          const _BackgroundParticles(),

          // Main content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(key: heroKey, onExplore: () => _scrollToSection(aboutKey)),
                AboutSection(key: aboutKey),
                ExperienceSection(key: experienceKey),
                SkillsSection(key: skillsKey),
                ProjectsSection(key: projectsKey),
                ContactSection(key: contactKey),
              ],
            ),
          ),

          // Floating nav
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PortfolioNavBar(
              sections: sectionNames,
              activeIndex: _activeSection,
              onTap: (i) {
                setState(() => _activeSection = i);
                _scrollToSection(sections[i]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundParticles extends StatefulWidget {
  const _BackgroundParticles();

  @override
  State<_BackgroundParticles> createState() => _BackgroundParticlesState();
}

class _BackgroundParticlesState extends State<_BackgroundParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    final rand = math.Random(42);
    _particles = List.generate(60, (_) => _Particle(rand));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => CustomPaint(
          painter: _ParticlePainter(_particles),
        ),
      ),
    );
  }
}

class _Particle {
  double x, y, vx, vy, radius, opacity;
  Color color;

  _Particle(math.Random rand)
      : x = rand.nextDouble(),
        y = rand.nextDouble(),
        vx = (rand.nextDouble() - 0.5) * 0.00015,
        vy = (rand.nextDouble() - 0.5) * 0.00015,
        radius = rand.nextDouble() * 2.0 + 0.5,
        opacity = rand.nextDouble() * 0.35 + 0.05,
        color = rand.nextBool()
            ? const Color(0xFF00E5CC)
            : rand.nextBool()
            ? const Color(0xFFFF6B35)
            : const Color(0xFFB388FF);

  void update() {
    x += vx;
    y += vy;
    if (x < 0) x = 1.0;
    if (x > 1) x = 0.0;
    if (y < 0) y = 1.0;
    if (y > 1) y = 0.0;
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;

  _ParticlePainter(this.particles) {
    for (final p in particles) {
      p.update();
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < particles.length; i++) {
      final p = particles[i];
      final paint = Paint()
        ..color = p.color.withOpacity(p.opacity)
        ..style = PaintingStyle.fill;

      final pos = Offset(p.x * size.width, p.y * size.height);
      canvas.drawCircle(pos, p.radius, paint);

      // Draw connection lines between nearby particles
      for (int j = i + 1; j < particles.length; j++) {
        final q = particles[j];
        final qPos = Offset(q.x * size.width, q.y * size.height);
        final dist = (pos - qPos).distance;
        const maxDist = 120.0;

        if (dist < maxDist) {
          final lineOpacity = (1 - dist / maxDist) * 0.12;
          final linePaint = Paint()
            ..color = p.color.withOpacity(lineOpacity)
            ..strokeWidth = 0.5;
          canvas.drawLine(pos, qPos, linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter oldDelegate) => true;
}
