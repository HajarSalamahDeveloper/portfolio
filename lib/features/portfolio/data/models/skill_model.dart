import 'package:equatable/equatable.dart';

/// Skill model representing a skill with proficiency level
class SkillModel extends Equatable {
  final String name;
  final double level; // 0.0 to 1.0

  const SkillModel({required this.name, required this.level});

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      name: json['name'] as String,
      level: (json['level'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'level': level};
  }

  @override
  List<Object?> get props => [name, level];
}

/// Skill category model grouping skills by category
class SkillCategoryModel extends Equatable {
  final String category;
  final List<SkillModel> skills;

  const SkillCategoryModel({required this.category, required this.skills});

  factory SkillCategoryModel.fromJson(
    String category,
    List<dynamic> skillsJson,
  ) {
    return SkillCategoryModel(
      category: category,
      skills: skillsJson
          .map((json) => SkillModel.fromJson(json as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'skills': skills.map((skill) => skill.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [category, skills];
}
