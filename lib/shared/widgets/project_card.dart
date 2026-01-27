import 'package:flutter/material.dart';
import '../../../features/portfolio/data/models/project_model.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../core/utils/extensions.dart';
import '../../core/utils/url_launcher_helper.dart';

/// Interactive project card with glassmorphism effect
class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -8.0 : 0.0),
        width: context.isMobile ? double.infinity : 350,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.backgroundCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? AppColors.accentCyan.withOpacity(0.5)
                  : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered ? AppColors.glowCyan : AppColors.shadowMedium,
                blurRadius: _isHovered ? 25 : 20,
                offset: Offset(0, _isHovered ? 15 : 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.project.name,
                style: AppTextStyles.titleLarge.copyWith(
                  color: _isHovered
                      ? AppColors.accentCyan
                      : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.project.description,
                style: AppTextStyles.bodyMedium,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              // Technologies
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.project.technologies.map((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColors.accentCyan.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      tech,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.accentCyan,
                      ),
                    ),
                  );
                }).toList(),
              ),
              if (widget.project.playStoreUrl != null) ...[
                const SizedBox(height: 16),
                InkWell(
                  onTap: () =>
                      UrlLauncherHelper.launchURL(widget.project.playStoreUrl!),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.launch,
                        size: 16,
                        color: AppColors.accentTeal,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'View on Play Store',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.accentTeal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
