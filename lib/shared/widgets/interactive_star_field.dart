import 'dart:math';
import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

/// An interactive overlay that creates star burst animations
/// when the user hovers or clicks anywhere on the screen
class InteractiveStarField extends StatefulWidget {
  final Widget child;

  /// Whether to trigger stars on hover/mouse move
  final bool triggerOnHover;

  /// Whether to trigger stars on tap/click
  final bool triggerOnTap;

  /// Throttle time between hover triggers (in milliseconds)
  final int hoverThrottleMs;

  const InteractiveStarField({
    super.key,
    required this.child,
    this.triggerOnHover = true,
    this.triggerOnTap = true,
    this.hoverThrottleMs = 100,
  });

  @override
  State<InteractiveStarField> createState() => _InteractiveStarFieldState();
}

class _InteractiveStarFieldState extends State<InteractiveStarField>
    with TickerProviderStateMixin {
  final List<_StarBurst> _starBursts = [];
  final Random _random = Random();
  DateTime _lastHoverTrigger = DateTime.now();

  void _triggerStarBurst(Offset position) {
    final burst = _StarBurst(
      position: position,
      controller: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1200),
      ),
      particles: _generateParticles(position),
    );

    burst.controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          burst.controller.dispose();
          _starBursts.remove(burst);
        });
      }
    });

    setState(() {
      _starBursts.add(burst);
    });

    burst.controller.forward();
  }

  List<_StarParticle> _generateParticles(Offset center) {
    final particles = <_StarParticle>[];
    final particleCount = 8 + _random.nextInt(8); // 8-15 particles

    for (int i = 0; i < particleCount; i++) {
      particles.add(
        _StarParticle(
          angle: _random.nextDouble() * 2 * pi,
          speed: 50 + _random.nextDouble() * 150,
          size: 1.5 + _random.nextDouble() * 4,
          color: _getRandomStarColor(),
          delay: _random.nextDouble() * 0.1,
          duration: 0.6 + _random.nextDouble() * 0.4,
          isTwinkle: _random.nextBool(),
        ),
      );
    }

    return particles;
  }

  Color _getRandomStarColor() {
    final colors = [
      AppColors.accentCyan,
      AppColors.accentTeal,
      const Color(0xFFFFFFFF),
      const Color(0xFFFFF8E7),
      const Color(0xFFB4D4FF),
      const Color(0xFFE8D5FF),
      const Color(0xFFFFE5B4),
      const Color(0xFF87CEEB),
    ];
    return colors[_random.nextInt(colors.length)];
  }

  void _onHover(PointerEvent event) {
    if (!widget.triggerOnHover) return;

    final now = DateTime.now();
    if (now.difference(_lastHoverTrigger).inMilliseconds <
        widget.hoverThrottleMs) {
      return;
    }

    _lastHoverTrigger = now;

    // Only trigger occasionally on hover for subtlety
    if (_random.nextDouble() < 0.3) {
      _triggerStarBurst(event.localPosition);
    }
  }

  void _onTap(TapDownDetails details) {
    if (!widget.triggerOnTap) return;
    _triggerStarBurst(details.localPosition);
  }

  @override
  void dispose() {
    for (final burst in _starBursts) {
      burst.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: _onTap,
        child: Stack(
          children: [
            widget.child,
            // Star bursts overlay
            ...List.generate(_starBursts.length, (index) {
              final burst = _starBursts[index];
              return Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedBuilder(
                    animation: burst.controller,
                    builder: (context, _) {
                      return CustomPaint(
                        painter: _InteractiveStarPainter(
                          center: burst.position,
                          particles: burst.particles,
                          progress: burst.controller.value,
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _StarBurst {
  final Offset position;
  final AnimationController controller;
  final List<_StarParticle> particles;

  _StarBurst({
    required this.position,
    required this.controller,
    required this.particles,
  });
}

class _StarParticle {
  final double angle;
  final double speed;
  final double size;
  final Color color;
  final double delay;
  final double duration;
  final bool isTwinkle;

  _StarParticle({
    required this.angle,
    required this.speed,
    required this.size,
    required this.color,
    required this.delay,
    required this.duration,
    required this.isTwinkle,
  });
}

class _InteractiveStarPainter extends CustomPainter {
  final Offset center;
  final List<_StarParticle> particles;
  final double progress;

  _InteractiveStarPainter({
    required this.center,
    required this.particles,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final particleProgress = ((progress - particle.delay) / particle.duration)
          .clamp(0.0, 1.0);

      if (particleProgress <= 0) continue;

      final easedProgress = _easeOutCubic(particleProgress);
      final distance = particle.speed * easedProgress;
      final dx = cos(particle.angle) * distance;
      final dy = sin(particle.angle) * distance;
      final currentPos = center + Offset(dx, dy);

      final opacity = (1 - particleProgress).clamp(0.0, 1.0);
      final twinkleOpacity = particle.isTwinkle
          ? opacity * (0.5 + 0.5 * sin(progress * 15 + particle.angle * 8))
          : opacity;

      // Draw glow
      final glowPaint = Paint()
        ..color = particle.color.withOpacity(twinkleOpacity * 0.4)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, particle.size * 1.5);

      canvas.drawCircle(currentPos, particle.size * 1.2, glowPaint);

      // Draw core
      final starPaint = Paint()
        ..color = particle.color.withOpacity(twinkleOpacity);

      canvas.drawCircle(currentPos, particle.size * 0.5, starPaint);

      // Draw sparkle for larger stars
      if (particle.size > 3) {
        _drawSparkle(canvas, currentPos, particle.size * 0.6, starPaint);
      }
    }
  }

  void _drawSparkle(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path()
      ..moveTo(center.dx - size, center.dy)
      ..lineTo(center.dx + size, center.dy)
      ..moveTo(center.dx, center.dy - size)
      ..lineTo(center.dx, center.dy + size);

    final sparklePaint = Paint()
      ..color = paint.color
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.5);

    canvas.drawPath(path, sparklePaint);
  }

  double _easeOutCubic(double t) => 1 - pow(1 - t, 3).toDouble();

  @override
  bool shouldRepaint(_InteractiveStarPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
