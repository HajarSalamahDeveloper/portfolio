import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../data/models/profile_model.dart';
import '../../../../../config/app_colors.dart';
import '../../../../../config/app_text_styles.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/url_launcher_helper.dart';
import '../../../../../shared/widgets/section_header.dart';
import '../../../../../shared/widgets/custom_button.dart';

/// Contact section with social links and CV download
class ContactSection extends StatefulWidget {
  final ProfileModel profile;

  const ContactSection({super.key, required this.profile});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('contact-section'),
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
            const SectionHeader(title: 'Get In Touch'),
            const SizedBox(height: 48),
            Container(
                  constraints: const BoxConstraints(maxWidth: 600),
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
                  child: Column(
                    children: [
                      // Email
                      _ContactItem(
                        icon: Icons.email_outlined,
                        text: widget.profile.email,
                        onTap: () =>
                            UrlLauncherHelper.launchEmail(widget.profile.email),
                      ),
                      const SizedBox(height: 16),
                      // Phone
                      _ContactItem(
                        icon: Icons.phone_outlined,
                        text: widget.profile.phone,
                        onTap: () =>
                            UrlLauncherHelper.launchPhone(widget.profile.phone),
                      ),
                      const SizedBox(height: 16),
                      // GitHub
                      _ContactItem(
                        icon: Icons.code,
                        text: 'GitHub',
                        onTap: () => UrlLauncherHelper.launchURL(
                          widget.profile.githubUrl,
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Download CV Button
                      CustomButton(
                        text: 'Download CV',
                        onPressed: () {
                          // TODO: Implement CV download
                        },
                        isPrimary: true,
                      ),
                    ],
                  ),
                )
                .animate(target: _isVisible ? 1 : 0)
                .fadeIn(duration: 800.ms)
                .slideY(begin: 0.3, end: 0, duration: 800.ms),
            const SizedBox(height: 48),
            // Footer
            Text(
              '© 2025 ${widget.profile.fullName}. All rights reserved.',
              style: AppTextStyles.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _ContactItem({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, color: AppColors.accentCyan),
            const SizedBox(width: 16),
            Expanded(child: Text(text, style: AppTextStyles.bodyLarge)),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
