import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import 'star_burst_animation.dart';

/// Custom button with gradient, animations, and optional space/stars effect
class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;

  /// Whether to trigger space/stars animation on press
  final bool withConfetti;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.withConfetti = false,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;
  VoidCallback? _triggerStars;

  void _handlePressed() {
    _triggerStars?.call();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final button = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
        child: widget.isPrimary
            ? ElevatedButton(
                onPressed: _handlePressed,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: AppColors.accentCyan,
                  shadowColor: AppColors.glowCyan,
                  elevation: _isHovered ? 12 : 4,
                ),
                child: Text(widget.text, style: AppTextStyles.button),
              )
            : OutlinedButton(
                onPressed: _handlePressed,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(
                    color: _isHovered
                        ? AppColors.accentCyan
                        : AppColors.accentTeal,
                    width: 2,
                  ),
                ),
                child: Text(
                  widget.text,
                  style: AppTextStyles.button.copyWith(
                    color: _isHovered
                        ? AppColors.accentCyan
                        : AppColors.accentTeal,
                  ),
                ),
              ),
      ),
    );

    // Wrap with star burst animation if enabled
    if (widget.withConfetti) {
      return StarBurstAnimation(
        onTriggerReady: (trigger) {
          _triggerStars = trigger;
        },
        child: button,
      );
    }

    return button;
  }
}
