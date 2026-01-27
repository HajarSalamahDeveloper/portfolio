import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../data/models/experience_model.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../shared/widgets/section_header.dart';
import '../../../../../shared/widgets/experience_timeline_item.dart';

/// Experience section with timeline
class ExperienceSection extends StatefulWidget {
  final List<ExperienceModel> experiences;

  const ExperienceSection({super.key, required this.experiences});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('experience-section'),
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
            const SectionHeader(title: 'Experience'),
            const SizedBox(height: 48),
            Container(
              constraints: const BoxConstraints(maxWidth: 900),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.experiences.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 32),
                itemBuilder: (context, index) {
                  return ExperienceTimelineItem(
                        experience: widget.experiences[index],
                        isLast: index == widget.experiences.length - 1,
                      )
                      .animate(target: _isVisible ? 1 : 0)
                      .fadeIn(delay: (index * 200).ms, duration: 600.ms)
                      .slideX(
                        begin: index.isEven ? -0.3 : 0.3,
                        end: 0,
                        duration: 600.ms,
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
