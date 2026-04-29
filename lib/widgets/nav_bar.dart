import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<void> _downloadResume(BuildContext context) async {
    try {
      final byteData = await rootBundle.load('assets/resume/AjishKumar_resume.pdf');
      final buffer = byteData.buffer;
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/AjishKumar_resume.pdf';
      await File(filePath).writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
      );
      await OpenFile.open(filePath);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open resume: $e',
                style: GoogleFonts.spaceGrotesk(fontSize: 13)),
            backgroundColor: const Color(0xFF1A1A24),
          ),
        );
      }
    }
  }

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

                // Nav items
                if (MediaQuery.of(context).size.width > 700)
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
                              fontSize: 11,
                              fontWeight:
                                  isActive ? FontWeight.w700 : FontWeight.w400,
                              color: isActive
                                  ? const Color(0xFF00E5CC)
                                  : Colors.white38,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                const SizedBox(width: 24),

                // Resume button
                _ResumeButton(onTap: () => _downloadResume(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResumeButton extends StatefulWidget {
  final VoidCallback onTap;
  const _ResumeButton({required this.onTap});

  @override
  State<_ResumeButton> createState() => _ResumeButtonState();
}

class _ResumeButtonState extends State<_ResumeButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered
                ? const Color(0xFF00E5CC)
                : const Color(0xFF00E5CC).withOpacity(0.12),
            border: Border.all(
              color: const Color(0xFF00E5CC).withOpacity(0.6),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.download_rounded,
                size: 13,
                color: _hovered ? const Color(0xFF0A0A0F) : const Color(0xFF00E5CC),
              ),
              const SizedBox(width: 6),
              Text(
                'Resume',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: _hovered ? const Color(0xFF0A0A0F) : const Color(0xFF00E5CC),
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
