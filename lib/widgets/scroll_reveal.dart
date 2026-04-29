import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

enum RevealDirection { fromBottom, fromLeft, fromRight, fadeOnly }

class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final RevealDirection direction;

  const ScrollReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.direction = RevealDirection.fromBottom,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _triggered = false;

  // ✅ Unique key generated once per widget instance
  final Key _visibilityKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    Offset begin;
    switch (widget.direction) {
      case RevealDirection.fromBottom:
        begin = const Offset(0, 0.25);
        break;
      case RevealDirection.fromLeft:
        begin = const Offset(-0.25, 0);
        break;
      case RevealDirection.fromRight:
        begin = const Offset(0.25, 0);
        break;
      case RevealDirection.fadeOnly:
        begin = Offset.zero;
        break;
    }

    _slide = Tween<Offset>(begin: begin, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!_triggered && info.visibleFraction > 0.12) {
      _triggered = true;
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _visibilityKey, // ✅ uses the instance-level unique key
      onVisibilityChanged: _onVisibilityChanged,
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(position: _slide, child: widget.child),
      ),
    );
  }
}
