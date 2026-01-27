import '../models/profile_model.dart';
import '../models/experience_model.dart';
import '../models/education_model.dart';
import '../models/skill_model.dart';
import '../models/project_model.dart';
import '../../../../config/portfolio_data.dart';

/// Repository for fetching portfolio data
class PortfolioRepository {
  /// Get profile information
  ProfileModel getProfile() {
    return ProfileModel(
      fullName: PortfolioData.fullName,
      title: PortfolioData.title,
      location: PortfolioData.location,
      email: PortfolioData.email,
      phone: PortfolioData.phone,
      githubUrl: PortfolioData.githubUrl,
      profileSummary: PortfolioData.profileSummary,
    );
  }

  /// Get all work experiences
  List<ExperienceModel> getExperiences() {
    return PortfolioData.experiences
        .map((json) => ExperienceModel.fromJson(json))
        .toList();
  }

  /// Get all education entries
  List<EducationModel> getEducation() {
    return PortfolioData.education
        .map((json) => EducationModel.fromJson(json))
        .toList();
  }

  /// Get all skills grouped by category
  List<SkillCategoryModel> getSkills() {
    return PortfolioData.skills.entries
        .map((entry) => SkillCategoryModel.fromJson(entry.key, entry.value))
        .toList();
  }

  /// Get all projects
  List<ProjectModel> getProjects() {
    return PortfolioData.projects
        .map((json) => ProjectModel.fromJson(json))
        .toList();
  }

  /// Get all portfolio data at once
  Future<Map<String, dynamic>> getAllPortfolioData() async {
    // Simulate async operation
    await Future.delayed(const Duration(milliseconds: 500));

    return {
      'profile': getProfile(),
      'experiences': getExperiences(),
      'education': getEducation(),
      'skills': getSkills(),
      'projects': getProjects(),
    };
  }
}
