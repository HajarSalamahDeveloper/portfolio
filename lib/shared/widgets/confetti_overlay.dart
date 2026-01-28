import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

/// A reusable confetti overlay widget that creates celebration animations
/// similar to the Antigravity web authentication success page.
class ConfettiOverlay extends StatefulWidget {
  /// Child widget to wrap with confetti capability
  final Widget child;

  /// Whether to auto-play confetti on mount
  final bool autoPlay;

  /// Duration for the confetti animation
  final Duration duration;

  /// Callback to expose the controller for external triggering
  final void Function(ConfettiController controller)? onControllerReady;

  const ConfettiOverlay({
    super.key,
    required this.child,
    this.autoPlay = false,
    this.duration = const Duration(seconds: 3),
    this.onControllerReady,
  });

  @override
  State<ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<ConfettiOverlay> {
  late ConfettiController _topLeftController;
  late ConfettiController _topRightController;
  late ConfettiController _centerController;

  @override
  void initState() {
    super.initState();
    _topLeftController = ConfettiController(duration: widget.duration);
    _topRightController = ConfettiController(duration: widget.duration);
    _centerController = ConfettiController(duration: widget.duration);

    if (widget.onControllerReady != null) {
      widget.onControllerReady!(_centerController);
    }

    if (widget.autoPlay) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _playAllConfetti();
      });
    }
  }

  void _playAllConfetti() {
    _topLeftController.play();
    _topRightController.play();
    _centerController.play();
  }

  @override
  void dispose() {
    _topLeftController.dispose();
    _topRightController.dispose();
    _centerController.dispose();
    super.dispose();
  }

  /// Creates the confetti particle colors matching Antigravity style
  List<Color> get _confettiColors => [
    AppColors.accentCyan,
    AppColors.primaryMedium,
    AppColors.primaryLight,
    const Color(0xFFFF6B6B), // Coral red
    const Color(0xFF4ECDC4), // Teal
    const Color(0xFFFFE66D), // Yellow
    const Color(0xFF95E1D3), // Mint
    const Color(0xFFF38181), // Rose
    const Color(0xFF845EC2), // Purple
    const Color(0xFF00C9A7), // Emerald
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,

        // Top-left confetti source
        Positioned(
          top: 0,
          left: 0,
          child: ConfettiWidget(
            confettiController: _topLeftController,
            blastDirection: pi / 4, // Diagonal down-right
            emissionFrequency: 0.02,
            numberOfParticles: 15,
            maxBlastForce: 20,
            minBlastForce: 5,
            gravity: 0.1,
            particleDrag: 0.05,
            colors: _confettiColors,
            shouldLoop: false,
            createParticlePath: _createParticlePath,
          ),
        ),

        // Top-right confetti source
        Positioned(
          top: 0,
          right: 0,
          child: ConfettiWidget(
            confettiController: _topRightController,
            blastDirection: 3 * pi / 4, // Diagonal down-left
            emissionFrequency: 0.02,
            numberOfParticles: 15,
            maxBlastForce: 20,
            minBlastForce: 5,
            gravity: 0.1,
            particleDrag: 0.05,
            colors: _confettiColors,
            shouldLoop: false,
            createParticlePath: _createParticlePath,
          ),
        ),

        // Center top confetti source (main celebration)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _centerController,
              blastDirectionality: BlastDirectionality.explosive,
              emissionFrequency: 0.03,
              numberOfParticles: 20,
              maxBlastForce: 30,
              minBlastForce: 10,
              gravity: 0.15,
              particleDrag: 0.05,
              colors: _confettiColors,
              shouldLoop: false,
              createParticlePath: _createParticlePath,
            ),
          ),
        ),
      ],
    );
  }

  /// Creates varied particle shapes for a more dynamic effect
  Path _createParticlePath(Size size) {
    final random = Random();
    final shapeType = random.nextInt(4);

    switch (shapeType) {
      case 0:
        // Rectangle/confetti strip
        return Path()..addRect(
          Rect.fromCenter(
            center: Offset.zero,
            width: size.width * 0.6,
            height: size.height,
          ),
        );
      case 1:
        // Small circle
        return Path()..addOval(
          Rect.fromCenter(
            center: Offset.zero,
            width: size.width * 0.5,
            height: size.height * 0.5,
          ),
        );
      case 2:
        // Triangle
        return Path()
          ..moveTo(0, -size.height / 2)
          ..lineTo(size.width / 2, size.height / 2)
          ..lineTo(-size.width / 2, size.height / 2)
          ..close();
      default:
        // Diamond
        return Path()
          ..moveTo(0, -size.height / 2)
          ..lineTo(size.width / 3, 0)
          ..lineTo(0, size.height / 2)
          ..lineTo(-size.width / 3, 0)
          ..close();
    }
  }
}

/// A controller wrapper that can trigger confetti from any widget
class ConfettiTrigger extends StatefulWidget {
  /// Builder that provides the trigger function
  final Widget Function(BuildContext context, VoidCallback triggerConfetti)
  builder;

  /// Duration of the confetti animation
  final Duration duration;

  const ConfettiTrigger({
    super.key,
    required this.builder,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<ConfettiTrigger> createState() => _ConfettiTriggerState();
}

class _ConfettiTriggerState extends State<ConfettiTrigger> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: widget.duration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerConfetti() {
    _controller.play();
  }

  /// Confetti colors matching Antigravity celebration style
  List<Color> get _confettiColors => [
    AppColors.accentCyan,
    AppColors.primaryMedium,
    AppColors.primaryLight,
    const Color(0xFFFF6B6B),
    const Color(0xFF4ECDC4),
    const Color(0xFFFFE66D),
    const Color(0xFF95E1D3),
    const Color(0xFFF38181),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        widget.builder(context, _triggerConfetti),

        // Positioned confetti at the widget location
        Positioned.fill(
          child: IgnorePointer(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _controller,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 0.05,
                numberOfParticles: 25,
                maxBlastForce: 25,
                minBlastForce: 8,
                gravity: 0.2,
                particleDrag: 0.05,
                colors: _confettiColors,
                shouldLoop: false,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
