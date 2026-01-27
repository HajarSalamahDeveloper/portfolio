import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../data/models/profile_model.dart';
import '../../../../../config/app_colors.dart';
import '../../../../../config/app_text_styles.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../shared/widgets/custom_button.dart';

/// Hero section with animated name and title
class HeroSection extends StatelessWidget {
  final ProfileModel profile;

  const HeroSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight,
      width: double.infinity,
      padding: context.responsivePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated name
          Text(
                profile.fullName,
                style: context.isMobile
                    ? AppTextStyles.displayMedium
                    : AppTextStyles.displayLarge,
                textAlign: TextAlign.center,
              )
              .animate()
              .fadeIn(duration: 800.ms)
              .slideY(begin: -0.3, end: 0, duration: 800.ms),

          const SizedBox(height: 16),

          // Animated title with gradient
          ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.accentGradient.createShader(bounds),
                child: Text(
                  profile.title,
                  style: context.isMobile
                      ? AppTextStyles.headlineMedium
                      : AppTextStyles.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              )
              .animate()
              .fadeIn(delay: 300.ms, duration: 800.ms)
              .slideY(begin: -0.3, end: 0, duration: 800.ms),

          const SizedBox(height: 12),

          // Location
          Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.accentCyan,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(profile.location, style: AppTextStyles.bodyLarge),
                ],
              )
              .animate()
              .fadeIn(delay: 600.ms, duration: 800.ms)
              .slideY(begin: -0.3, end: 0, duration: 800.ms),

          const SizedBox(height: 48),

          // CTA Buttons
          Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  CustomButton(
                    text: 'View Projects',
                    onPressed: () {
                      // Scroll to projects section
                    },
                    isPrimary: true,
                  ),
                  CustomButton(
                    text: 'Download CV',
                    onPressed: () {
                      // Download CV
                    },
                    isPrimary: false,
                  ),
                ],
              )
              .animate()
              .fadeIn(delay: 900.ms, duration: 800.ms)
              .slideY(begin: 0.3, end: 0, duration: 800.ms),

          const SizedBox(height: 48),

          // Scroll indicator
          const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.accentCyan,
                size: 32,
              )
              .animate(onPlay: (controller) => controller.repeat())
              .fadeIn(delay: 1200.ms)
              .slideY(begin: -10, end: 10, duration: 1500.ms)
              .then()
              .slideY(begin: 10, end: -10, duration: 1500.ms),
        ],
      ),
    );
  }
}
