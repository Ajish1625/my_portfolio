import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PortfolioNavBar extends StatelessWidget {
  final List<String> sections;
  final int activeIndex;
  final Function(int) onTap;

  const PortfolioNavBar({
    super.key,
    required this.sections,
    required this.activeIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0F).withOpacity(0.85),
          border: const Border(
            bottom: BorderSide(color: Color(0xFF00E5CC), width: 0.5),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              children: [
                // Logo
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'AK',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF00E5CC),
                          letterSpacing: 2,
                        ),
                      ),
                      TextSpan(
                        text: '.',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFFF6B35),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Nav items (show on wider screens)
                if (MediaQuery.of(context).size.width > 600)
                  Row(
                    children: List.generate(sections.length, (i) {
                      final isActive = i == activeIndex;
                      return GestureDetector(
                        onTap: () => onTap(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(left: 24),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: isActive
                                    ? const Color(0xFF00E5CC)
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Text(
                            sections[i],
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 12,
                              fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                              color: isActive
                                  ? const Color(0xFF00E5CC)
                                  : Colors.white54,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
