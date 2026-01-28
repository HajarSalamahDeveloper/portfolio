import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../data/models/profile_model.dart';
import '../../../../../config/app_colors.dart';
import '../../../../../config/app_text_styles.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../shared/widgets/custom_button.dart';

// Conditional import for web download
import '../../../../../core/utils/web_downloader.dart'
    if (dart.library.io) '../../../../../core/utils/web_downloader_stub.dart';

/// Hero section with animated name and title
class HeroSection extends StatelessWidget {
  final ProfileModel profile;

  /// Callback to scroll to projects section
  final VoidCallback? onViewProjects;

  const HeroSection({super.key, required this.profile, this.onViewProjects});

  Future<void> _downloadCV(BuildContext context) async {
    if (kIsWeb) {
      // Web platform: use web downloader
      await WebDownloader.downloadPdf(
        assetPath: 'assets/Hajar_Salamah_CV_12_2025_Last.pdf',
        fileName: 'Hajar_Salamah_CV.pdf',
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('CV download started!'),
            backgroundColor: AppColors.accentCyan,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } else {
      // Mobile/Desktop: show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('CV download is available on web version'),
            backgroundColor: AppColors.accentCyan,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

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
                      onViewProjects?.call();
                    },
                    isPrimary: true,
                    withConfetti: true,
                  ),
                  CustomButton(
                    text: 'Download CV',
                    onPressed: () => _downloadCV(context),
                    isPrimary: false,
                    withConfetti: true,
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
