import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/data.dart';
import 'section_header.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D0D14),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(label: '04', title: 'Projects'),
          const SizedBox(height: 48),
          LayoutBuilder(builder: (context, constraints) {
            int crossAxis = 1;
            if (constraints.maxWidth > 900) crossAxis = 3;
            else if (constraints.maxWidth > 600) crossAxis = 2;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxis,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.5,
              ),
              itemCount: projects.length,
              itemBuilder: (_, i) => _ProjectCard(project: projects[i], index: i),
            );
          }),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  final int index;
  const _ProjectCard({required this.project, required this.index});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  static const _gradients = [
    [Color(0xFF00E5CC), Color(0xFF0096FF)],
    [Color(0xFFFF6B35), Color(0xFFFF0080)],
    [Color(0xFFB388FF), Color(0xFF00E5CC)],
    [Color(0xFF4FC3F7), Color(0xFFB388FF)],
    [Color(0xFF81C784), Color(0xFF4FC3F7)],
    [Color(0xFFFFD54F), Color(0xFFFF6B35)],
  ];

  List<Color> get _gradient =>
      _gradients[widget.index % _gradients.length];

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered ? _gradient[0].withOpacity(0.6) : Colors.white10,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _hovered
                ? [
                    _gradient[0].withOpacity(0.15),
                    _gradient[1].withOpacity(0.08),
                  ]
                : [
                    Colors.white.withOpacity(0.02),
                    Colors.white.withOpacity(0.01),
                  ],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon + arrow
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      widget.project.icon,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: _hovered ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.arrow_outward_rounded,
                    color: _gradient[0],
                    size: 18,
                  ),
                ),
              ],
            ),

            // Name & description
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.project.name,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.project.description,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 12,
                    color: Colors.white38,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
