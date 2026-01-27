import 'package:flutter/material.dart';
import '../../../features/portfolio/data/models/experience_model.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';

/// Timeline item widget for experience entries
class ExperienceTimelineItem extends StatelessWidget {
  final ExperienceModel experience;
  final bool isLast;

  const ExperienceTimelineItem({
    super.key,
    required this.experience,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.accentGradient,
                boxShadow: [
                  BoxShadow(color: AppColors.glowCyan, blurRadius: 8),
                ],
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.accentCyan,
                      AppColors.accentCyan.withOpacity(0.3),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 24),
        // Content
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.backgroundCard,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowMedium,
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  experience.period,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.accentCyan,
                  ),
                ),
                const SizedBox(height: 8),
                Text(experience.position, style: AppTextStyles.titleMedium),
                const SizedBox(height: 4),
                Text(
                  '${experience.company} | ${experience.location}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                ...experience.responsibilities.map((responsibility) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '• ',
                          style: TextStyle(
                            color: AppColors.accentTeal,
                            fontSize: 16,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            responsibility,
                            style: AppTextStyles.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
