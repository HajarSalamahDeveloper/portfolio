import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../data/models/education_model.dart';
import '../../../../../config/app_colors.dart';
import '../../../../../config/app_text_styles.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../shared/widgets/section_header.dart';

/// Education section with card layout
class EducationSection extends StatefulWidget {
  final List<EducationModel> education;

  const EducationSection({super.key, required this.education});

  @override
  State<EducationSection> createState() => _EducationSectionState();
}

class _EducationSectionState extends State<EducationSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('education-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        width: double.infinity,
        padding: context.responsivePadding,
        child: Column(
          children: [
            const SectionHeader(title: 'Education'),
            const SizedBox(height: 48),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: widget.education.asMap().entries.map((entry) {
                final index = entry.key;
                final edu = entry.value;
                return _EducationCard(education: edu)
                    .animate(target: _isVisible ? 1 : 0)
                    .fadeIn(delay: (index * 150).ms, duration: 600.ms)
                    .slideY(begin: 0.3, end: 0, duration: 600.ms);
              }).toList(),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  final EducationModel education;

  const _EducationCard({required this.education});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.isMobile ? double.infinity : 350,
      padding: const EdgeInsets.all(24),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            education.period,
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.accentCyan,
            ),
          ),
          const SizedBox(height: 12),
          Text(education.institution, style: AppTextStyles.titleMedium),
          const SizedBox(height: 8),
          Text(education.degree, style: AppTextStyles.bodyMedium),
          if (education.grade != null) ...[
            const SizedBox(height: 8),
            Text(
              education.grade!,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.accentTeal,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
