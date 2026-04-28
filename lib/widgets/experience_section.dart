import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/data.dart';
import 'section_header.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D0D14),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(label: '02', title: 'Experience'),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 700) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tab list
                    SizedBox(
                      width: 220,
                      child: _CompanyTabs(
                        selected: _selected,
                        onSelect: (i) => setState(() => _selected = i),
                      ),
                    ),
                    const SizedBox(width: 48),
                    // Detail panel
                    Expanded(
                      child: _ExperienceDetail(exp: experiences[_selected]),
                    ),
                  ],
                );
              }
              // Mobile: vertical
              return Column(
                children: [
                  _CompanyTabs(
                    selected: _selected,
                    onSelect: (i) => setState(() => _selected = i),
                    horizontal: true,
                  ),
                  const SizedBox(height: 32),
                  _ExperienceDetail(exp: experiences[_selected]),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CompanyTabs extends StatelessWidget {
  final int selected;
  final Function(int) onSelect;
  final bool horizontal;

  const _CompanyTabs({
    required this.selected,
    required this.onSelect,
    this.horizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    final items = List.generate(
      experiences.length,
      (i) => GestureDetector(
        onTap: () => onSelect(i),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: horizontal
              ? const EdgeInsets.only(right: 8)
              : const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: selected == i
                ? experiences[i].color.withOpacity(0.1)
                : Colors.transparent,
            border: Border(
              left: horizontal
                  ? BorderSide.none
                  : BorderSide(
                      color: selected == i ? experiences[i].color : Colors.white12,
                      width: 2,
                    ),
              bottom: horizontal
                  ? BorderSide(
                      color: selected == i ? experiences[i].color : Colors.transparent,
                      width: 2,
                    )
                  : BorderSide.none,
            ),
          ),
          child: Text(
            experiences[i].company.split(' ').take(2).join(' '),
            style: GoogleFonts.spaceGrotesk(
              fontSize: 13,
              fontWeight: selected == i ? FontWeight.w700 : FontWeight.w400,
              color: selected == i ? experiences[i].color : Colors.white38,
            ),
          ),
        ),
      ),
    );

    return horizontal
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: items),
          )
        : Column(crossAxisAlignment: CrossAxisAlignment.start, children: items);
  }
}

class _ExperienceDetail extends StatelessWidget {
  final Experience exp;
  const _ExperienceDetail({required this.exp});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: exp.role,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: '  @  ',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 18,
                  color: Colors.white24,
                ),
              ),
              TextSpan(
                text: exp.company,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: exp.color,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          exp.period,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 12,
            color: Colors.white38,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 32),
        ...exp.highlights.map(
          (h) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 7, right: 16),
                  decoration: BoxDecoration(
                    color: exp.color,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    h,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 15,
                      color: Colors.white70,
                      height: 1.7,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
