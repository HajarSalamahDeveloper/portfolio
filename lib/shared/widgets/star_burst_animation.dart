import 'dart:math';
import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

/// A star burst animation that creates a space/cosmic effect on trigger
/// Similar to shooting stars bursting from a central point
class StarBurstAnimation extends StatefulWidget {
  /// Child widget to wrap
  final Widget child;

  /// Callback to expose the trigger function
  final void Function(VoidCallback trigger)? onTriggerReady;

  /// Whether to auto-trigger on mount
  final bool autoTrigger;

  const StarBurstAnimation({
    super.key,
    required this.child,
    this.onTriggerReady,
    this.autoTrigger = false,
  });

  @override
  State<StarBurstAnimation> createState() => _StarBurstAnimationState();
}

class _StarBurstAnimationState extends State<StarBurstAnimation>
    with TickerProviderStateMixin {
  final List<StarParticle> _particles = [];
  final Random _random = Random();
  AnimationController? _controller;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    if (widget.onTriggerReady != null) {
      widget.onTriggerReady!(_triggerAnimation);
    }
    if (widget.autoTrigger) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _triggerAnimation();
      });
    }
  }

  void _triggerAnimation() {
    if (_isAnimating) return;

    setState(() {
      _isAnimating = true;
      _particles.clear();

      // Create 30-50 star particles
      final particleCount = 35 + _random.nextInt(15);
      for (int i = 0; i < particleCount; i++) {
        _particles.add(
          StarParticle(
            angle: _random.nextDouble() * 2 * pi,
            speed: 150 + _random.nextDouble() * 300,
            size: 2 + _random.nextDouble() * 6,
            color: _getRandomStarColor(),
            delay: _random.nextDouble() * 0.2,
            duration: 0.8 + _random.nextDouble() * 0.6,
            isTwinkle: _random.nextBool(),
            trailLength: 3 + _random.nextInt(5),
          ),
        );
      }
    });

    _controller?.dispose();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isAnimating = false;
          _particles.clear();
        });
      }
    });

    _controller!.forward();
  }

  Color _getRandomStarColor() {
    final colors = [
      AppColors.accentCyan,
      AppColors.accentTeal,
      const Color(0xFFFFFFFF), // White
      const Color(0xFFFFF8E7), // Warm white
      const Color(0xFFB4D4FF), // Light blue
      const Color(0xFFE8D5FF), // Light purple
      const Color(0xFFFFE5B4), // Peach/yellow
      const Color(0xFF87CEEB), // Sky blue
    ];
    return colors[_random.nextInt(colors.length)];
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        widget.child,
        if (_isAnimating && _controller != null)
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _controller!,
                builder: (context, _) {
                  return CustomPaint(
                    painter: StarBurstPainter(
                      particles: _particles,
                      progress: _controller!.value,
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

/// Represents a single star particle
class StarParticle {
  final double angle;
  final double speed;
  final double size;
  final Color color;
  final double delay;
  final double duration;
  final bool isTwinkle;
  final int trailLength;

  StarParticle({
    required this.angle,
    required this.speed,
    required this.size,
    required this.color,
    required this.delay,
    required this.duration,
    required this.isTwinkle,
    required this.trailLength,
  });
}

/// Custom painter for the star burst effect
class StarBurstPainter extends CustomPainter {
  final List<StarParticle> particles;
  final double progress;

  StarBurstPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    for (final particle in particles) {
      // Calculate particle-specific progress with delay
      final particleProgress = ((progress - particle.delay) / particle.duration)
          .clamp(0.0, 1.0);

      if (particleProgress <= 0) continue;

      // Ease out for natural deceleration
      final easedProgress = _easeOutCubic(particleProgress);

      // Calculate current position
      final distance = particle.speed * easedProgress;
      final dx = cos(particle.angle) * distance;
      final dy = sin(particle.angle) * distance;
      final currentPos = center + Offset(dx, dy);

      // Fade out as it travels
      final opacity = (1 - particleProgress).clamp(0.0, 1.0);

      // Twinkle effect
      final twinkleOpacity = particle.isTwinkle
          ? opacity * (0.5 + 0.5 * sin(progress * 20 + particle.angle * 10))
          : opacity;

      // Draw trail
      for (int i = 0; i < particle.trailLength; i++) {
        final trailProgress = easedProgress - (i * 0.03);
        if (trailProgress <= 0) continue;

        final trailDistance = particle.speed * trailProgress;
        final trailDx = cos(particle.angle) * trailDistance;
        final trailDy = sin(particle.angle) * trailDistance;
        final trailPos = center + Offset(trailDx, trailDy);

        final trailOpacity = twinkleOpacity * (1 - (i / particle.trailLength));
        final trailSize =
            particle.size * (1 - (i / particle.trailLength) * 0.5);

        final trailPaint = Paint()
          ..color = particle.color.withOpacity(trailOpacity * 0.3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

        canvas.drawCircle(trailPos, trailSize * 0.5, trailPaint);
      }

      // Draw main star with glow
      final glowPaint = Paint()
        ..color = particle.color.withOpacity(twinkleOpacity * 0.5)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, particle.size * 2);

      canvas.drawCircle(currentPos, particle.size * 1.5, glowPaint);

      // Draw core star
      final starPaint = Paint()
        ..color = particle.color.withOpacity(twinkleOpacity);

      canvas.drawCircle(currentPos, particle.size * 0.6, starPaint);

      // Draw star sparkle (4-point star)
      if (particle.size > 4) {
        _drawSparkle(canvas, currentPos, particle.size, starPaint);
      }
    }
  }

  void _drawSparkle(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    final sparkleSize = size * 0.8;

    // Horizontal line
    path.moveTo(center.dx - sparkleSize, center.dy);
    path.lineTo(center.dx + sparkleSize, center.dy);

    // Vertical line
    path.moveTo(center.dx, center.dy - sparkleSize);
    path.lineTo(center.dx, center.dy + sparkleSize);

    final sparklePaint = Paint()
      ..color = paint.color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1);

    canvas.drawPath(path, sparklePaint);
  }

  double _easeOutCubic(double t) {
    return 1 - pow(1 - t, 3).toDouble();
  }

  @override
  bool shouldRepaint(StarBurstPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// A button wrapper that triggers star burst on press
class StarBurstButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;

  const StarBurstButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  State<StarBurstButton> createState() => _StarBurstButtonState();
}

class _StarBurstButtonState extends State<StarBurstButton> {
  VoidCallback? _triggerStars;

  @override
  Widget build(BuildContext context) {
    return StarBurstAnimation(
      onTriggerReady: (trigger) {
        _triggerStars = trigger;
      },
      child: GestureDetector(
        onTap: () {
          _triggerStars?.call();
          widget.onPressed();
        },
        child: widget.child,
      ),
    );
  }
}
