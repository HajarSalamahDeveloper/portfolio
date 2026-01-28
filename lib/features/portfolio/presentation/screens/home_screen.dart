import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/portfolio_cubit.dart';
import '../cubit/portfolio_state.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/experience_section.dart';
import '../widgets/sections/education_section.dart';
import '../widgets/sections/skills_section.dart';
import '../widgets/sections/projects_section.dart';
import '../widgets/sections/contact_section.dart';
import '../../../../config/app_colors.dart';
import '../../../../shared/widgets/floating_nav_bar.dart';
import '../../../../shared/widgets/interactive_star_field.dart';

/// Main home screen with all portfolio sections
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _projectsSectionKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToProjects() {
    final context = _projectsSectionKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveStarField(
        triggerOnHover: true,
        triggerOnTap: true,
        hoverThrottleMs: 80,
        child: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.backgroundGradient,
          ),
          child: BlocBuilder<PortfolioCubit, PortfolioState>(
            builder: (context, state) {
              if (state is PortfolioLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.accentCyan),
                );
              }

              if (state is PortfolioError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: AppColors.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.message,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              if (state is PortfolioLoaded) {
                return Stack(
                  children: [
                    // Main scrollable content
                    SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          HeroSection(
                            profile: state.profile,
                            onViewProjects: _scrollToProjects,
                          ),
                          AboutSection(profile: state.profile),
                          ExperienceSection(experiences: state.experiences),
                          EducationSection(education: state.education),
                          SkillsSection(skillCategories: state.skills),
                          ProjectsSection(
                            key: _projectsSectionKey,
                            projects: state.projects,
                          ),
                          ContactSection(profile: state.profile),
                        ],
                      ),
                    ),
                    // Floating navigation bar
                    Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: FloatingNavBar(
                        scrollController: _scrollController,
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
