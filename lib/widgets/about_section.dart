import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(label: '01', title: 'About Me'),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 700) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _AboutText()),
                    const SizedBox(width: 64),
                    Expanded(flex: 2, child: _EducationCard()),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AboutText(),
                  const SizedBox(height: 40),
                  _EducationCard(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AboutText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Highly skilled Mobile App Developer with over 4+ years of experience building robust, cross-platform applications using Flutter and Dart.',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 18,
            color: Colors.white,
            height: 1.8,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Proficient in RESTful API integration, state management (BLoC, Provider), and crafting responsive, user-centric interfaces. I bring strong problem-solving abilities, attention to detail, and a passion for delivering high-quality, efficient mobile solutions.',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 15,
            color: Colors.white54,
            height: 1.9,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            _TagChip('Flutter'),
            const SizedBox(width: 8),
            _TagChip('iOS'),
            const SizedBox(width: 8),
            _TagChip('Firebase'),
          ],
        ),
      ],
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  const _TagChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF00E5CC).withOpacity(0.08),
        border: Border.all(color: const Color(0xFF00E5CC).withOpacity(0.3)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 11,
          color: const Color(0xFF00E5CC),
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        border: Border.all(color: Colors.white12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EDUCATION',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 10,
              color: const Color(0xFF00E5CC),
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 24),
          _EduItem(
            school: 'Kongu Arts and Science College',
            degree: 'B.Sc Computer Science',
            year: '2020',
          ),
          _Divider(),
          _EduItem(
            school: 'Kathiravan Matric HSS',
            degree: 'HSC',
            year: '2017',
          ),
          _Divider(),
          _EduItem(
            school: 'Bharath Matriculation School',
            degree: 'SSLC',
            year: '2015',
          ),
        ],
      ),
    );
  }
}

class _EduItem extends StatelessWidget {
  final String school;
  final String degree;
  final String year;
  const _EduItem({required this.school, required this.degree, required this.year});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  school,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  degree,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 12,
                    color: Colors.white38,
                  ),
                ),
              ],
            ),
          ),
          Text(
            year,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 13,
              color: const Color(0xFFFF6B35),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 0.5, color: Colors.white12);
  }
}
