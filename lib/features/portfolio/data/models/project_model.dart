import 'package:equatable/equatable.dart';

/// Project model representing portfolio projects
class ProjectModel extends Equatable {
  final String name;
  final String description;
  final String? playStoreUrl;
  final List<String> technologies;

  const ProjectModel({
    required this.name,
    required this.description,
    this.playStoreUrl,
    required this.technologies,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      name: json['name'] as String,
      description: json['description'] as String,
      playStoreUrl: json['playStoreUrl'] as String?,
      technologies: (json['technologies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'playStoreUrl': playStoreUrl,
      'technologies': technologies,
    };
  }

  @override
  List<Object?> get props => [name, description, playStoreUrl, technologies];
}
