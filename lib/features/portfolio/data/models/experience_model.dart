import 'package:equatable/equatable.dart';

/// Experience model representing work experience entries
class ExperienceModel extends Equatable {
  final String period;
  final String company;
  final String location;
  final String position;
  final List<String> responsibilities;

  const ExperienceModel({
    required this.period,
    required this.company,
    required this.location,
    required this.position,
    required this.responsibilities,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      period: json['period'] as String,
      company: json['company'] as String,
      location: json['location'] as String,
      position: json['position'] as String,
      responsibilities: (json['responsibilities'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'period': period,
      'company': company,
      'location': location,
      'position': position,
      'responsibilities': responsibilities,
    };
  }

  @override
  List<Object?> get props => [
    period,
    company,
    location,
    position,
    responsibilities,
  ];
}
