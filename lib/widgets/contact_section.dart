import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'section_header.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(label: '05', title: 'Contact'),
          const SizedBox(height: 48),
          LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > 700) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _ContactInfo()),
                  const SizedBox(width: 64),
                  Expanded(child: _ContactLinks()),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ContactInfo(),
                const SizedBox(height: 40),
                _ContactLinks(),
              ],
            );
          }),
          const SizedBox(height: 80),
          _Footer(),
        ],
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's build something\namazing together.",
          style: GoogleFonts.playfairDisplay(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "I'm currently open to new opportunities. Whether you have a project in mind or just want to connect, feel free to reach out!",
          style: GoogleFonts.spaceGrotesk(
            fontSize: 15,
            color: Colors.white54,
            height: 1.8,
          ),
        ),
      ],
    );
  }
}

class _ContactLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ContactItem(
          icon: Icons.phone_rounded,
          label: 'Phone',
          value: '+91 8122760575',
          color: const Color(0xFF00E5CC),
        ),
        const SizedBox(height: 20),
        _ContactItem(
          icon: Icons.email_rounded,
          label: 'Email',
          value: 'inboxofajish@gmail.com',
          color: const Color(0xFFFF6B35),
        ),
        const SizedBox(height: 20),
        _ContactItem(
          icon: Icons.link_rounded,
          label: 'LinkedIn',
          value: 'linkedin.com/in/ajish-kumar-7356b8228',
          color: const Color(0xFFB388FF),
        ),
      ],
    );
  }
}

class _ContactItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  State<_ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<_ContactItem> {
  bool _copied = false;

  void _copy() {
    Clipboard.setData(ClipboardData(text: widget.value));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _copy,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.color.withOpacity(0.05),
          border: Border.all(color: widget.color.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(widget.icon, color: widget.color, size: 18),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label.toUpperCase(),
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 9,
                      color: Colors.white38,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.value,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _copied
                  ? Icon(Icons.check_rounded, color: widget.color, size: 16, key: const ValueKey('check'))
                  : Icon(Icons.copy_rounded, color: Colors.white24, size: 14, key: const ValueKey('copy')),
            ),
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 0.5, color: Colors.white12),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '© 2025 Ajish Kumar K',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 11,
                color: Colors.white24,
              ),
            ),
            Text(
              'Built with Flutter ❤️',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 11,
                color: Colors.white24,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
