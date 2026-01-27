import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../data/models/profile_model.dart';
import '../../../../../config/app_colors.dart';
import '../../../../../config/app_text_styles.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../shared/widgets/section_header.dart';

/// About section with profile summary
class AboutSection extends StatefulWidget {
  final ProfileModel profile;

  const AboutSection({super.key, required this.profile});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('about-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        width: double.infinity,
        padding: context.responsivePadding,
        child: Column(
          children: [
            const SectionHeader(title: 'About Me'),
            const SizedBox(height: 48),
            Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundCard,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowMedium,
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Text(
                    widget.profile.profileSummary,
                    style: AppTextStyles.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                )
                .animate(target: _isVisible ? 1 : 0)
                .fadeIn(duration: 800.ms)
                .slideY(begin: 0.3, end: 0, duration: 800.ms),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
