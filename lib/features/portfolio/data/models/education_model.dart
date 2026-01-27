import 'package:equatable/equatable.dart';

/// Education model representing educational background
class EducationModel extends Equatable {
  final String period;
  final String institution;
  final String degree;
  final String? grade;
  final String location;

  const EducationModel({
    required this.period,
    required this.institution,
    required this.degree,
    this.grade,
    required this.location,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      period: json['period'] as String,
      institution: json['institution'] as String,
      degree: json['degree'] as String,
      grade: json['grade'] as String?,
      location: json['location'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'period': period,
      'institution': institution,
      'degree': degree,
      'grade': grade,
      'location': location,
    };
  }

  @override
  List<Object?> get props => [period, institution, degree, grade, location];
}
