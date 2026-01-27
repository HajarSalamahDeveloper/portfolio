import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../data/models/project_model.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../shared/widgets/section_header.dart';
import '../../../../../shared/widgets/project_card.dart';

/// Projects section with interactive cards
class ProjectsSection extends StatefulWidget {
  final List<ProjectModel> projects;

  const ProjectsSection({super.key, required this.projects});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('projects-section'),
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
            const SectionHeader(title: 'Projects'),
            const SizedBox(height: 48),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: widget.projects.asMap().entries.map((entry) {
                final index = entry.key;
                final project = entry.value;
                return ProjectCard(project: project)
                    .animate(target: _isVisible ? 1 : 0)
                    .fadeIn(delay: (index * 150).ms, duration: 600.ms)
                    .scale(begin: const Offset(0.8, 0.8), duration: 600.ms);
              }).toList(),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
