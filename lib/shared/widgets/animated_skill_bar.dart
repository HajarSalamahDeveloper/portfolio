import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../features/portfolio/data/models/skill_model.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../core/utils/extensions.dart';

/// Animated skill progress bar
class AnimatedSkillBar extends StatelessWidget {
  final SkillModel skill;
  final bool isVisible;
  final int delay;

  const AnimatedSkillBar({
    super.key,
    required this.skill,
    required this.isVisible,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                skill.name,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Text(
              skill.level.toPercentage(),
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.accentCyan,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: isVisible ? skill.level : 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.accentGradient,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(color: AppColors.glowCyan, blurRadius: 8),
                    ],
                  ),
                ),
              ),
            )
            .animate(target: isVisible ? 1 : 0)
            .custom(
              delay: delay.ms,
              duration: 1000.ms,
              builder: (context, value, child) {
                return Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: value * skill.level,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: AppColors.accentGradient,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(color: AppColors.glowCyan, blurRadius: 8),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      ],
    );
  }
}
