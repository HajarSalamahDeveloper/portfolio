import 'package:equatable/equatable.dart';
import '../../data/models/profile_model.dart';
import '../../data/models/experience_model.dart';
import '../../data/models/education_model.dart';
import '../../data/models/skill_model.dart';
import '../../data/models/project_model.dart';

/// Base state for portfolio
abstract class PortfolioState extends Equatable {
  const PortfolioState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class PortfolioInitial extends PortfolioState {
  const PortfolioInitial();
}

/// Loading state
class PortfolioLoading extends PortfolioState {
  const PortfolioLoading();
}

/// Loaded state with all portfolio data
class PortfolioLoaded extends PortfolioState {
  final ProfileModel profile;
  final List<ExperienceModel> experiences;
  final List<EducationModel> education;
  final List<SkillCategoryModel> skills;
  final List<ProjectModel> projects;

  const PortfolioLoaded({
    required this.profile,
    required this.experiences,
    required this.education,
    required this.skills,
    required this.projects,
  });

  @override
  List<Object?> get props => [
    profile,
    experiences,
    education,
    skills,
    projects,
  ];
}

/// Error state
class PortfolioError extends PortfolioState {
  final String message;

  const PortfolioError(this.message);

  @override
  List<Object?> get props => [message];
}
