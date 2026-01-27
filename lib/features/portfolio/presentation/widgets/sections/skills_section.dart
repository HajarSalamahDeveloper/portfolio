import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../data/models/skill_model.dart';
import '../../../../../config/app_colors.dart';
import '../../../../../config/app_text_styles.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../shared/widgets/section_header.dart';
import '../../../../../shared/widgets/animated_skill_bar.dart';

/// Skills section with animated progress bars
class SkillsSection extends StatefulWidget {
  final List<SkillCategoryModel> skillCategories;

  const SkillsSection({super.key, required this.skillCategories});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('skills-section'),
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
            const SectionHeader(title: 'Skills & Knowledge'),
            const SizedBox(height: 48),
            Container(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.skillCategories.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 40),
                itemBuilder: (context, categoryIndex) {
                  final category = widget.skillCategories[categoryIndex];
                  return _SkillCategoryWidget(
                    category: category,
                    isVisible: _isVisible,
                    delay: categoryIndex * 100,
                  );
                },
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _SkillCategoryWidget extends StatelessWidget {
  final SkillCategoryModel category;
  final bool isVisible;
  final int delay;

  const _SkillCategoryWidget({
    required this.category,
    required this.isVisible,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
              category.category,
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.accentCyan,
              ),
            )
            .animate(target: isVisible ? 1 : 0)
            .fadeIn(delay: delay.ms, duration: 600.ms)
            .slideX(begin: -0.3, end: 0, duration: 600.ms),
        const SizedBox(height: 16),
        ...category.skills.asMap().entries.map((entry) {
          final skillIndex = entry.key;
          final skill = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AnimatedSkillBar(
              skill: skill,
              isVisible: isVisible,
              delay: delay + (skillIndex * 50),
            ),
          );
        }),
      ],
    );
  }
}
